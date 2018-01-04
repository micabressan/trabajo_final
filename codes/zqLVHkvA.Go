package main

import (
	"fmt"
)

func main () {
	array := []int{ 98, 93, 77, 82, 83 }

	fmt.Println(AddClient(array, 6,13))
	fmt.Println(RemoveClient(array, 2))
}

func AddClient (Array []int, Position int, Value int) []int {   // len = 6     position = 3

	if Position < len(Array) {
		Array = append(Array, Array[len(Array)-1])  //5
		for x:=len(Array)-1; Position < x; x-- {

			Array[x] = Array[x-1]
		}
		Array[Position] = Value

	} else {
		for x:=len(Array); x <= Position; x++ {
			Array = append(Array, 0)
		}    //len = 5 pos = 7
		Array[Position] = Value
	}
	return Array
}

func RemoveClient(Array []int, Position int) []int {

	if Position <= len(Array)-1 {
		//delete pos = 2   array len = 5   poslednij = 4
		NewArray := make([]int, len(Array)-1)
		for x:=Position+1; x <= len(Array)-1; x++ {
			NewArray[x-1] = Array[x]
		}
		for a:=0;a<Position;a++ {
			NewArray[a] = Array[a]
		}
		return NewArray
	} else {
		fmt.Println("ну ты дурак? как можно удалить то, чего нет??")
		return Array
	}
}