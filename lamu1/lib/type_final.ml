module type SYM = sig
   type repr
   val app   : repr -> repr -> repr
   val arrow : repr -> repr -> repr
   val fresh : string -> repr
   val nom   : string -> repr
   val forall: string list -> repr -> repr
end

module SYMSelf = struct
    type r = {e: 'a. (module SYM with type repr = 'a) -> 'a}
    let app {e=f} {e=arg} =
      {e = fun (type a) ((module S: SYM with type repr=a) as m) -> S.app (f m) (arg m)}
    let arrow {e=arg} {e=ret} =
      {e = fun (type a) ((module S: SYM with type repr=a) as m) -> S.arrow (arg m) (ret m)}
    let fresh s =
      {e = fun (type a) (module S: SYM with type repr=a) -> S.fresh s}
    let nom s =
      {e = fun (type a) (module S: SYM with type repr=a) -> S.nom s}
    let forall xs {e} =
      {e = fun (type a) ((module S: SYM with type repr=a) as m) -> S.forall xs @@ e m}
end

module Typ = Remu_ts.Infer
exception UndefNominal of string
module type M = sig
   include Remu_ts.Infer.TState
   include SYM
end

module Builder(TC : Remu_ts.Infer.TState) = struct
   type repr = Typ.t
   let type_slots : (string, int) BatHashtbl.t = BatHashtbl.create 8

   let add_type s =
       match BatHashtbl.find_option type_slots s with
       | Some i -> Typ.Nom i
       | _ ->
       let t = TC.new_type s in
       match t with
       | Typ.Nom i -> BatHashtbl.add type_slots s i;t
       | _ -> failwith "impossible!"

   let app a b = Typ.App(a, b)
   let arrow a b = Typ.Arrow(a, b)
   let fresh s = Typ.Fresh s
   let nom s =
     Typ.Nom(
     match BatHashtbl.find_option type_slots s with
     | Some i -> i
     | _ -> raise @@ UndefNominal s)
   let forall xs t = Typ.Forall(xs, t)
end

let run = fun (type a) ((module M: SYM with type repr = a) as m) -> SYMSelf.(fun {e} -> e m)
