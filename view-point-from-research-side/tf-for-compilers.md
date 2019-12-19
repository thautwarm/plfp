# Tagless Final For Writing Compilers

Writing a compiler consists of many steps, which could be quite numerous.

Hence, a solution to allow compiler writers to merely focus on only one step of compilation, keep away from awaring other dependent steps, and able to composite the separate steps into a big ones, could be beneficial(better for collaborations as well?).

Tagless Final is an approach for this demand, due to one of its useful feature:
"interpreting a given (written) term from various perspectives".

# Problem

Given a BNF grammar(hereafter as `Lamu0`),

```BNF
expr ::= let | lam | app
let  ::= 'let' ID '=' expr 'in' expr
lam  ::= 'fn' ID '=>' expr
app  ::= atomexpr
     |   app atomexpr
atomexpr ::= INT | STRING | FLOAT | '(' expr ')'
```

To compile the language `Lamu0` to a lower representation, there're several steps we have to go through:

- To generate low level code, we shall
  - check validity of program: type checking
  - eliminate high level language constructs like:
     - lambda
     - name shadowing(let binding)
     - closures(free variables)
  
- To perform type checking
   
   we're supposed to correctly identify different occurrences for a symbol, and assign the same type to the symbol's occurrences.
   
- To eliminate name shadowings
   
   we're supposed to rename duplicate symbols to make all of them unique.
   
- To eliminate closures, we do closure conversions

   we're supposed to find free variables for each lambda, and do some
   extra code generation such as creating closure data structures.
   
   note, we're supposed to design the data structures to represent closures,
   and different free variables might be stored using different low level
   representations. So we need type inference.
   
   **type inference < closure conversion**

- To eliminate lambdas
   
   we're supposed to recursively lift lambdas to global functions, but it
   should take care of free variables, thus should be done after closure conversions.
  
   closure conversion < eliminating lambdas

