package conduit

import (
	"fmt"
	"log"
	"math/rand"
	"testing"
	"time"
)

func init() {
	rand.Seed(1)
}

type divop struct {
	n, d int
	err  error
	ans  int
}

// conduit
func divide(op *divop) *divop {
	time.Sleep(100 * time.Millisecond)
	if op.d == 0 {
		op.err = fmt.Errorf("divide by zero")
	} else {
		op.ans = op.n / op.d
	}
	return op
}  

func op() *divop {
	return &divop{n: rand.Intn(15), d: rand.Intn(4)}
}

func printResult(in *divop) {
	log.Printf("%-d / %-d = %-d %v", in.n, in.d, in.ans, in.err)
}