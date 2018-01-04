package main;

import "fmt";
import "bufio";
import "os";
import "math/big";

func main() {
    var s string;
    var k int;
    n := &big.Int{};
    t := &big.Int{};
    
    in := bufio.NewReader(os.Stdin);
    fmt.Fscan(in, &s);
    n.SetString(s, 10);
    
    n.Add(n, new(big.Int).Neg(new(big.Int).Exp(t.Sqrt(n), big.NewInt(2), nil)));
    
    t.Add(t, big.NewInt(1));
    k = n.Cmp(t);
    
    if k == 1 { 
        fmt.Println(n.Add(t, new(big.Int).Neg(new(big.Int).Add(n, new(big.Int).Neg(t)))));
    }
    if k == 0 {
        fmt.Println(t);
    }
    if k == -1 {
        k = n.Cmp(big.NewInt(0));
        if k == 0 {
            fmt.Println(1);
        } else {
            fmt.Println(n);
        }
    }
}