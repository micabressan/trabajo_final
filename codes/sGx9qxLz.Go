/*
	Sdizo Laboratorium 01
*/ 

package main

import (
	"fmt"
	"io/ioutil"
	"math/rand"
	"strconv"
	"strings"
	"time"
)

// Structure ...
type Structure struct {
	i int32
	f float32
	r rune
}

func buildRandomly(count int32) []*Structure {
	t := make([]*Structure, count)

	rand.Seed(time.Now().UnixNano())

	for j := int32(0); j < count; j++ {
		element := Structure{
			i: int32(rand.Intn(10001) - 1000),
			f: 1000.0 + float32(j+1),
			r: rune(rand.Intn(23) + 66),
		}
		t[j] = &element
	}

	return t
}

func bubbleSort(s *[]*Structure) {
	for i := 0; i <= len(*s)-2; i++ {

		sorted := true
		for j := 0; j <= len(*s)-2-i; j++ {
			if (*s)[j].i > (*s)[j+1].i {
				// swap pointers
				tmp := (*s)[j]
				(*s)[j] = (*s)[j+1]
				(*s)[j+1] = tmp
				sorted = false
			}
		}

		if sorted {
			break
		}
	}
}

func countCharacters(s *[]*Structure, r rune) int32 {
	count := int32(0)
	for _, p := range *s {
		if p.r == r {
			count++
		}
	}
	return count
}

func main() {
	data, err := ioutil.ReadFile("inlab01.txt")

	if err != nil {
		panic(err)
	}

	split := strings.Fields(string(data))

	numberOfStructures, err := strconv.Atoi(split[0])

	if err != nil {
		panic(err)
	}

	characterToFind := []rune(split[1])[0]

	if err != nil {
		panic(err)
	}

	start := time.Now()

	s := buildRandomly(int32(numberOfStructures))
	bubbleSort(&s)
	count := countCharacters(&s, characterToFind)

	elapsedTime := time.Since(start)

	fmt.Println("Program has finished in:", elapsedTime.Seconds())
	fmt.Printf("%d %s characters have been found!\n", count, string(characterToFind))

	for i := 0; i < 20; i++ {
		fmt.Printf("s[%d] = i: %d, f: %f, r: %s\n", i, s[i].i, s[i].f, string(s[i].r))
	}
}