package main

import "fmt"

type number interface {
	equal(A number) bool
}

type Num int64

type Float float64

type Problem struct {
	statement string
	result    number
	typ       string
}

func (a *Num) equal(b Num) bool {
	return int64(*a) == int64(b)
}

func (a *Float) equal(b Float) bool {
	return float64(*a) == float64(b)
}

func main() {
	P := Problem{
		"Mám n jabĺčok, zjem polovicu. Príde Janka a zje ešte dve tretiny toho čo ostane. A potom sa ešte zjavia tri deti a každé si zoberie po dve jabĺčka a už nič neostane. Koľko som mal jabĺčok?",
		Num(36),
		"MAT",
	}
	fmt.Println(Problem)
}