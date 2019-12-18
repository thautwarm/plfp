open Lamu1
open Final
open Phrases

let term =
  let open SYMSelf in
  letl "a" None (lit IntT "23") (var "a")

let apply_phrases (term : Final.SYMSelf.r) =
  let records : (int * Scoping.repr Lazy.t * Typing.repr Lazy.t) array ref =
    ref [||]
  in
  let tc_env = Typing.crate_tc @@ Typing.empty_tctx in
  let module TC = (val tc_env) in
  let scope_env = Scoping.empty_env () in
  let term_cnt = ref 0 in
  let symtypes : (Scoping.sym, Typing.repr) BatMap.t ref = ref BatMap.empty in

  let numer = Phrases.numbering term_cnt in
  let module P1 = struct
    type t = int * Scoping.repr Lazy.t
  end in
  let module P2 = struct
    type t = int * Scoping.repr Lazy.t * Typing.repr Lazy.t
  end in
  let scoper =
    Phrases.scoping
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
    Phrases.recording
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

let _ =
    let res = apply_phrases term in
    let open Remu_ts in
    print_endline @@ Builder.dumpstr (Builder.mk_show_named_nom (res#tc)) res#typ
