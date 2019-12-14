NOTE: If you'd install `remu_ts` and `remu_scope`, clone them from [RemuLang](https://github.com/RemuLang/) and use `opam install .` to install them locally.

## FSYM: An Abstraction On Tagless-Final Style To Compositing And Decoupling Multiple Interpretations

`Lamu0` is a very simple and basic programming language, but the implementation in [plfp/lamu0](https://github.com/thautwarm/plfp/tree/master/lamu0) shows an approach to use Tagless Final to

- handle the case that the order of interpretations is significant.
- allow the composition of decoupled compiler phrases


Given the grammar

```ocaml
type litype = IntT | FloatT | StringT

module type SYM = sig
  type repr
  val letl : string -> repr -> repr -> repr
  val lam  : string -> repr -> repr
  val app  : repr -> repr -> repr
  val lit  : litype -> string -> repr
  val var  : string -> repr
end
```



## Terminology

The following terms represent the same thing in this presentation.
- interpretation (from a separate view of compiler)
- `SYM` (from the view of routine implementation in OCaml)
- algebra (from a view of mathematics)
- compiler phrase(from an overall view from compiler)

## Background

The steps through `type repr` to the executable low level instructions are complex:
Usually, a phrase `A` should be performed prior to some phrase `B`, so `B` depends on `A`.

For instance, if the last phrase is back end code generation, it for sure depends on all of other phrases.

```
A -> B -> ... -> C
 \   \         |
  ..   ..      |
          \   \|/
            CodeGen

for each phrase, it's either prior to phrase CodeGen or phrase CodeGen itself.
```

Another intuituve example, to perform type checking/inference, we shall understand the scope information firstly.

``` 
    ---------------------
    |                   |
let x = 1               |  identify the occurrences of
   let y = 2            |  a type variable
   in y + x-------------|
in x---------------------
```

More instances could be found in the real world:

- All type-directed code generations require the information from (partially) type inference.
- The compilation for type classes, in the approach of dictionary passing, requires type information, and a scope
for class instances.
- The closure conversion needs scope information to get the
free variables of a function.
- etc...

The tagless final approach works for the polymorphisms of
interpreting a given "grammar", however,
it lacks of the facilities to work with multuple separate interpretations, like

- **compositing separate interpretations**
- **resolving the dependency relationships among dependent interpretations**
- **decoupling the dependent interpretations as much as possible**

To address these problems, I proposed
- an operation(`grow`) among the algebras to make reductions,
- a module signature (`FSYM`) very close to the shape of `SYM` to composite and decouple interpretations.

which could be taken advantage of to solve above 3 pain spots fairly easy.

## Introduction



The core idea is the generalization of `fold` operation,
and I call it `grow`.

`grow (grow (grow zero fst) snd) third`, where `zero`, `grow (zero, fst)`, and similar stuffs are algebras(`module SYM`),
however, all of them have distinct representations(usually written as `type repr` in a `SYM`).

In this design, for `grow(m, mexpander)`, where `m` is an algebra,
and `mexpander` can produce a new algebra(e.g., `scope->scope+type`) by composing with `m` via `grow`.


We can also have an easier thought:
1. An interpretation needs an implementation of `SYM`.
2. Some interpretations are not independent.
3. `mexpander` is the incomplete form of the aggregation of some independent interpretations.
    For instance, if `B` depends on `A`, transforming `A` to `A+B` is what `mexpander` does.

Something crucial during "expanding the algebra" is the change of the representation type(`type repr` in a algebra/`SYM`).

```ocaml
A : module SYM with type repr = o (* base *)
B : module SYM with type repr = r (* result *)
```

We check the "delta" from `o = A.repr` to `r = B.repr`,
and represent it by type `c`, in other words:

**`grow` transforms the type `repr` in the algebra(`SYM`) from `o` to `r`, with a delta `c`, while transforms the interpretation from `A` to `A+B`.**

We extract the type expanding function out:
```ocaml
val combine : o -> c -> r
```

And extract the interpretation expanding function out:
```ocaml
val grow: 'o 'c 'r.
    (module SYM with type repr = 'o) ->
    (module FSYM with type o ='o and type c = 'c and type r = 'r) ->
    (module SYM with type repr = 'r)
```

So the current goal is to extract the structure of `FSYM`, and make sure it satisfy our final goals:

- compositing separate interpretations:

    It's natural, according the type of `grow` function.

- resolving the dependency relationships among dependent interpretations:

    We're supposed to make sure `FSYM` can use the interpreted result of `module SYM with type repr = o`
    to implement the interpretion `module SYM with type repr=r`.

- decoupling the dependent interpretations as much as possible:

    We're supposed to decouple the implementation of `module SYM with type repr = o` and `FSYM`.
    
    That is to say, we don't have to, and even shouldn't know or aware the implementation
    of `module SYM with type repr = o` when we're impelementing `FSYM`.


We point out that, following signature would suffice

```ocaml
module type FSYM = sig
    type r
    type c (*delta*)
    type o

    val combine  : o -> c -> r
    val project  : r -> o

    val letl : o -> string -> r -> r -> c
    val lam  : o -> string -> r -> c
    val app  : o -> r -> r -> c
    val lit  : o -> litype -> string -> c
    val var  : o -> string  -> c
end
```

Deriving a `FSYM` from `SYM` is trivial:

Besides the common part
```ocaml
sig
    type o
    type c (* delta from o to c *)
    type r

    val combine  : o -> c -> r
    val project  : r -> o
end
```
Any operator of type `a -> b -> ... -> r` in `SYM`,
is supposed to be transformed to `o -> a -> b -> ... -> c` in `FSYM`,
where the symbols `o, c, r` keep the same meanings as the aforementioned:

- `o` is the original `repr` of the original algebra `A`,
- `r` is the `repr` of the result algebra(`A+B`) transformed by `grow(A, B)`,
- `c` is the delta of the change from `o` to `r`. There's no algebra like `SYM`, but exactly a functor `A->A+B`.

To elaborate, we can use `lam` operator as an examplar:

- in `SYM`/algebra/interpretation `A`:
   ```ocaml
   val lam_1: string -> o -> o
   ```

- in **`FSYM`**, `A->A+B`:
    ```ocaml
    val lam_2: o -> string -> r -> c
    ```

- in `SYM`/algebra/interpretation `A+B`
    ```ocaml
    val lam_3: string -> r -> r
    ```

We now need to implement `lam_3` via `lam_1` and `lam_2`.

Recall the last 2 of our goals which haven't been accomplished:

- decoupling the dependent interpretations as much as possible:

   Which is to say, `lam_2` and `lam_3` shouldn't aware how `lam_1` gets
   implemented, and it's easy to satisfy:

   ```ocaml
    let lam_3 (argname: string) (body: r) =
        let body_o: o = project body in
        let o = lam_1 argname body_o in (* HIGHLIGHTING HERE! *)
        ...
   ```

   Of course, `lam_1`, and anything else for implementing the prior interpretation(a.k.a `A`), shouldn't be referred in `lam_2`'s implementation,
   or how `lam_3` uses `lam_2`.

- resolving the dependency relationships among dependent interpretations:
   
   Hence, `lam_2` should use the result of the prior interpretation(a.k.a `A`),
   and it's quite easy as well:

   ```ocaml
    let lam_3 (argname: string) (body: r) =
    let body_o: o = project body in
    let o = lam_1 argname body_o in
    let c = lam_2 o argname body in  (* HIGHLIGHTING HERE! *)
    combine o c
   ```


The whole code for `grow` can be found at [final.ml L28-L59](https://github.com/thautwarm/plfp/blob/master/lamu0/lib/final.ml#L28),
but notice that the type `repr` in `SYM` is written in a shorter form `r`.

\* In fact, if we use lazy types as the `repr` of each interpretation/phrase,
the order of interpretation can be more flexible.

Check `Lamu0` in the sub-section `Application`.


## Application

[Lamu0](https://github.com/thautwarm/plfp/tree/master/lamu0) gives a very simple example to compose the existing and decoupled frameworks for compilers.

### Scoping: Name Resolution


An existing simple framework, [remu_scope](https://github.com/RemuLang/remu-scope), designed for name resolution, also written by me, provides following 3 major APIs:

```ocaml
val require: env -> scoperef -> name -> sym
val enter: env -> scoperef -> name -> sym
val subscope: env -> scoperef -> scoperef
```

For example, to solve the scope of following code:
```ocaml
let x = 1 in x
```

We can do:
```ocaml
let env = empty_env() in
let root: scoperef = 0 in
let let_scope = subscope env root in
let x_assign = enter let_scope "x" in
let x_load = require let_scope "x" 
```

With this snippet, you can check `assert (x_assign = x_load)`.

With tagless final extended by `FSYM` abstraction and above existing framework, we can then implement a standalone but composable interpretation for name resolution:

```ocaml
module Scoping = Remu_scope.Solve

type scopedesc =
  | Sym of Scoping.sym
  | ScopeUnrelated (* for expressions that're not variables *)

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
    let letl : o -> string -> r -> r -> c = ...
    let lam: o -> string -> r -> c = ...
    let app: o -> r -> r -> c = ...
    let lit: o -> litype -> string -> c = ...
    let var: o -> string -> c  = ...
end
```

The whole code can be found at [lamu0_ast.ml L5-L60](https://github.com/thautwarm/plfp/blob/master/lamu0/lib/lamu0_ast.ml#L5-L60).

We unroll the implementation of `lam`:


```ocaml
(*
let subscope () = Scoping.subscope ST.env (!ST.cur_scoperef)
let enter n = Scoping.enter ST.env (!ST.cur_scoperef) n
let with_scope si' f =
    let si = !ST.cur_scoperef in
      ST.cur_scoperef := si';
      let ret = f() in
      ST.cur_scoperef := si;
      {desc=ret; i=si}
*)
let lam: o -> string -> r -> c = fun _ n e -> lazy begin
    let si' = subscope () in
    with_scope si' @@ fun () ->
    let _ = enter n in
    let _ = get e in
    ScopeUnrelated end
```

It's pretty easy, and can be composed into the compilation pipeline, for every programming language whose scope could be expressed by `remu_scope`.


### Typing: Type Inference

Type inference requires already knowing the scope information.

So it depends on the previous phrase, name resolution.

Firstly we check an existing framework providing type inference, [remu_ts](https://github.com/RemuLang/remu-type-system).

And we just use a very limited part of `remu_ts`, here's an example of this framework:

To infer the types of code,

```ocaml
val f : forall a. 'a -> 'a -> bool
let x = 1 in f x y
```

We write

```ocaml
open Remu_ts.Infer
open Remu_ts.Comm
open Remu_ts.Builder

module TC : TState = (val crate_tc empty_tctx : TState)
let _ = let open TC in
   let intt = new_type "int" in
   let boolt = new_type "bool" in
   let x = new_tvar() in
   let y = new_tvar() in
   let f = Forall(["a"], Arrow(Fresh "a", Arrow(Fresh "a", boolt))) in
   
   (* x = 1 *)
   assert (unify x intt);
   
   (* f x y *)
   let arg1 = new_tvar() in
   let arg2 = new_tvar() in
   assert (unify arg1 x);
   assert (unify arg2 y);
   let func = Arrow(arg1, Arrow(arg2, boolt)) in
   assert (unify f func);
   let print_ty name x =
        Printf.printf "%s: %s\n" name   @@
        dumpstr
        (mk_show_named_nom (module TC)) @@
        prune x
    in
   print_ty "x" x;
   print_ty "y" y;
   print_ty "func" func
```

After running this file, we got
```
x: ^int
y: ^int
func: ^int -> ^int -> ^bool
```

The implementation of `FSYM` to leverage above existing framework is:

```ocaml
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

  let letl : o -> string -> r -> r -> c = ...
  let lam: o -> string -> r -> c = ...
  let app: o -> r -> r -> c = ...
  let lit: o -> litype -> string -> c = ...
  let var: o -> string -> c  = ...
end
```

The whole code of this could be found at [Lamu0_ast.ml #L62-L129](https://github.com/thautwarm/plfp/blob/master/lamu0/lib/lamu0_ast.ml#L62).

For a rough sketch, let's check the implementation `lam` again:

```ocaml
let lam o n e = lazy begin
    let eo = project e in
    let var_of_arg = new_tvar() in
    ann eo n var_of_arg;
    Typing.Arrow(var_of_arg, rtype e) end
```


Finally, we assembly things together, and make a type inferencer for `Lamu0` at [main.ml](https://github.com/thautwarm/plfp/blob/master/lamu0/bin/main.ml).

You can run the type infer REPL with: `dune exec lamu0 --profile release`:

```
let x = 1 in x;;     
=> expr0 : ^int

let y =
   let f = fn x => fn y => y in 
   let g = f 1 2.0 in 
   f
in y;;
=> expr0 : ^int -> ^float -> ^float

let f = fn y => y "123" in f (fn x => x);;
=> expr0 : ^string
```

## References

- [Algebra](http://okmij.org/ftp/tagless-final/Algebra.html)
- [Tagless-Final Optimizations, Algebraically and Semantically](http://okmij.org/ftp/tagless-final/course2/)
