
Hello, here're my presentations, for introducing interestings stuffs of Programming Languages.

## Local Dependencies

- remu_ts: https://github.com/RemuLang/remu-type-system
- remu_scope: https://github.com/RemuLang/remu-scope

Clone them and use `opam install <local package name>` to install.

## 0. Tagless Final Approach

TODO

## 1. Making A Simple Language In 15 Minutes

The term "15 minutes" is absolute for being eye-catching,
but I'd expect you understand making a language with
existing and mature features wouldn't be a hard task.

We firstly introduce the syntax of our proposal language,
called **"Lamu0"**, whose name is derived from the term "lambda",
`0` is for the edition, and we'll increase the edition number when we extend it later.

The proposal for the syntax is decribed in following BNF,

```bnf
expr ::= let | lam | app
let  ::= 'let' ID '=' expr 'in' expr
lam  ::= 'fn' ID '->' expr
app  ::= atomexpr
     |   app expr
atomexpr ::= INT | STR | FLOAT | '(' expr ')'
```

This is a simplest language.

We can also introduce its ASTs intuitively:

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

Now, the parser of `Lamu0` is made by `Menhir` in the folder,
via the initial algebra (see [`SYMSelf`](https://github.com/thautwarm/plfp/blob/master/lamu0/lib/final.ml#L62)),
we can create a more polymorphic interface for the parsed result.

An example for parsing:

- `Lamu0`:
   
  `let x = 1 in x`

- parsed to `OCaml` code:

  ```ocaml
    type sym =  {e: 'a . (module SYM with type r = 'a) -> 'a}
    parsed : sym = 
      let open SYMself in
      letl "x" (lit IntT "1") (var "x")
  ```
  Pass a module of type `SYM with type r = outtype` can produce a kind of output(`outtype`).


## Playground of the Lamu0 Language

Use `dune build --profile @release` to get the executable.

Then check the type checker `echo "let f = fn x => fn y => y 1.2 x in f 2" | ./_build/install/default/bin/lamu0du`,
or

```
./_build/install/default/bin/lamu0du
let f = fn x => fn y => y 1.2 x in f 2;;

=> (^float -> ^int -> '3) -> '3
```
(To be continue

## Limitations of Lamu0
