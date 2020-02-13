# Quick and Reusable Code Generation for Idris

A dependently typed programming language like Idris is very poweful
for making static assurances, which will be very useful to
avoid unnecessary dynamic language features, and enhance the
robustness of programs.

A very very usual example to show the advantage of a dependently typed programming language is,
the vector whose length is dependent. There's [a code snippet](https://www.idris-lang.org/example/) from the official website.

```idris
infixr 5 ::

data Vect : Nat -> Type -> Type where
    Nil  : Vect Z a
    (::) : a -> Vect k a -> Vect (S k) a

app : Vect n a -> Vect m a -> Vect (n + m) a
app Nil       ys = ys
app (x :: xs) ys = x :: app xs ys
```

For one use case, above code unveils the possibility of
making very safe and efficient linear algebra libraries,
in which we could use Idris to
- avoid runtime checking dimensions
- gain a strong guarantee of avoiding incorrect manipulations among vectors/matrices/tensors
- automatically complete the dimensions of tensors by dependent typing.

Other than above use, as we know things like CompCert already made great progress in
verifying the correctness of C compilers and detecting bugs of corner case,
certainly applying languages like Idris to the industrial will fundamentally
improve the reliability and even make them virtually **bug-free**.

To achieve the practical use of Idris, the core developers made [a very convenient
interface](https://github.com/idris-lang/Idris-dev/wiki/Idris-back-end-IRs) to support custom code generations.

Since that, we can gain the lambda-lifted or applicative normal formed intermediate representations to
write code generators for our own back ends.

So far, there're many back ends available [here](http://docs.idris-lang.org/en/latest/reference/codegen.html),
including C, Javascript, Java, Erlang, etc.

However, there're still many other popular "industrial programming languages" not supported.

Our observation is, making many back ends certainly has some potential points of code reuse.

To study its feasibility, we try to design a common abstraction among different Idris back ends.


## Current Stage & Problems

Currently, we have [this](https://github.com/thautwarm/idris-cam/blob/master/src/IRTS/CodegenCam.hs).

```haskell
data ComIR
    = ComLet String ComIR ComIR
    | ComLetrec [(String, ComIR)] ComIR
    | ComIf ComIR ComIR ComIR
    | ComWhile ComIR ComIR
    | ComMutate String ComIR
    | ComFun [String] ComIR
    | ComApp ComIR [ComIR]
    | ComVar String
    | ComBlock [ComIR]
    | ComTuple [ComIR]
    | ComProj ComIR ComIR

    | ComSymbol String -- LISP symbols, for implementing fast data types
    | ComBigInt Integer
    | ComInt Int
    | ComDouble Double
    | ComStr String
    | ComCh Char
    | ComBool Bool
    | ComNil
    | ComInternal String
    deriving (Show, Eq, Ord, Generic)
```

We generates above ComIR(common intermediate representations) to JSON format,
and the target language only needs to implement an interface to transform
ComIR(in JSON format) to their source code/ASTs/bytecode instructions.

It succeeded in making backends for both Python and Julia

- Idris-Python: https://github.com/thautwarm/idris-python
- Idris-Julia : https://github.com/thautwarm/idris-cam/tree/master/cam-julia/src

Although we made it, things are still not that convenient.

Several problems got raised due to the differences of programming languages:

1. `Let`-binding and `Let-rec` constructs are missing in many programming languages(Ruby, Python, etc),
   and translation from `let`/`let rec` to languages with the weaker scope does
   require some code. `let binding` can be semantically equivalent to an immediate function call,
   but this is heavy if the target is a dynamic programming language.

2. Mutation features are missing in some programming languages(Erlang, Haskell etc.),
   and the translation can be annoying. Also, without some optimizations,
   the performance cost can be expensive.

3. `ComIR` is expression-first, while some programming languages are statement-first.
   Some statement-first programming language can be extremely weak, like Python.

   For example, translating following Javascript to Python is really difficult for a user.

   ```javascript
   f({
       print(g(x))
       x = 0
       print(g(x))
       x = 1
       h(x)
   })
   ```

   Hence, if the target language is statement-first, we have to transform things to ANF(applicative normal form).
   Further, if the target language is also dynamic and lack of compiler optimizations, ANF transformations need
   many optimizations(e.g., register reallocations) to avoid performance disasters.


4. There're still so many constructs in `ComIR`, each of which needs a rule for code generation. It'll be
   beneficial if we can minimize the constructs in `ComIR`.

## In WIP

To address the 4 problems aforementioned, we're working in progress on the following 4 parts.

1. To address the lack of `let`/`let rec` bindings, we shall lower these 2 constructs to traditional assignments
   used in imperative programming languages.

2. Ending the lack of mutation(in some languages) might be treated specially, as in Haskell/Erlang we can have `State` monad,
   and it might not hard for code generation.
   
   ```javascript
   a = 1
   f(a)
   a = 2
   g(a)
   ```
   ->
   ```haskell
   do
    modify $ over a (const 1)
    f <$> gets $ view a
    modify $ over a (const 2)
    g <$> gets $ view a
    ...
   ```
   Because it's simple for us to get all symbols of a function, and we can certainly make such a datatype
   for representing the variables:
   ```haskell
    data VariablesOfSomeFunc
        = { _a :: Int -- variable a
          , ...
          , ...
          }
    makeLenses ''VariablesOfSomeFunc
   ```

3. To address of weakness of target language's statement-first feature, we can
   simplify `ComIR` to ANF, with register reallocation optimizations.

4. To minimize the constructs of our `ComIR`(to `MIR`), we can simplify some constructs to applications.

  - `ComProj a b` -> `App (Extern "project") [a, b]`
  - `ComTuple [x, y]` -> `App (Extern "make_tuple") [x, y]`
  - ...

We could finally simplify `ComIR` to such a small language:
```haskell
-- trivial representation, like function arguments in ANF
data ARepr = AConst of Constant
            | AVar of String

-- a potential minimized ComIR
data MIR =
        App ARepr [ARepr]
    | Lit ARepr
    | Fun [String] MIR
    | AssignIn String ARepr MIR
    | ITE ARepr MIR MIR
    | While ARepr MIR
    | Extern String -- external things in target language
```
and things like `App (Extern "project") [a, b]` can be specialized in the code generator made by target languages(like `a[b]` in Ruby).

This optimization **optional**(only if performance is significant).
