
Hello, here're my presentations, for introducing interestings stuffs of Programming Languages.

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

type expr =
  | Let : (string * expr * expr) -> expr
  | Lam : (string * expr) -> expr
  | App : (expr * expr) -> expr
  | Lit : (litype * string) -> expr
  | Var : string -> expr
```

Now, the parser of `Lamu0` is made by `Menhir` in the folder,
...

(To be continue
