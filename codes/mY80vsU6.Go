package main

import "fmt"

func main() {
	message := make(chan string)

	go func() {
		message <- "Hello from channel"
	}()

	msg := <-message
	fmt.Println(msg)
}