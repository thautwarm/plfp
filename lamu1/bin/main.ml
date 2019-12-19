open Lamu1.Parser
open Lamu1.Lexer
open Lamu1.Final
open Lamu1.Phases
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
   exit @@ -1


let apply_phases term =
  let records : (int * Scoping.repr Lazy.t * Typing.repr Lazy.t) array ref =
    ref [||]
  in
  let tc_env = Typing.crate_tc @@ Typing.empty_tctx in
  let module TC = (val tc_env) in
  let scope_env = Scoping.empty_env () in
  let term_cnt = ref 0 in
  let symtypes : (Scoping.sym, Typing.repr) BatMap.t ref = ref BatMap.empty in

  let numer = numbering term_cnt in
  let module P1 = struct
    type t = int * Scoping.repr Lazy.t
  end in
  let module P2 = struct
    type t = int * Scoping.repr Lazy.t * Typing.repr Lazy.t
  end in
  let scoper =
    scoping
    @@ object
         method combine : int -> Scoping.repr Lazy.t -> P1.t =
           fun l r -> l, r

         method project = fst

         method env = scope_env

         method get (_, r) = Lazy.force r
       end
  in
  let typer =
    let lookup_syms s = BatMap.find s !symtypes in
    let update_syms t s =
      symtypes := BatMap.modify_def t s (fun a -> a) !symtypes
    in
    let open TC in
    typing
    @@ object
         method combine : P1.t -> Typing.repr Lazy.t -> P2.t =
           fun (a, b) c -> (a, b, c)

         method project : P2.t -> P1.t = fun (a, b, _) -> (a, b)

         method env = tc_env

         method type_of_name : P1.t -> Scoping.name -> Typing.repr =
           let open Scoping in
           fun (_, scope) n ->
             let scope = Lazy.force scope in
             let { freevars; boundvars; _ } =
               Scoping.env_get scope_env scope.id
             in
             lookup_syms
             @@
             try BatMap.find n freevars
             with Not_found -> BatMap.find n boundvars

         method annotate : P1.t -> string -> Typing.repr -> unit =
           let open Scoping in
           fun (i, scope) n t ->
             let scope = Lazy.force scope in
             let { freevars; boundvars; _ } =
               Scoping.env_get scope_env scope.id
             in
             update_syms t
             @@
             try BatMap.find n freevars
             with Not_found -> BatMap.find n boundvars

         method type_of_repr : P2.t -> Typing.repr =
           fun (i, _, _) ->
             let _, _, t = !records.(i) in
             Lazy.force t

         method int_type = TC.new_type "int"

         method float_type = TC.new_type "float"

         method str_type = TC.new_type "str"
       end
  in
  let recorder =
    recording
    @@ object
         method store = records

         method cnt = term_cnt

         method id_of_repr : P2.t -> int = fun (i, _, _) -> i
       end
  in
  let ( |> ) = grow in
  let (_, scope, t), init = run (numer |> scoper |> typer |> recorder) term in
  records := Array.make !term_cnt (Obj.magic 0);
  init();
  ignore @@ Lazy.force scope;
  object
    method typ = TC.prune @@ Lazy.force t
    method tc = tc_env
  end


let flip f a b = f b a
let _ =
  let rec repl() =
    let buf = Lexing.from_channel stdin in
    let bs = List.fold_right List.cons (run_parser buf) [] in
    (flip List.iteri) bs @@ fun i term ->
    let res = apply_phases term in
    let open Remu_ts in
    Printf.printf "=> expr%d : %s\n" i @@
        Builder.dumpstr (Builder.mk_show_named_nom @@ res#tc) res#typ;
    repl()
  in repl()
