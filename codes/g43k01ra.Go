package main

import (
	"strconv"
	"bufio"
    "fmt"
    //"io/ioutil"
	"container/list"
	"strings"
	"os"
	"log"
)
	
type krepsininkas struct {
    pavarde string
    pozicija  int
	ppg float64
}

type position_count struct {
	pozicija int
	count int
}

func main() {
	lst := list.New()
	kreps := krepsininkas{"gudauskas", 1, 11.1}
	lst.PushFront(kreps)
	/*for i := lst.Front(); i != nil; i = i.Next(){
		fmt.Println(i.Value.(krepsininkas).pozicija)
	}*/
	Read();
/*var ch chan int
ch = make(chan int, 5)
baigti := make(chan int, 0)
go Gavejas(ch, baigti)
go Siuntejas(ch, "1 siuntejas", 11111)
go Siuntejas(ch, "2 siuntejas", 2222)
go Siuntejas(ch, "3 siuntejas", 333)
go Siuntejas(ch, "4 siuntejas", 44)
go Siuntejas(ch, "5 siuntejas", 5)
<-baigti*/
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

func Read(kasior list) {
	//kasior := list.New()
	file, err := os.Open("data.txt") // just pass the file name
    if err != nil {
        fmt.Print(err)
	}

	scanner := bufio.NewScanner(file)
	scanner.Scan();
	for scanner.Scan(){
		line := scanner.Text()
		if(line != ""){
			s := strings.Split(line," ")
			sk, err := strconv.Atoi(s[1])
			if(err != nil){
				fmt.Print(err)}
			fl, err := strconv.ParseFloat(s[2],64)
			if(err != nil){
				fmt.Print(err)}
			kreps := krepsininkas{s[0], sk, fl}
			kasior.PushFront(kreps)
		fmt.Println(kreps.pavarde)
	}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

    	/*str := string(b) // convert content to a 'string'
		s := strings.Split(str," ")

    	fmt.Println(s[1]) // print the content as a 'string'*/
		//return kasior;
    }