package main

import "fmt"

func main() {
	ch := make(chan int, 4)
	ch <- 2
	ch <- 4
	close(ch)
	// ch <- 6 // panic, send on closed channel

	fmt.Println(<-ch)
	fmt.Println(<-ch)
	fmt.Println(<-ch) // closed, returns zero value for element
}