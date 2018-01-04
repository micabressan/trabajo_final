package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return lim
}

func nieco(x, y int) (int, int, string) {
	if x + y == 0 {
		return (0, "", "")
	}
	return (x + y, "a", "b")
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
		nieco(0, 0),
		nieco(1, 5),
	)