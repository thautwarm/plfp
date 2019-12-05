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
