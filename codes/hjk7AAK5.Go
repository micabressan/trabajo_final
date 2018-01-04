// klobuky project main.go
package main

import (
	"fmt"
	"time"
)

type agent struct {
	id          int
	farba       int
	a1in, a1out chan int
	a2in, a2out chan int
}

var agent0, agent1, agent2 agent

var agenti = []agent{
	agent{
		id:    0,
		farba: 0,
		a1out: agent1.a1in,
		a2out: agent2.a1in,
		a1in:  make(chan int),
		a2in:  make(chan int),
	},
	agent{
		id:    1,
		farba: 1,
		a1out: agent0.a1in,
		a2out: agent2.a2in,
		a1in:  make(chan int),
		a2in:  make(chan int),
	},
	agent{
		id:    2,
		farba: 1,
		a1out: agent0.a2in,
		a2out: agent1.a2in,
		a1in:  make(chan int),
		a2in:  make(chan int),
	},
}

func vidim(id int) (int, int) {

	var sus1, sus2 int
	var far1, far2 int

	sus1 = (id + 1) % 3
	sus2 = (id + 2) % 3

	far1 = agenti[sus1].farba
	far2 = agenti[sus2].farba

	fmt.Println("agent ", id, " ma susedov: ", sus1, sus2, " a vidi farby: ", far1, far2)
	return far1, far2
}

func hraj(hrac agent) {

	go func() {
		fmt.Println("hra hrac:", hrac.id)
		for faza := 0; faza <= 2; faza++ {

			if faza == 0 {
				far1, far2 := vidim(hrac.id)
				if far1 == 1 && far2 == 1 {
					fmt.Println("Agent ", hrac.id, ": Som biely")
					go func() {
						hrac.a1out <- 1
					}()
					go func() {
						hrac.a2out <- 1
					}()
					return
				} else {
					go func() {
						time.Sleep(time.Second * 2)
						f1 := <-hrac.a1in
						f2 := <-hrac.a2in
						if f1 == 1 || f2 == 1 {
							fmt.Println("Agent ", hrac.id, ": Som cierny")
						}
					}()
				}

			} else if faza == 1 {
				far1, far2 := vidim(hrac.id)
				if far1 == 1 && far2 == 1 {
					fmt.Println("Agent ", hrac.id, ": Som cierny")
					go func() {
						hrac.a1out <- 0
					}()
					go func() {
						hrac.a2out <- 0
					}()
					return
				} else if far1 == 1 || far2 == 1 {
					go func() {
						time.Sleep(time.Second * 2)
						f1 := <-hrac.a1in
						f2 := <-hrac.a2in
						if f1 == 1 || f2 == 1 {
							fmt.Println("Agent ", hrac.id, ": Som cierny")
						}
					}()
				}
			} else if faza == 2 {
				fmt.Println("Agent", hrac.id, ": Som cierny")
				return
			}
			time.Sleep(time.Second * 10)
		}
	}()
}

func start() {
	for i := 0; i <= 2; i++ {
		hraj(agenti[i])
	}
}

func main() {
	start()
	time.Sleep(1000000000000)
	return
}