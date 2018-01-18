package main

import 	"fmt"

const count = 1000

var(
	values []int
	tested []int
)

/*
*/
func main(){

	index:=0

	MainLoop:
	for i:=1;len(values)<count;i++ {

		tested = append(tested,i)

		for _, testValue := range tested {

			switch{
				case testValue == i:

					values = append(values,i)
					index++

				case testValue>1 && i%testValue == 0:

					continue MainLoop
			}

		}
	}
	fmt.Println("Values: ",values)
}