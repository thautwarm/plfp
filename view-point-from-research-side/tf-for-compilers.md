# Tagless Final For Writing Compilers

Writing a compiler consists of many steps, which could be quite numerous.

Hence, a solution to allow compiler writers to merely focus on only one step of compilation, keep away from awaring other dependent steps, and able to composite the separate steps into a big ones, could be beneficial.

Tagless Final is an approach for this demand, due to one of its useful feature:
"interpreting a given (written) term from various perspectives".

Given a BNF grammar(hereafter as `Lamu0`),

```BNF
expr ::= let | lam | app
let  ::= 'let' ID '=' expr 'in' expr
lam  ::= 'fn' ID '=>' expr
app  ::= atomexpr
     |   app atomexpr
atomexpr ::= INT | STRING | FLOAT | '(' expr ')'
```

To compile the language `Lamu0` to a lower representation, for example,
[Sijuiacion IR](https://github.com/RemuLang/sijuiacion-lang) for the sake of convenience.

A guide of this IR can be found at ...TODO




