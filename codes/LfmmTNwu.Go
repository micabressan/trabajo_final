package main

import (
	"log"
	"os"
	"sync"
)

func main() {
	// A goroutine-safe console printer.
	logger := log.New(os.Stdout, "", 0)

	// Sync among all goroutines.
	var wg sync.WaitGroup

	// Make a buffered channel.
	ch := make(chan int, 10)

	for i := 1; i <= 10; i++ {
		ch <- i
		wg.Add(1)
		go func() {
			defer wg.Done()
			logger.Println("Print from goroutine ", <-ch)
		}()
	}

	logger.Println("Print from main")
	wg.Wait()
}