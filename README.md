
Hello, here're my presentations, for introducing interestings stuffs of Programming Languages.

1. [FSYM: An Abstraction On Tagless-Final Style To Compositing And Decoupling Multiple Interpretations](https://github.com/thautwarm/plfp/blob/master/view-point-from-research-side/Lamu0.md), for FP discussion of our Lab on 12/13/2019.

    We use type inference which name resolution to demonstrate this,
    where type inference depends on the information from name resolution,
    but both are implemented separately,
    and can take advantage of the
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