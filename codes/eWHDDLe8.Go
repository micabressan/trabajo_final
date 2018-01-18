package main

import (
	"fmt"
	"math/rand"
)

func sort(arr [][]int) [][]int {
	var (
		temp         int
		nextI, nextJ int
		sorted       bool
	)

	for !sorted {
		sorted = true

		for i, row := range arr {
			for j := range row {
				nextI = i
				nextJ = j + 1

				if nextJ >= len(row) {
					nextI = i + 1
					nextJ = 0
				}

				if nextI >= len(arr) {
					nextI = i
					nextJ = j
				}

				if arr[i][j] > arr[nextI][nextJ] {
					sorted = false
					temp = arr[i][j]
					arr[i][j] = arr[nextI][nextJ]
					arr[nextI][nextJ] = temp
				}
			}
		}
	}

	return arr
}

func createRandom(rows, columns int) [][]int {
	var (
		arr = make([][]int, rows)
		row []int
	)
	for i := range arr {
		row = make([]int, columns)
		for j := range row {
			row[j] = rand.Intn(100)
		}

		arr[i] = row
	}

	return arr
}

func main() {
	var (
		arr = createRandom(3, 3)
	)

	fmt.Println("Original:\t", arr)
	fmt.Println("Sorted:\t\t", sort(arr))
}