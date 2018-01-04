package main

import (
	"fmt"
	"time"
)


func Aptarnaujantis(in [] chan int, outgoing chan float64, stop chan int){

	temp0:=0
	temp1:=0
	gauta:=0

	for true{
		for i:=0; i< len(in);i++{
			select{
			case temp:= <- in[i]:
				if(gauta == 0){
					temp0 = temp
				}else{
					if(gauta ==1){
						temp1 = temp
					}
				}
				gauta++
			case <- stop:
				fmt.Println("sustojau")
				return
			default:
				time.Sleep(50*time.Millisecond)
			}
			if(gauta == 2){
				var avg float64
				avg = (float64(temp0) + float64(temp1))/2
				outgoing <- avg
				gauta =0
			}

		}
	}
}

func Siuntejas(out chan int, masyvas []int, end chan int){

	for i:=0; i<len(masyvas); i++{
		out <- masyvas[i]
	}
	end <- -1
	fmt.Println("baigiau darba")
}

func Gavejas(ingoing chan float64, end chan int){

	eil:= 0
	ends:=0
	for true{
		select{
		case avg:= <- ingoing:
			fmt.Println("Eil, Avg")
			fmt.Println(eil,",",avg)
			eil++
		case <- end:
			ends++
		default:
			time.Sleep(50*time.Millisecond)
		}
		/*if (ends>3){
			fmt.Println("Baigiau")
			return
		}*/
	}
}

func main(){

	masyvastemp :=[] int{1,0,6,7,8,9,1,2,5,4}
	masyvastemp1 :=[] int{3,5,6,7,8,9,1,2,5,4}
	masyvastemp2 :=[] int{3,5,6,7,8,9,1,2,5,4}
	masyvastemp3 :=[] int{3,5,6,7,8,9,1,2,5,4}

	var in [] chan int
	ingoing := make(chan float64,5)
	end := make(chan int, 5)
	stop := make(chan int, 5)

	for i:=0; i<4; i++{
		in = append(in, make(chan int, 10))
	}

	go Siuntejas(in[0], masyvastemp, end)
	go Siuntejas(in[1], masyvastemp1, end)
	go Siuntejas(in[2], masyvastemp2, end)
	go Siuntejas(in[3], masyvastemp3, end)

	go Aptarnaujantis(in, ingoing, stop)

	go Gavejas(ingoing, stop)

	<-end
	<-stop

}