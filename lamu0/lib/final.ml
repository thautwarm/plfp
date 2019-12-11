type litype = IntT | FloatT | StringT
[@@deriving show { with_path = false }]

module type PSYM = sig
   type spot
   type extra
   val letl : extra -> string -> (extra * spot) -> (extra * spot) -> spot
   val lam : extra -> string -> (extra * spot) -> spot
   val app : extra -> (extra * spot) -> (extra * spot) -> spot
   val lit : extra -> litype -> string -> spot
   val var : extra -> string -> spot
end

(* to handle tagless final interpretations with DAG dependencies *)
module type FSYM = sig
  type r
  type c
  type o
  val combine: o -> c -> r
  val project: r -> o

  val letl : o -> string -> r -> r -> c
  val lam  : o -> string -> r -> c
  val app  : o -> r -> r -> c
  val lit  : o -> litype -> string -> c
  val var  : o -> string -> c
end

module type SYM = sig
  type r
  val letl : string -> r -> r -> r
  val lam  : string -> r -> r
  val app  : r -> r -> r
  val lit  : litype -> string -> r
  val var  : string -> r
end

let grow = fun
   (type o c r')
   (module Base: SYM with type r = o)
   (module Incr: FSYM with type r = r' and type c = c and type o = o) ->
   (module struct
      type r = r'
      let letl n e1 e2 =
          let e1o = Incr.project e1 in
          let e2o = Incr.project e2 in
          let o = Base.letl n e1o e2o in
          let c = Incr.letl o n e1 e2 in
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
   end: SYM with type r = r')

(* the initial alg for better polymorphic use*)
module SYMSelf = struct
  type r = {e: 'a . (module SYM with type r = 'a) -> 'a}
  let letl : string -> r -> r -> r =
    fun s {e=e1} {e=e2} ->
    {e = fun (type a) ((module M: SYM with type r = a) as m) -> M.letl s (e1 m) (e2 m)}
  let lam : string -> r -> r =
    fun s {e} ->
    {e = fun (type a) ((module M: SYM with type r = a) as m) -> M.lam s (e m)}
  let app : r -> r -> r =
    fun {e=f} {e=arg} ->
    {e = fun (type a) ((module M: SYM with type r = a) as m) -> M.app (f m) (arg m)}
  let lit : litype -> string -> r =
    fun lt s ->
    {e = fun (type a) (module M: SYM with type r = a) -> M.lit lt s}
  let var : string -> r =
    fun s ->
    {e = fun (type a) (module M: SYM with type r = a) -> M.var s}
end

let run = fun (type a) ((module M: SYM with type r = a) as m) -> SYMSelf.(fun {e} -> e m)

