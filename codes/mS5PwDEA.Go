package main

import (
	"fmt"
)

type Generator struct {
	Factor   int
	Previous int
	Multiple int
	outChan  chan int
}

func (g *Generator) Next() int {
	const div = 2147483647
	g.Previous = (g.Previous * g.Factor) % div
	return g.Previous
}

func (g *Generator) Run() {
	for {
		o := g.Next()
		if o%g.Multiple == 0 {
			g.outChan <- g.Previous
		}
	}
}

func main() {
	// 883, 879
	aChan, bChan := make(chan int), make(chan int)
	a := &Generator{16807, 883, 4, aChan}
	b := &Generator{48271, 879, 8, bChan}

	go a.Run()
	go b.Run()

	var total int

	for i := 0; i < 5000000; i++ {
		ca := <-aChan
		cb := <-bChan
		ca = ca << (64 - 16)
		cb = cb << (64 - 16)
		if ca == cb {
			total += 1
		}
	}

	fmt.Println(total)
}