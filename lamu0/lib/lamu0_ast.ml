open Final
module Map = BatMap

type expr =
  | Let : (string * expr * expr) -> expr
  | Lam : (string * expr) -> expr
  | App : (expr * expr) -> expr
  | Lit : (litype * string) -> expr
  | Var : string -> expr
 [@@deriving show { with_path = false }]

let show_ast : expr -> unit = fun e -> print_endline @@ show_expr e

module SYMNumber() = struct
   type r = int64
   let cnt = ref Int64.zero
   let get() =
       let i = !cnt in
       cnt := Int64.add Int64.one i;
       i
   let letl _ _ _ = get()
   let lam _ _ = get()
   let app _ _ = get()
   let lit _ _ = get()
   let var _ = get()
end

module FSYMAst = struct
  type o
  type c = expr
  type r = {o: o; c: c}
  let combine o c = {o; c}
  let project {o; _} = o

  let letl _ n {c=e1;_} {c=e2; _} = Let(n, e1, e2)
  let lam _ s {c=e;_} = Lam(s, e)
  let app _ {c=f;_} {c=arg; _} = App(f, arg)
  let lit _ lt s = Lit(lt, s)
  let var _ n = Var n
end

module Scoping = Remu_scope.Solve

type scopedesc =
  | Sym of Scoping.sym
  | ScopeUnrelated

type scopeinfo = {desc: scopedesc; i: Scoping.scoperef}

module type STScope = sig
  type o
  type c = scopeinfo Lazy.t
  type r
  val env : Scoping.env
  val cur_scoperef : Scoping.scoperef ref
  val combine: o -> c -> r
  val project: r -> o
end


module FSYMScope(ST : STScope) = struct
  include ST

  let subscope () = Scoping.subscope ST.env (!ST.cur_scoperef)
  let enter n =  Scoping.enter ST.env  (!ST.cur_scoperef) n
  let require n =  Scoping.require ST.env (!ST.cur_scoperef) n
  let scope () = Scoping.env_get ST.env (!ST.cur_scoperef)
  let with_scope si' f =
    let si = !ST.cur_scoperef in
      ST.cur_scoperef := si';
      let ret = f() in
      ST.cur_scoperef := si;
      {desc=ret; i=si}

  let letl _ n e1 e2 = lazy begin
    let _ = Lazy.force e1 in
    let si' = subscope() in
    with_scope si' @@ fun () ->
    let _ = enter n in
    (* for letrec, e1 = e1 (env, si') *)
    let _ = Lazy.force e2 in
    ScopeUnrelated end

  let lam n e = lazy begin
    let si' = subscope () in
    with_scope si' @@ fun () ->
    let _ = enter n in
    let _ = Lazy.force e in
    ScopeUnrelated end
  let app f a = lazy begin
    let _ = Lazy.force f in
    let _ = Lazy.force a in
    ScopeUnrelated end
  let lit _ _ = lazy ScopeUnrelated
  let var s = lazy begin
    Sym (require s) end
end

module Typing = Remu_ts.Infer
module type STType = sig
  type o
  type c = Typing.t Lazy.t
  type r
  val combine: o -> c -> r
  val project: r -> o

  val tc: (module Typing.TState)

  val rtype: r -> Typing.t

  val ntype: o -> Scoping.name -> Typing.t
  val ann: o -> Scoping.name -> Typing.t -> unit

  (* basic types *)
  val intt: Typing.t
  val strt: Typing.t
  val floatt: Typing.t
end


exception TypeError
module FSYMType(ST: STType) = struct
  include ST
  module TC = (val tc)
  open TC

  let letl o n e1 e2 = lazy begin
    let eo2 = project e2 in
     let var_of_n = new_tvar() in
     ann eo2 n var_of_n;
     if unify var_of_n (rtype e1) then
       rtype e2
     else
       raise TypeError end
  let lam o n e = lazy begin
    let eo = project e in
    let var_of_arg = new_tvar() in
    ann eo n var_of_arg;
    Typing.Arrow(var_of_arg, rtype e) end

  let app _ f a = lazy begin
    let var_of_ret = new_tvar() in
    let var_of_arg = new_tvar() in
    if unify (rtype f) (Typing.Arrow (var_of_arg, var_of_ret)) &&
       unify (rtype a) var_of_ret then
       var_of_ret
    else
      raise TypeError end
  let lit _ lt v = lazy begin
      match lt with
      | StringT -> strt
      | IntT -> intt
      | FloatT -> floatt end
  let var o n = lazy (ntype o n)
end

