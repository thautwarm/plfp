
Hello, here're my presentations, for introducing interestings stuffs of Programming Languages.

1. [FSYM: An Abstraction On Tagless-Final Style To Compositing And Decoupling Multiple Interpretations](https://github.com/thautwarm/plfp/blob/master/view-point-from-research-side/Lamu0.md), for FP seminar of our Lab on 12/13/2019.

    We use type inference and name resolution to demonstrate this,
    where type inference depends on the information from name resolution,
    while both interpretations are implemented separately,
    and capable of taking advantage of the existing compiler frameworks.
    ```F#
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

2. [Tagless Final for Writing Compilers](https://github.com/thautwarm/plfp/blob/master/view-point-from-research-side/tf-for-compilers.md), for FP seminar of our Lab in 12/20/2019.
  
    Still about `FSYM`, but with better elaboration of the obstacles and why `FSYM` makes senses.

    Also, a cleaner instance of using `FSYM` is implemented.
    [Extending `Lamu0`](https://github.com/thautwarm/plfp/blob/master/view-point-from-research-side/Lamu1.md) with principal types.

    ```F#
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
 3. [Julia Counts for PL Researchers](https://thautwarm.github.io/Site-32/PL/elaborating-julia.html), for FP seminar of our Lab in 04/02/2020.
