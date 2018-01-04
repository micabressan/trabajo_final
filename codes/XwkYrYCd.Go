package main

import "fmt"
import "strings"

func main() {
	s := strings.Repeat("a", 1e7)
	for i := 0; i < 1e9; i++ {
		fmt.Print(s)
	}
}