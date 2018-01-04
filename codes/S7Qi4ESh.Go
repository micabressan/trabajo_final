package main

import (
	"fmt"
	"time"
)

func controller(in chan int, out chan int, stop chan int){
	fmt.Println("Controller woke up")
	var myslice []int
	n := 0
	for (len(myslice) < 100){
		temp_f:=0
		select{
		case temp_f = <-in:
			n++
			if(temp_f <3){
			myslice = append(myslice,temp_f)
			fmt.Println("Appending")
			} else {
				myslice = append([]int{temp_f},myslice...)
				}
		default:
			fmt.Println("Waiting for senders")
			time.Sleep(20*time.Millisecond)
		}
		if n == 10{
			for i := 0; i <len(myslice); i++{
				out <-myslice[i]
			}
			out <--1
			n = 0
		}

	}
	for i:= 0; i<5; i++{
		stop <-1
	}
	fmt.Println(myslice)
	//out <- 1
}

func receiver(in chan int, stop chan int, end chan int){
	var arr []int
	for (true) {
		select {
		case num := <-in:
			if (num > 0) {
				arr = append(arr, num)
			} else {
				fmt.Println(arr)
				arr = []int{}
			}
		case <-stop:
			fmt.Println("Receiver stopping")
			end <--1
			return
		default:
			time.Sleep(time.Millisecond * 20)
		}
	}
}

func sender(nr int, out chan int, stop chan int){
	fmt.Println("Sender woke up", nr)
	for(true){
	select{
	case <- stop:
		fmt.Println("Sender stopping", nr)
		return
	default:
		fmt.Println("Sender sending", nr)
		out <-nr
		time.Sleep(15 * time.Millisecond)
	}
	}
}

func main() {
	in := make(chan int, 20)
	out := make(chan int, 10)
	stop := make(chan int, 5)
	end := make(chan int)
	go controller(in, out, stop)
	for i:= 1; i<5; i++{
		go sender(i,in,stop)
	}
	go receiver(out, stop, end)
	<-end
	fmt.Println("Main finished")
}