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
    n = FromDecimalString(s);
    
    n.Add(n, new(big.Int).Neg(new(big.Int).Exp(t.Sqrt(n), big.NewInt(2), nil)));
    fmt.Println(t);
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

func FromDecimalString(s string) *big.Int {
	var sc scanner
	z := new(big.Int)
	sc.scan(z, s)
	return z
}

type scanner struct {
	powers []*big.Int
}

func (s *scanner) chunkSize(size int) (int, *big.Int) {
	if size <= quadraticScanThreshold {
		panic("size < quadraticScanThreshold")
	}
	pow := uint(0)
	for n := size; n > quadraticScanThreshold; n /= 2 {
		pow++
	}
	return quadraticScanThreshold << (pow - 1), s.power(pow - 1)
}

func (s *scanner) power(k uint) *big.Int {
	for i := len(s.powers); i <= int(k); i++ {
		z := new(big.Int)
		if i == 0 {
			if quadraticScanThreshold%14 != 0 {
				panic("quadraticScanThreshold % 14 != 0")
			}
			z.Exp(big.NewInt(1e14), big.NewInt(quadraticScanThreshold/14), nil)
		} else {
			z.Mul(s.powers[i-1], s.powers[i-1])
		}
		s.powers = append(s.powers, z)
	}
	return s.powers[k]
}

func (s *scanner) scan(z *big.Int, str string) {
	if len(str) <= quadraticScanThreshold {
		z.SetString(str, 10)
		return
	}
	sz, pow := s.chunkSize(len(str))
	s.scan(z, str[:len(str)-sz])
	s.scan(z, str[len(str)-sz:])
	z.Add(z, new(big.Int).Mul(z, pow))
}

const quadraticScanThreshold = 1232