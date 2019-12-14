open Lamu0.Lamu0_parser
open Lamu0.Lamu0_lex
open Lamu0.Lamu0_ast
open Lamu0.Final
open Printf
open Lexing
module Builder = Remu_ts.Builder

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let run_parser lexbuf =
  try
    prog read lexbuf
  with
  | Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)

module App(Q: sig
     val tagless: SYMSelf.r
end) = struct

module Num = SYMNumber()
let num = (module Num : SYM with type r = int Lazy.t)
module MyST = struct
  let scope_env = Scoping.empty_env()
  type ft = int * scopeinfo Lazy.t * Typing.t Lazy.t
  let tenv : (int64 * Typing.t) list ref = ref []
  let store : ft DArr.arr = DArr.empty()
end

module MySTScope = struct
  type o = int Lazy.t
  type r = int * scopeinfo Lazy.t
  type c = scopeinfo Lazy.t
  let env = MyST.scope_env
  let cur_scoperef = ref 0
  let combine o c = Lazy.force o, c
  let project (o, c) = Lazy.from_val o
  let get ((_, c):r) = Lazy.force c
end

module MySYMScopeF = FSYMScope(MySTScope)
module MySYMScope = (val grow num (module MySYMScopeF))

module MySTType = struct
   type o = int * scopeinfo Lazy.t
   type c = Typing.t Lazy.t
   type r = int * scopeinfo Lazy.t * c
   let combine ((i, o): o) (c: c) = i, o, c
   let project (i, o, c) = i, o
   let tc = Typing.crate_tc (Typing.empty_tctx)
   let rtype ((i, _, c): r) =
     let _, _, t = DArr.get i MyST.store in Lazy.force t
   let ntype ((_, sc): o) n =
     let i = (Lazy.force sc).i in
     let Scoping.({boundvars; freevars; _}) = Scoping.env_get MyST.scope_env i in
     let sym = try BatMap.find n boundvars
               with Not_found ->
               BatMap.find n freevars
     in List.assoc sym.uid (!MyST.tenv)
   let ann ((_, sc):o) n t =
     let i = (Lazy.force sc).i in
     let Scoping.({boundvars; freevars; _}) = Scoping.env_get MyST.scope_env i in
     let sym = try BatMap.find n boundvars
               with Not_found ->
               BatMap.find n freevars
     in MyST.tenv := (sym.uid, t) :: !MyST.tenv
   module TC = (val tc)
   open TC
   let intt = TC.new_type "int"
   let floatt = TC.new_type "float"
   let strt = TC.new_type "string"
end

module MySYMTypeF = FSYMType(MySTType)
module MySYMType =
   (val grow (module MySYMScope) (module MySYMTypeF))

module MySTAgg = struct
  type o = MyST.ft
  type c = ()
  type r = o
  let store = MyST.store
  let idx: r -> int = fun (i, _, _) -> i
end

module SYMAggF = FSYMAgg(MySTAgg)
module SYMAgg =
  (val grow  (module MySYMType : SYM with type r = int * scopeinfo Lazy.t * Typing.t Lazy.t)
             (module SYMAggF))

let (number_of_term, scope, type') = run (module SYMAgg) Q.tagless
let return =
    let _ = Lazy.force scope in
    let type' = Lazy.force type' in
    MySTType.TC.prune @@ type'
end

let flip f a b = f b a
let _ =
  let rec repl() =
    let buf = Lexing.from_channel stdin in
    let bs = List.fold_right List.cons (run_parser buf) [] in
    (flip List.iteri) bs @@ fun i res ->
    let module M = App(struct let tagless = res end) in
    Printf.printf "=> expr%d : %s\n" i @@
        Builder.dumpstr (Builder.mk_show_named_nom (module M.MySTType.TC)) M.return;
    print_newline();
    repl()
  in repl()
