package main

import fmt "fmt"

func main() {
var ch chan int
ch = make(chan int, 5)
baigti := make(chan int, 0)
go Gavejas(ch, baigti)
go Siuntejas(ch, "1 siuntejas", 11111)
go Siuntejas(ch, "2 siuntejas", 2222)
go Siuntejas(ch, "3 siuntejas", 333)
go Siuntejas(ch, "4 siuntejas", 44)
go Siuntejas(ch, "5 siuntejas", 5)
<-baigti
}
func Siuntejas(kanalas chan int, vardas string, x int) {
	fmt.Println(vardas," siuncia ", x)
	kanalas <- x
}

func Gavejas(kanalas chan int, baigti chan int) {
	a := 99
	a = a+1;
	for i := 0; i < 5; i++ {
		a = <- kanalas
		fmt.Println("gavau", a)
	}
	baigti <- 0
}