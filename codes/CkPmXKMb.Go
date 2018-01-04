package main

import (
	"fmt"
	"testing"
	"time"

	"github.com/google/btree"
)

type MyItem struct {
	id    int
	value int
}

func (it MyItem) Less(other btree.Item) bool {
	return it.id < other.(MyItem).id
}

func TestBtreeImp(t *testing.T) {

	tree := btree.New(4)
	for i := 4; i < 450000; i++ {

		tree.ReplaceOrInsert(MyItem{id: i, value: i * 10})

	}

	tree2 := map[int]int{}
	for i := 4; i < 450000; i++ {

		tree2[i] = i * 10

	}

	tree22 := make(map[int]int, 450001)
	for i := 4; i < 450000; i++ {

		tree22[i] = i * 10

	}

	tree3 := make([]int, 450000, 450000)
	for index := range tree3 {
		tree3[index] = -1
	}

	for i := 4; i < 450000; i++ {

		tree3[i] = i * 10

	}
	secondids := []int{}
	for i := 4; i < 450000; i = i + 2 {

		secondids = append(secondids, i)

	}

	//Вариант первый - ищем 4500 элементов в tree.Get
	{
		startTime := time.Now().UnixNano() / int64(time.Microsecond)

		result := make([]int, 0, len(secondids))
		/*tree.DescendRange(MyItem{value: 44000}, MyItem{value: 1}, func(i btree.Item) bool {
			return true
		})*/
		for i := 0; i <= len(secondids)-1; i++ {
			if res := tree.Get(MyItem{id: secondids[i]}); res != nil && res.(MyItem).value > 20 && res.(MyItem).value < 410000 {
				result = append(result, secondids[i])
			}
		}
		fmt.Println("result len: ", len(result))
		fmt.Println("btree time", time.Now().UnixNano()/int64(time.Microsecond)-startTime)
	}

	//Вариант второй - ищем 4500 элементов в map для получения value
	{
		startTime := time.Now().UnixNano() / int64(time.Microsecond)

		result := make([]int, 0, len(secondids))
		/*tree.DescendRange(MyItem{value: 44000}, MyItem{value: 1}, func(i btree.Item) bool {
			return true
		})*/
		for i := 0; i <= len(secondids)-1; i++ {
			if res, exists := tree2[secondids[i]]; exists && res > 20 && res < 410000 {
				result = append(result, res)
			}
		}
		fmt.Println("result len: ", len(result))
		fmt.Println("map time", time.Now().UnixNano()/int64(time.Microsecond)-startTime)
	}

	//Вариант второй - ищем 4500 элементов в map для получения value
	{
		startTime := time.Now().UnixNano() / int64(time.Microsecond)

		result := make([]int, 0, len(secondids))
		/*tree.DescendRange(MyItem{value: 44000}, MyItem{value: 1}, func(i btree.Item) bool {
			return true
		})*/
		for i := 0; i <= len(secondids)-1; i++ {
			if res, exists := tree22[secondids[i]]; exists && res > 20 && res < 410000 {
				result = append(result, res)
			}
		}
		fmt.Println("result len: ", len(result))
		fmt.Println("map time 2", time.Now().UnixNano()/int64(time.Microsecond)-startTime)
	}

	//Вариант третий - ищем 4500 элементов в map для получения value
	{
		startTime := time.Now().UnixNano() / int64(time.Microsecond)

		result := make([]int, 0, len(secondids))
		/*tree.DescendRange(MyItem{value: 44000}, MyItem{value: 1}, func(i btree.Item) bool {
			return true
		})*/
		for i := 0; i <= len(secondids)-1; i++ {
			if res := tree3[secondids[i]]; res != -1 && res > 20 && res < 410000 {
				result = append(result, res)
			}
		}
		fmt.Println("result len: ", len(result))
		fmt.Println("slice time", time.Now().UnixNano()/int64(time.Microsecond)-startTime)
	}

	//Просто тест
	{
		cnt := 0
		startTime := time.Now().UnixNano() / int64(time.Microsecond)
		for i := 4; i < 45000; i++ {
			if res := tree.Get(MyItem{id: i}); res != nil && res.(MyItem).value > 20 && res.(MyItem).value < 41000 {
				cnt++
			}
		}
		fmt.Println(cnt)
		fmt.Println("juestsearch time", time.Now().UnixNano()/int64(time.Microsecond)-startTime)
	}
	t.Error("")
}