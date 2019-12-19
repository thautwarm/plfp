type litype = IntT | FloatT | StringT
module Typ = Remu_ts.Infer

module type SYM = sig
  type repr
  val letl : string -> Type_final.SYMSelf.r option -> repr -> repr -> repr
  val lam  : string -> repr -> repr
  val app  : repr -> repr -> repr
  val lit  : litype -> string -> repr
  val var  : string -> repr
end
module type FSYMComm = sig
  type r
  type c
  type o
  val combine: o -> c -> r
  val project: r -> o
end

(* to handle tagless final interpretations with DAG dependencies *)

module type FSYM = sig
  include FSYMComm

  val letl : o -> string -> Type_final.SYMSelf.r option -> r -> r -> c
  val lam  : o -> string -> r -> c
  val app  : o -> r -> r -> c
  val lit  : o -> litype -> string -> c
  val var  : o -> string -> c
end

let grow = fun
   (type o c r')
   (module Base: SYM with type repr = o)
   (module Incr: FSYM with type r = r' and type c = c and type o = o) ->
   (module struct
      type repr = r'
      let letl n t e1 e2 =
          let e1o = Incr.project e1 in
          let e2o = Incr.project e2 in
          let o = Base.letl n t e1o e2o in
          let c = Incr.letl o n t e1 e2 in
          Incr.combine o c
      let lam n e =
          let eo = Incr.project e in
          let o = Base.lam n eo in
          let c = Incr.lam o n e in
          Incr.combine o c
      let app f a =
          let fo = Incr.project f in
          let ao = Incr.project a in
          let o = Base.app fo ao in
          let c = Incr.app o f a in
          Incr.combine o c
      let lit lt a =
          let o  = Base.lit lt a in
          let c = Incr.lit o lt a in
          Incr.combine o c
      let var n =
          let o = Base.var n in
          let c = Incr.var o n in
          Incr.combine o c
   end: SYM with type repr = r')

(* the initial alg for better polymorphic use*)
module SYMSelf = struct
  type r = {e: 'a . (module SYM with type repr = 'a) -> 'a}
  let letl : string -> Type_final.SYMSelf.r option -> r -> r -> r =
    fun s t {e=e1} {e=e2} ->
    {e = fun (type a) ((module M: SYM with type repr = a) as m) -> M.letl s t (e1 m) (e2 m)}
  let lam : string -> r -> r =
    fun s {e} ->
    {e = fun (type a) ((module M: SYM with type repr = a) as m) -> M.lam s (e m)}
  let app : r -> r -> r =
    fun {e=f} {e=arg} ->
    {e = fun (type a) ((module M: SYM with type repr = a) as m) -> M.app (f m) (arg m)}
  let lit : litype -> string -> r =
    fun lt s ->
    {e = fun (type a) (module M: SYM with type repr = a) -> M.lit lt s}
  let var : string -> r =
    fun s ->
    {e = fun (type a) (module M: SYM with type repr = a) -> M.var s}
end

let run = fun (type a) ((module M: SYM with type repr = a) as m) -> SYMSelf.(fun {e} -> e m)
