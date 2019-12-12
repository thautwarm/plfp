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

for each phrase, it's either prior to phrase CodeGen or phrase CodeGen itself.
```

Another intuituve example, to perform type checking/inference, we shall understand the scope information firstly.

``` 
    ---------------------
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

We check the "delta" from `o = A.repr` to `r = B.repr`,
and represent it with `type c`:
`grow` change the type `repr` of the algebra(`SYM`) from `o` to `r`, with a delta `c`.

We extract the type expanding function out:
```ocaml
let combine : o -> c -> r
```

For the sake of using tagless final approach, we make `A->A+B` similar to a `SYM`,
and I call it `FSYM`, representing it's a functor from `SYM` to `SYM`,
however maybe due to my lack of improvements for the implementation, I didn't actually use module functor.

```ocaml
module type FSYM = sig
    type r
    type c (*delta*)
    type o
    val combine : o -> c -> r
    
    val letl : o -> string -> r -> r -> c
    val lam  : o -> string -> r -> c
    val app  : o -> r -> r -> c
    val lit  : o -> litype -> string -> c
    val var  : o -> string  -> c
end
```

In `SYM`, an operator of type `a -> b -> ... -> r`,
will be the type `o -> a -> b -> ... -> c`, where `o` is the original `repr` of an algebra,
`r` is the `repr` of the result algebra transformed by `fun m -> grow(m, (module FSYM))`,
`c` is the delta of the change from `o` to `r`.

So then type of `grow` is 

```ocaml
'o 'c 'r.
(module SYM with type r = 'o) ->
(module FSYM with type o ='o and type c = 'c and type r = 'r) ->
(module SYM with type r = 'r)
```

Besides, For `grow(A, A->A+B) = A+B`, `A+B` needs to implement the tagless final interpretation for both `repr=o` and `repr=r=o+c`, let's just check the `lam` operator, and remember we already have `val combine : o -> c -> r`:

- `A`:
   ```ocaml
   val lam_1: string -> o -> o
   ```

- `A->A+B`:
    ```ocaml
    val lam_2: o -> string -> r -> c
    ```

- `A+B`
    ```ocaml
    val lam_3: string -> r -> r
    ```

We now need to implement `lam_3` via `lam_1` and `lam_2`.

To use `lam_1` in `lam_3`, I think it's natural:
`o` is "included" in `r`, so we should be able to project `r` to `o`:

```ocaml
let lam_3 (argname: string) (body: r) =
    let body_o: o = project body in
    let o = lam_1 argname body_o in
    ...
```

So we introduce `val project: r -> o` into `FSYM`.

```ocaml
module type FSYM = sig
    type r
    type c (*delta*)
    type o
    val combine : o -> c -> r
    
    val letl : o -> string -> r -> r -> c
    val lam  : o -> string -> r -> c
    val app  : o -> r -> r -> c
    val lit  : o -> litype -> string -> c
    val var  : o -> string  -> c
end
```

For `val lam_2: o -> string -> r -> c`, it uses the interpretation result of last phrase(typed `o`), and the argname(`string`), as well as the interpreted body(`r=o+c`), and return a `c`.

Now just give the implementation of `lam_3` in the following code block. Actually I don't know yet
how to explain how I came up with it, but it's tidy, isn't it?

```ocaml
let lam_3 (argname: string) (body: r) =
    let body_o: o = project body in
    let o = lam_1 argname body_o in
    let c = lam_2 o argname body in
    combine o c
```


The whole code for `grow` can be found at [final.ml L28-L59](https://github.com/thautwarm/plfp/blob/master/lamu0/lib/final.ml#L28).


Analysis
---------------

Let's review our goals aforementioned.

1. **decoupling the related interpretations as much as possible**

    Each interpretation is a `SYM`, and `FSYM` is for compositing `SYM`s.

    Notice that, in `FSYM/A->A+B`, we don't need to care how interpretation for `A` is proceeding.

    **We just focus on how to use the result from A to implement B**, and no need to care about how
    `A` and `B` gets composed.

    Check the type signature of `lam_2`: `val lam_2: o -> string -> r -> c`:
    - `o` here is from `A`, already computed.
    - `r` here is the inner result, we can deconstruct it to `o` and `c`, if needed.
    - `c` here is the **only result** we have to compute in the process of `A->A+B`.

    Interpretations for `o` and `c/r` is separated.

    Interpretion for `r` derives from interpretion for `c`, via the constribution of `val combine: o -> c -> r`).

2. **resolving the dependency relationships among related interpretations**

    This is pretty easy to explain, check the type signature of `lam_2`:

    `val lam_2: o -> string -> r -> c`,
    
    the current expression's interpretation result is given in `o`,
    the inner expression's interpretation result is given in `r`.

    **You know everything from the last phrase.**

3. **compositing separate interpretations**
   
    I guess no need to explain this. If you have any problem,
    check the type signature of `grow`:

    ```ocaml
    'o 'c 'r.
    (* SYM : A; repr : o *)
    (module SYM with type r = 'o) ->
    (* FSYM : A->A+B *)
    (module FSYM with type o ='o and type c = 'c and type r = 'r) ->
    (* SYM: A+B; repr=r=o+c *)
    (module SYM with type r = 'r)
    ```

That's all of my analysis, does it make sense :) ?

Application
------------------------