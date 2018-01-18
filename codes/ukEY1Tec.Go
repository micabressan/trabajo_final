package main

import "fmt"

const count = 100000

var (
	values []int
)

/*
*/
func main() {

	values = append(values, 2)
OuterLoop:
	for i := 3; len(values) <= count; i = i + 2 {
		for _, value := range values {
			if i%value == 0 {
				continue OuterLoop
			}
		}
		values = append(values, i)

	}
	fmt.Println("Values: ", values)
}