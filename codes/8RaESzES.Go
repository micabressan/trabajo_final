package main

import (
	"fmt"
)

func main() {
	mapka := make(map[string]int)
	mapka["one"] = 10
	_, exist := mapka["one"]
	fmt.Printf("has %s in map: %t\n", "one", exist)
	_, exist = mapka["two"]
	fmt.Printf("has %s in map: %t\n", "two", exist)
}