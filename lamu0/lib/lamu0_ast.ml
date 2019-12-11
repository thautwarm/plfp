type litype = IntT | FloatT | StringT
[@@deriving show { with_path = false }]

module type SYM = sig
  type t
  val letl : string -> t -> t -> t
  val lam  : string -> t -> t
  val app  : t -> t -> t
  val lit  : litype -> string -> t
  val var  : string -> t
end

type sym = {e: 'a . (module SYM with type t = 'a) -> 'a}

module SYMSelf = struct
  type t = sym
  let letl : string -> t -> t -> t =
    fun s {e=e1} {e=e2} ->
    {e = fun (type a) ((module M: SYM with type t = a) as m) -> M.letl s (e1 m) (e2 m)}
  let lam : string -> t -> t =
    fun s {e} ->
    {e = fun (type a) ((module M: SYM with type t = a) as m) -> M.lam s (e m)}
  let app : t -> t -> t =
    fun {e=f} {e=arg} ->
    {e = fun (type a) ((module M: SYM with type t = a) as m) -> M.app (f m) (arg m)}
  let lit : litype -> string -> t =
    fun lt s ->
    {e = fun (type a) (module M: SYM with type t = a) -> M.lit lt s}
  let var : string -> t =
    fun s ->
    {e = fun (type a) (module M: SYM with type t = a) -> M.var s}
end

type expr =
  | Let : (string * expr * expr) -> expr
  | Lam : (string * expr) -> expr
  | App : (expr * expr) -> expr
  | Lit : (litype * string) -> expr
  | Var : string -> expr
[@@deriving show { with_path = false }]

let show_ast : expr -> unit = fun e -> print_endline @@ show_expr e


let run = fun (type a) ((module M: SYM with type t = a) as m) {e} -> e m

module SYMAst = struct
  type t = expr
  let letl n e1 e2 = Let(n, e1, e2)
  let lam s e = Lam(s, e)
  let app f arg = App(f, arg)
  let lit lt s = Lit(lt, s)
  let var n = Var n
end

module SYMNumber() = struct
   type t = int64
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

module SYMScope() = struct
  open Remu_scope.Solve

  type scopeinfo =
  | Sym of sym
  | Scope of scope
  | ScopeUnrelated
  type t = (env * scoperef) -> scopeinfo
  let letl n e1 e2 (env, si) =
    let _ = e1 (env, si) in
    let si' = subscope env si in
    let _ = enter env si' n in
    (* for letrec, e1 = e1 (env, si') *)
    let _ = e2 (env, si') in
    Scope (env_get env si')
  let lam n e (env, si)=
    let si' = subscope env si in
    let _ = enter env si' n in
    let _ = e (env, si') in
    Scope (env_get env si')
  let app f a pair =
    let _ = f pair in
    let _ = a pair in
    ScopeUnrelated
  let lit _ _ _ = ScopeUnrelated
  let var s (env, si) = Sym (require env si s)
end

(* tagless zipper *)
let zipT = fun
  (type a b)
  ((module M1: SYM with type t = a),  (module M2: SYM with type t = b)) ->
  (module struct
      type t = a * b
      let letl n e1 e2 =
         let (e1a, e1b) = e1 in
         let (e2a, e2b) = e2 in
         let letla = M1.(letl n e1a e2a) in
         let letlb = M2.(letl n e1b e2b) in
         (letla, letlb)
      let lam n (ea, eb) =
         let lama = M1.(lam n ea) in
         let lamb = M2.(lam n eb) in
         (lama, lamb)
      let app (fa, fb) (aa, ab) =
         let appa = M1.(app fa aa) in
         let appb = M2.(app fb ab) in
         (appa, appb)
      let lit litype a =
         let lita = M1.(lit litype a) in
         let litb = M2.(lit litype a) in
         (lita, litb)
      let var n =
         let vara = M1.(var n) in
         let varb = M2.(var n) in
         (vara, varb)
   end: SYM with type t = a * b)
