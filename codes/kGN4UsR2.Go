package main

import (
	"os"
	"fmt"
	"strconv"
)

func main() {

	first, _ := strconv.Atoi(os.Args[1])
	second, _ := strconv.Atoi(os.Args[2])

	res_first, res_second:=findMinimal(first, second)
	fmt.Println(res_first, res_second)
}

func findMinimal (first int, second int) (int, int){

	base_first := first
	base_second := second
	for first != 0 && second != 0 {
		switch {
		case first > second:
			first = first % second
		default:
			second = second % first
		}
	}

	return base_first/(first + second), base_second / (first + second)

}