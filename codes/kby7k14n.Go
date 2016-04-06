// in vanilla
fib := (n) -> => {
    n == 0 : 0,
    n == 1 : 1,
    _ : fib (n - 1) + fib (n - 2)
};

// abstracted with a lambda match
fib := (n) ==> {
    0 : 0,
    1 : 1,
    _ : fib (n - 1) + fib (n - 2)
};