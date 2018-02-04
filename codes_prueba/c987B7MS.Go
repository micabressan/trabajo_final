package main

import (
	"fmt"
	"runtime"
)

func main() {

	runtime.GOMAXPROCS(1)

	c := make(chan bool, 1)

	go func() {
		var x uint64

		fmt.Println("Starting thread 1")

		c <- true

		for {
			x++
		}

		fmt.Printf("x: %v\n", x)

		c <- true
	}()

	<-c

	fmt.Println("Where is my main?")

	<-c
}