package main

import (
	"fmt"
)

func main() {
	var intArrayLen, numOfQueries, query int64
	fmt.Scanf("%d%d", &intArrayLen, &numOfQueries)

	intArray := make([]int64, intArrayLen)
	for i := int64(0); i < intArrayLen; i++ {
		fmt.Scanf("%d", &intArray[i])
	}

	for i := int64(0); i < numOfQueries; i++ {
		fmt.Scanf("%d", &query)

		left := int64(0)
		right := intArrayLen - 1
		result := int64(-1)

		for left <= right {
			mid := (left + right) / 2
			if intArray[mid] == query {
				result = mid
				right = mid - 1
			} else if query < intArray[mid] {
				right = mid - 1
			} else {
				left = mid + 1
			}
		}
		fmt.Printf("%d\n", result)
	}
}