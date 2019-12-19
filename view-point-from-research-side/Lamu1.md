
# Extending `Lamu0`

There're some restrictions in `Lamu0` language,
A most important one of which is, `Lamu0` is not polymorphic at all, we cannot have polymorphoc functions.

Given an identity function, it may be expected to be polymorphic, but it's actually not the case in `Lamu0`:

```
let f = fn x => x in let _ in f 1 in f
^int -> ^int
```

In practice, we prefer `f: forall a. a -> a` rather than `a -> a`(and `a` will be inferred later).

Now we're using a simple but reasonable type inference given by `remu_ts` library, to achieve the polymorphic functions, we can do manual annotations. 

In fact, it's not a workaround. We'll see in the future that
automatically generalising `let f = fn x => x` might not be a good idea, and distinguishing `a -> a` from `forall a. a -> a` is a blessing for it actually avoids being ambiguous.

So, we slightly modify our grammar:

```ocaml
module Type_final = struct
  module type SYM = sig
    type repr
    val app   : repr -> repr -> repr
    val arrow : repr -> repr -> repr
    val fresh : string -> repr
    val nom   : string -> repr
    val forall: string list -> repr -> repr
  end

  module SYMSelf = struct
      type r = {
        e: 'a. (module SYM with type repr = 'a) -> 'a
      }
      ..
  end
end
type litype = IntT | FloatT | StringT

module type SYM = sig
  type r
  val letl : string ->
             Type_final.SYMSelf.r option -> r -> r -> r
  val lam  : string -> r -> r
  val app  : r -> r -> r
  val lit  : litype -> string -> r
  val var  : string -> r
end
```


`Type_final.SYMSelf.nom` is a constructor for making [nominal types](https://en.wikipedia.org/wiki/Nominal_type_system),
and `Type_final.SYMSelf.forall` is for making [principal types](https://en.wikipedia.org/wiki/Principal_type).

By the use of principal types, we can make polymorphic functions:
```
let id_mono : int -> int = fn x => x in ...
let id_poly : forall a. a -> a = fn x => x in ...
```

## Playground

Try `Lamu1`'s type inference with `dune exec lamu1 --profile release`.

```ocaml
let f : forall 'a. 'a -> 'a =                                        
     fn x => x 
in let g = f in let _ = g 1 in g;;
=> expr0 : ^int -> ^int

let f : forall 'a. 'a -> 'a =
    fn x => x
in let g = f 1 in f;;
=> expr0 : forall {a} a -> a

let f: forall 'a. 'a -> 'a =
   fn x => x
in let g = f 1 in g;;
=> expr0 : ^int

let y : str = 1 in y;;
Fatal error: exception Lamu1.Phases.TypeError
```