Distinguishing scoped symbols from each other, detecting free variables, both of them
are involved in the analysis for [**Scope**](https://en.wikipedia.org/wiki/Scope_(computer_science))s, or [name resolution](https://en.wikipedia.org/wiki/Name_resolution_(programming_languages)), thus

   **name resolution < type inference**,
   **name resolution < eliminating name shadowing**,
   **name resolution < closure conversion**
   
Next, assume we can do type checking with type inference together,
we can make a order for compiler phases, from source code to low level code:
```
name resolution(1) < type check + infer(2)
name resolution(1)  < eliminating name shadowing(3)
name resolution(1)  < closure conversion(4)
type check + infer(2)   < closure conversion(4)
closure conversion(4) < eliminating lambdas(5)
```

One solution for these compiler phases is
```
1. name resolution(1)     <
2. type infer + check(2)  <
3. closure conversion(4)  <
4. elim lambdas(5)        <
5. elim name shadowing(3)
```

Recall our goals:
1. allow compiler writers to focus on only one phase, and no need to care about the
   dependent phases(e.g., when writing type inference, no need to care about name resolution)
2. the separately implemented compiler phases can be composed into a big one

We can use an example to illustrate the obstacles, check following inference rule:

```
LET:
     A |- e: \sigma  A_x \cup {x : \sigma} |- e' : \tau
     ----------------------------------------------------
          A |- (let x = e in e') : \tau
```

In this case, we'd ask, what's the form of the type environment `A`?

This might be considered trivial in many cases, but is crucial in my concerns.

Of course, we can maintain a map from `string` to `type`, and push and pop `string`-`type` pairs when inferencing.

However, it'd be beneficial if we have already transformed the symbols
(like `x` in `let x = e in e'`) into unique ones.

In this way, the overlap between name resolution and type inference gets eliminated. Further, things like pushing and popping names are already done during name resolution, we don't have to repeat it. We do dependent phases separately, this is decoupling.

However, the problem comes: How can we make sure the separately implemented compiler phases can got composed?

# Tagless Final

## Quick Start for Tagless Final

```ocaml
module type SYM = sig
   type repr
   val zero: repr
   val succ: repr -> repr
end

(* we want: pass in a module, get a new interpretation *)

module SYMSelf = struct
   type repr = {e : 'a. (module SYM with type repr = 'a) -> 'a}
   let zero = {e = fun (type a) (module M: SYM with type repr=a) -> M.zero}
   let succ {e} = {e = fun (type a) ((module M: SYM with type repr=a) as m)-> M.succ (e m)}
end

let run (type a) ((module M: SYM with type repr=a) as m) (SYMSelf.({e})) = e m

let term = let open SYMSelf in succ @@ succ @@ zero
```

What is the `term` in the last line?

```ocaml
module SYMShow = struct
   type repr = string
   let zero = "0"
   let succ x = "succ(" ^ x ^ ")"
end

module SYMList = struct
   type repr = {f: 'a. 'a -> 'a list}
   let zero = {f = fun _ -> []}
   let succ {f=x} = {f=fun a -> a::x a}
end

module SYMNat = struct
   type repr = int
   let zero = 0
   let succ x = x + 1
end

run (module SYMShow) term
-- succ(succ(zero))
let (SYMList.{f}) = run (module SYMList) term in f 1
-- [1; 1]
run (module SYMList) term
-- 2
```

This is neat!

Think that we implement each compiler phase, just like `SYMShow`, `SYMList`, `SYMNat`?


# "Grammar"

Tagless Final firstly requires a grammar for the DSL, and it corresponds to our BNF gramamr.

We now give the structure of interpretion(incidentally, it's called "grammar") for aforementioned BNF grammar:

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

See the implementation of parser:

```ocamlyacc
expr:
    LET n=ID ASSIGN bound=expr IN body=expr {SYMSelf.letl n bound body}
  | FN n=ID ARROW body=expr {SYMSelf.lam n body}
  | ...
;
```

Then we got something can be interpreted in various ways, instead of an AST!

# Tagless Final For Compiler Phases

## Expanding Representation

The compiler phases are usually dependent.

Type inference requires name resolution, so how can we implement them separately
with Tagless Final?

Guess we have implemented these phases, for type infer and name resolution,
we shall have
```ocaml
(* name resolution *)
module SYMScope = struct
   type repr = scope
   ..
end

(* type infer*)
module SYMType = struct
   type repr = typ (* your type representation *)   
   let letl : string -> typ -> typ -> typ = ..
   ..
end
```

Alas, we cannot use the information from `SYMScope` in `SYMType`!

How could we address this problem?

Recall the order of phases,

```
1. name resolution(1)     <
2. type infer + check(2)  <
3. closure conversion(4)  <
4. elim lambdas(5)        <
5. elim name shadowing(3)
```

**I guess, the `repr` is expanding bigger and bigger when performing the phases one by one?**

```
type repr = scope ->
type repr = scope * typ ->
type repr = scope * typ * closureinfo ->
type repr = scope * typ * closureinfo * lambdainfo ->
type repr = scope * typ * closureinfo * lambdainfo * unique_name ->
...
```

## Decoupling

However, if we're to implement a `SYM` with `type repr = scope * typ`,

- **Repetition, loss of decoupling**: we have to repeat ourselves to write code for `SYM with type repr = scope`,

- **Inflexibility, loss of compositing**: and further, the most severe thing is, **the order of phases gets fixed**,
  and if we misdesign the order of phases, we cannot compose things in a flexible style.


To avoid above losses, just figure out a new abstraction on `SYM`:

```ocaml

module type FSYM = sig
   type o
   type c
   type r
   val combine : o -> c -> r
   val project : r -> o
   
   val letl : o -> string -> r -> r -> c
   val lam  : o -> string -> r -> c
   val app  : o -> r -> r -> c
   val lit  : o -> litype -> string -> c
   val var : o -> string -> c
end

module Grow (Base: SYM) (Incr: FSYM with type o = Base.repr): SYM with type repr = Incr.r = struct
  type repr = Incr.r
  
  let lam n r =
     let o = Base.lam n @@ Incr.project r in
     let c = Incr.lam o n r in
     Incr.combine o c
  ..
end
```

Then we find, to decouple and composite dependent compiler phases, we can use `FSYM`,
which is demonstrated in [Lamu0 by FSYM](https://github.com/thautwarm/plfp/blob/master/view-point-from-research-side/Lamu0.md).

