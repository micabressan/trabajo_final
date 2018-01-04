package main

import (
	"log"
	"os"
	"sync"
)

func main() {
	// A goroutine-safe console printer.
	logger := log.New(os.Stdout, "", 0)

	// Sync between goroutines.
	var wg sync.WaitGroup

	// Add goroutine 1.
	wg.Add(1)
	go func() {
		defer wg.Done()
		logger.Println("Print from goroutine 1")
	}()

	// Add goroutine 2.
	wg.Add(1)
	go func() {
		defer wg.Done()
		logger.Println("Print from goroutine 2")
	}()

	// Add goroutine 3.
	wg.Add(1)
	go func() {
		defer wg.Done()
		logger.Println("Print from goroutine 3")
	}()

	logger.Println("Print from main")

	// Wait all goroutines.
	wg.Wait()
}