# Lamu0: A Case of Composition and Decoupling for Multiple Interpretations

`Lamu0` is a very simple and basic programming language, but the implementation in

   https://github.com/thautwarm/plfp/tree/master/lamu0

shows an approach to use Tagless Final to

- handle the case that the order of interpretations is significant.
- allow the composition of decoupled compiler phrases


Given the grammar

```ocaml
type litype = IntT | FloatT | StringT

module type SYM = sig
  type r
  val letl : string -> r -> r -> r
  val lam  : string -> r -> r
  val app  : r -> r -> r
  val lit  : litype -> string -> r
  val var  : string -> r
end
```



Background
---------------------------

The steps through `type r` to the executable low level instructions are complex:
Usually, a phrase `A` should be performed prior to some phrase `B`, so `B` depends on `A`.

For instance, if the last phrase is back end code generation, it for sure depends on all of other phrases.

```
A -> B -> ... -> C
 \   \         |
  ..   ..      |
          \   \|/
            CodeGen

for all phrase, it's prior to phrase CodeGen or it's phrase CodeGen
```

Another intuituve example, to perform type checking/inference, we shall understand the scope information firstly.

``` ---------------------
    |                   |
let x = 1               |  identify the occurrences of
   let y = 2            |  a type variable
   in y + x-------------|
in x--------------------|
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
- **resolving the dependency relationships among related interpretations**
- **decoupling the related interpretations as much as possible**

To address this problem, I proposed an operation among the algebras to make reductions, which could be taken advantage of to solve above 3 pain spots fairly easy.

Introduction
--------------------


The core idea is the generalization of `fold` operation,
and I call it `grow`.

`grow (grow (grow zero fst) snd) third`, where `zero`, `grow (zero, fst)`, and similar stuffs are algebras(`module SYM`),
however, all of them have distinct representations(usually written as `type repr` in a `SYM`).

In this design, for `grow(m, mexpander)`, where `m` is an algebra, `mexpander` can produce a composite algebra(e.g., `scope -> scope + typed`) when using `m`.


We can also have an easier thought:
1. An interpretation needs an implementation of `SYM`.
2. Some interpretations are not independent.
3. `mexpander` is the incomplete form of the aggregation
of some independent interpretations. For instance, if `B` depends on `A`, map `A` to `B + A` is what `mexpander` does.

Something crucial during "expanding the algebra" is the change of the representation type(`type repr` in a algebra).

```ocaml
A : module SYM with type repr = o (* base *)
B : module SYM with type repr = r (* result *)
```

We check the "delta" from `A/base` to `B/result`,
and represent it in `type c`, we have `grow` change the type `repr` of the algebra(`SYM`) from `o` to `r`, with a delta `c`.

We extract the type expanding function out:
```ocaml
let combine : o -> c -> r
```

In this tagless final approach, we could


