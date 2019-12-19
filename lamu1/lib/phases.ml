open Final

let numbering (cnt: int ref) =
  let module S = struct
    type repr = int

    let get () =
        let i = !cnt in
         incr cnt;
         i

    let letl _ _ _ _ =  get()

    let lam _ _ = get ()

    let app _ _ = get ()

    let lit _ _ = get ()

    let var _ = get ()
  end in
  (module S : SYM with type repr = int)

module Scoping = struct
  include Remu_scope.Solve

  type repr = { symbol : sym option; id : scoperef }
end

module MKScoping = struct
  type c' = Scoping.repr Lazy.t

  let mk (type o' r')
      (required_st :
        < combine : o' -> c' -> r'
        ; project : r' -> o'
        ; get : r' -> Scoping.repr
        ; env : Scoping.env >) =
    let env = required_st#env in
    let cur_scoperef : Scoping.scoperef ref = ref 0 in
    let subscope () = Scoping.subscope env !cur_scoperef in
    let enter n = Scoping.enter env !cur_scoperef n in
    let require n = Scoping.require env !cur_scoperef n in
    let with_scope si' f =
      let si = !cur_scoperef in
      cur_scoperef := si';
      let ret = f () in
      cur_scoperef := si;
      Scoping.{ symbol = ret; id = si }
    in
    let module S = struct
      type o = o'

      type c = c'

      type r = r'

      let combine = required_st#combine

      let project = required_st#project

      let ( !! ) = required_st#get

      let return scopesym =
        Scoping.{ symbol = scopesym; id = !cur_scoperef }

      let letl : o -> string -> Type_final.SYMSelf.r option -> r -> r -> c =
       fun _ n t e1 e2 ->
        lazy
          ( ignore !!e1;
            let si' = subscope () in
            with_scope si' @@ fun () ->
            ignore @@ enter n;
            ignore !!e2;
            None )

      let lam : o -> string -> r -> c =
       fun _ n e ->
        lazy
          (let si' = subscope () in
           with_scope si' @@ fun () ->
           let _ = enter n in
           let _ = !!e in
           None)

      let app : o -> r -> r -> c =
       fun _ f a ->
        lazy
          ( ignore !!f;
            ignore !!a;
            return None )

      let lit : o -> litype -> string -> c = fun _ _ _ -> lazy (return None)

      let var : o -> string -> c = fun _ s -> lazy (return @@ Some (require s))
    end in
    (module S : FSYM with type o = o' and type c = c' and type r = r')
end

let scoping = MKScoping.mk

module Typing = struct
  include Remu_ts.Infer

  type repr = t
end

exception TypeError

module MKTyping = struct
  type c' = Typing.repr Lazy.t

  let mk (type o' r')
      (required_st :
        < combine : o' -> c' -> r'
        ; project : r' -> o'
        ; env : (module Typing.TState)
        ; type_of_name : o' -> string -> Typing.repr
        ; type_of_repr : r' -> Typing.repr
        ; annotate : o' -> string -> Typing.repr -> unit
        ; primitives: string list>) =
    let module TC = (val required_st#env) in
    let module TEval = Type_final.Builder(TC) in
    let teval = (module TEval: Type_final.SYM with type repr=Typing.repr) in
    let annotate = required_st#annotate in
    let type_of_name = required_st#type_of_name in
    let type_of_repr = required_st#type_of_repr in
    List.iter (fun x -> ignore @@ TEval.add_type x) required_st#primitives;
    let int_type = TEval.add_type "int" in
    let float_type = TEval.add_type "float" in
    let str_type = TEval.add_type "str" in
    let ( = ) = TC.unify in
    let module S = struct
      type o = o'

      type c = c'

      type r = r'

      let combine = required_st#combine

      let project = required_st#project

      let letl o n t e1 e2 =
        lazy
          (
           let eo2 = project e2 in
           let var_of_n = match t with
               | Some t ->
                 Type_final.run teval t
               | None -> TC.new_tvar ()
           in
           annotate eo2 n var_of_n;
           let e1t = type_of_repr e1 in
           let e2t = type_of_repr e2 in
           if var_of_n = e1t then e2t else raise TypeError)

      let lam o n e =
        lazy
          (let eo = project e in
           let var_of_arg = TC.new_tvar () in
           annotate eo n var_of_arg;
           Typing.Arrow (var_of_arg, type_of_repr e))

      let app _ f a =
        lazy
          (let var_of_ret = TC.new_tvar () in
           let var_of_arg = TC.new_tvar () in
           if
             type_of_repr f = Typing.Arrow (var_of_arg, var_of_ret)
             && type_of_repr a = var_of_arg
           then var_of_ret
           else raise TypeError)

      let lit _ lt v =
        lazy
          ( match lt with
            | StringT -> str_type
            | IntT -> int_type
            | FloatT -> float_type)

      let var o n =
        lazy (type_of_name o n)
    end in
    (module S : FSYM with type o = o' and type c = c' and type r = r')
end

let typing = MKTyping.mk

module MKRecording = struct
  let mk (type o')
        (required_st:
        < store: o' array ref; cnt : int ref; id_of_repr: o' -> int>) =
      let store = required_st#store in
      let id_of_repr = required_st#id_of_repr in
      let assign o () =
        let id = id_of_repr o in
        !store.(id) <- o
      in
      let ( !! ) (_, f) = f() in
      let module S = struct
        type o = o'
        type c = unit -> unit
        type r = o * c

        let combine (a: o) f = (a, f)

        let project (a, _) = a

        let letl o (_: string) (_: Type_final.SYMSelf.r option)
                 e1 e2 () = begin !!e1; !!e2; assign o () end
        let lam o _ e () = begin !!e; assign o () end
        let app o e1 e2 () = begin !!e1; !!e2; assign o () end
        let lit o _ _ = assign o
        let var o _ = assign o
      end
      in (module S : FSYM with type o = o' and type c = S.c and type r = S.r)
end

let recording = MKRecording.mk
