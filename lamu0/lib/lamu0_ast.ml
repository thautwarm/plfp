open Final

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
  val get: r -> scopeinfo
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

  let return desc = {desc=desc; i = !ST.cur_scoperef}
  let letl : o -> string -> r -> r -> c = fun _ n e1 e2 -> lazy begin
    let _ = get e1 in
    let si' = subscope() in
    with_scope si' @@ fun () ->
    let _ = enter n in
    (* for letrec, e1 = e1 (env, si') *)
    let _ = get e2 in
    ScopeUnrelated end

  let lam: o -> string -> r -> c = fun _ n e -> lazy begin
    let si' = subscope () in
    with_scope si' @@ fun () ->
    let _ = enter n in
    let _ = get e in
    ScopeUnrelated end
  let app: o -> r -> r -> c = fun _ f a -> lazy begin
    let _ = get f in
    let _ = get a in
    return ScopeUnrelated
    end
  let lit: o -> litype -> string -> c = fun _ _ _ -> lazy (return ScopeUnrelated)
  let var: o -> string -> c = fun _ s -> lazy begin
    return @@ Sym (require s) end
end

module Typing = Remu_ts.Infer
module type STType = sig
  type o
  type c = Typing.t Lazy.t
  type r
  val combine: o -> c -> r
  val project: r -> o

  (* type checking states *)
  val tc: (module Typing.TState)

  (* from repr to type *)
  val rtype: r -> Typing.t

  (* from symbol to type *)
  val ntype: o -> Scoping.name -> Typing.t

  (* annotate symbol's type *)
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
       unify (rtype a) var_of_arg then
       var_of_ret
    else
       raise TypeError end
  let lit _ lt v = lazy begin
      match lt with
      | StringT -> strt
      | IntT -> intt
      | FloatT -> floatt end
  let var o n =
     lazy begin
       let var1 = new_tvar() in
       let var2 = ntype o n in
       if unify var1 var2 then var1
       else raise TypeError
     end
end

module DArr = Remu_scope.Solve.DArr
module SYMNumber() = struct
   let cnt = ref 0
   type r = int Lazy.t
   let get() =
     lazy begin
     let i = !cnt in
     incr cnt;
     i
     end
   let (!!) a = Lazy.force a |> ignore
   let letl  _ a b = !!a; !!b; get()
   let lam _ a = !!a; get()
   let app a b = !!a; !!b; get()
   let lit _ _ = get()
   let var _ = get()
end

module type STAgg = sig
  type o
  type c = ()
  type r = o
  val store : r DArr.arr
  val idx: r -> int
end
module FSYMAgg(ST: STAgg) = struct
   include ST
   let combine (o:o) () =
     DArr.append store o;
     o
   let project (o: o) = o
   let letl _  _ _ _ = ()
   let lam _ _ _ = ()
   let app _ _ _ = ()
   let lit _ _ _ = ()
   let var _ _ = ()
end

