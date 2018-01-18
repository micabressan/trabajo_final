package main

import "fmt"

func formatLessThan4(nameList []string) interface{} {
	format := map[int]interface{}{
		0: func(nameList []string) {
			fmt.Printf("no one likes this")
		},
		1: func(nameList []string) {
			fmt.Printf("%s likes this", nameList[0])
		},
		2: func(nameList []string) {
			fmt.Printf("%s and %s like this", nameList[0], nameList[1])
		},
		3: func(nameList []string) {
			fmt.Printf("%s, %s and %s like this", nameList[0], nameList[1], nameList[2])
		},
	}
	return func() {
		format[len(nameList)].(func([]string))(nameList)
	}
}

func fb(nameList []string) interface{} {
	formatFunc := map[bool]interface{}{
		true: formatLessThan4(nameList),
		false: func() {
			fmt.Printf("%s, %s and %d others like this", nameList[0], nameList[1], len(nameList)-2)
		},
	}
	return formatFunc[len(nameList) < 4]
}
func main() {
	like := []string{"Peter"}
	fb(like).(func())()
}