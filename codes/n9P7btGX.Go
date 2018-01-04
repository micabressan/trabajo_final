package main

import (
	"os"
	"log"
	"bufio"
	"strconv"
	"strings"
	"fmt"
	"time"
)

type P struct {
	//Laptop
	name   string
	keys   int
	weight float64
}

type V struct {
	name  string
	count int
}

type B struct {
	name  string
	count int
}

// communication channels
var IO_P_msg []chan int
var IO_V_msg []chan int

var P_B_msg []chan int
var V_B_msg []chan int

func insert(b1 B, ba *[]B, i int) {
	if len(*ba) == 0 {
		*ba = append(*ba, b1) //When array empty
	} else {
		*ba = append(*ba, b1)        //Append one temp to end of ba
		copy((*ba)[i+1:], (*ba)[i:]) //Copies b[n] to b[n+1], from i
		(*ba)[i] = b1                //assigns our b1
	}
}

func add_to_B(p1 P, ba *[]B) {
	bn := B{p1.name, 1}
	end := len(*ba)
	if len(*ba) == 0 {
		insert(bn, ba, 0)
	}
	for i := 0; i < end; i++ {
		cmp := strings.Compare(bn.name, (*ba)[i].name)
		if cmp == -1 {
			insert(bn, ba, i)
			return
		} else if cmp == 0 {
			(*ba)[i].count++
			return
		} else if cmp == 1 {
			if len(*ba)-i == 1 {
				insert(bn, ba, i+1)
			}
		}
	}
}

func remove_from_B(v1 V, ba *[]B) (removed bool) {
	for i := 0; i < len(*ba); i++ {
		if (*ba)[i].count >= v1.count && (*ba)[i].name == v1.name {
			(*ba)[i].count -= v1.count
			if (*ba)[i].count == 0 { //if no left
				copy((*ba)[i:], (*ba)[i+1:]) // shift all from i to end to left
				//(*ba)[len(*ba)-1] = B{} //
				(*ba) = (*ba)[:len(*ba)-1]
			}

			return true;
		}
	}
	return false;
}

func consumer(IO_V_msg chan int, V_B_msg chan int, IO_V chan V, V_B chan V) {
	fmt.Println("Consumer made")

	n := <-IO_V_msg //Waits till size is given as a sign that it can start

	fmt.Println("Consumer started, n: " + strconv.Itoa(n))
	V_array := make([]V, n)
	for i := 0; i < n; i++ {
		V_temp := <-IO_V
		V_array[i] = V_temp
		//fmt.Println(V_temp)
	}
	IO_V_msg <- n
	//fmt.Println("Consumer got its data")
	consumer_finished := false
	V_B_msg <- n
	//fmt.Println("Is dis working?")
	for consumer_finished == false {
		msg := <-V_B_msg //Wait to be requested
		if msg != 1 {
			fmt.Println("Consumer required ", n)
			for i := 0; i < n; i++ {
				V_B <- V_array[i]
			}
		} else {
			consumer_finished = true
			fmt.Println("Consumer finished")
		}
	}
}

func producer(IO_P_msg chan int, P_B_msg chan int, IO_P chan P, P_B chan P) {
	fmt.Println("Producer made")
	n := <-IO_P_msg //Waits till size is given as a sign that it can start

	fmt.Println("Producer started, n: " + strconv.Itoa(n))
	P_array := make([]P, n)
	for i := 0; i < n; i++ {
		P_temp := <-IO_P
		P_array[i] = P_temp
	}

	IO_P_msg <- n
	fmt.Println("Producer got its data", n)
	for i := 0; i < n; i++ {
		P_B <- P_array[i]
	}
	//fmt.Println("Producer produced")
	P_B_msg <- 0
}

func IO_routine(filename_dat string, filename_res string, IO_P_count chan int, IO_V_count chan int, IO_END chan int, IO_P chan P, IO_V chan V, B_IO chan B, B_IO_msg chan int) {

	file, err := os.Open(filename_dat)
	if err != nil {
		log.Fatal(err)
	}

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	P_count, _ := strconv.Atoi(scanner.Text())
	IO_P_count <- P_count
	scanner.Scan()
	V_count, _ := strconv.Atoi(scanner.Text())
	IO_V_count <- V_count

	P_all := make([][]P, P_count)
	V_all := make([][]V, V_count)

	fmt.Println("File contains: P: ", P_count, " V: ", V_count)

	for i := 0; i < P_count; i++ {
		scanner.Scan()
		n, _ := strconv.Atoi(scanner.Text())
		//fmt.Println("Of n:", n)
		P_all[i] = make([]P, n)
		for j := 0; j < n; j++ {
			scanner.Scan()
			values := strings.Split(scanner.Text(), " ")
			P_all[i][j].name = values[0]
			P_all[i][j].keys, _ = strconv.Atoi(values[1])
			P_all[i][j].weight, _ = strconv.ParseFloat(values[2], 64)

		}

	}
	for i := 0; i < V_count; i++ {
		scanner.Scan()
		n, _ := strconv.Atoi(scanner.Text())
		//fmt.Println("Of n:", n)
		V_all[i] = make([]V, n)
		for j := 0; j < n; j++ {
			scanner.Scan()
			values := strings.Split(scanner.Text(), " ")
			V_all[i][j].name = values[0]
			V_all[i][j].count, _ = strconv.Atoi(values[1])

		}

	}
	//fmt.Println(P_all)
	//fmt.Println(V_all)

	// Writing initial data to results file
	file_res, err := os.Create(filename_res)
	if err != nil {
		log.Fatal(err)
	}
	dashes := "-------------------------------------"
	for i := 0; i < P_count; i++ {
		file_res.WriteString("P nr: " + strconv.Itoa(i) + "\n")
		file_res.WriteString(dashes + "\n")
		for j := 0; j < len(P_all[i]); j++ {
			s := P_all[i][j].name
			k := strconv.Itoa(P_all[i][j].keys)
			d := strconv.FormatFloat(P_all[i][j].weight, 'f', -1, 64)
			full_s := fmt.Sprintf("|%*s | %*s | %*s | ", 16, s, 5, k, 7, d) //formats full string
			file_res.WriteString(full_s + "\n")                             //Prints formatted full string
		}
		file_res.WriteString(dashes + "\n")
	}

	dashes = "---------------------------"
	for i := 0; i < V_count; i++ {
		file_res.WriteString("V nr: " + strconv.Itoa(i) + "\n")
		file_res.WriteString(dashes + "\n")
		for j := 0; j < len(V_all[i]); j++ {
			s := V_all[i][j].name
			k := strconv.Itoa(V_all[i][j].count)
			full_s := fmt.Sprintf("|%*s | %*s |", 16, s, 5, k)
			file_res.WriteString(full_s + "\n")
		}
		file_res.WriteString(dashes + "\n")
	}

	//feeding producers with data
	for i := 0; i < P_count; i++ {
		for j := 0; j < len(P_all[i]); j++ {
			IO_P <- P_all[i][j]
		}
		IO_P_msg[i] <- len(P_all[i])
		fmt.Println(<-IO_P_msg[i])
	}

	for i := 0; i < V_count; i++ {
		for j := 0; j < len(V_all[i]); j++ {
			IO_V <- V_all[i][j]
		}
		IO_V_msg[i] <- len(V_all[i])
		fmt.Println(<-IO_V_msg[i])
	}

	B_IO_msg <- 0

	var B_all ([]B)

	B_left := true
	for B_left {
		B_temp, more := <-B_IO
		if more {
			B_all = append(B_all, B_temp)
		} else {
			B_left = false;
		}
	}
	fmt.Println("IO about to end")

	<-B_IO_msg
	fmt.Println("IO just ended its life")
	file_res.WriteString("Unconsumed: " + "\n")
	file_res.WriteString(dashes + "\n")
	for i := 0; i < len(B_all); i++ {
		s := B_all[i].name
		k := strconv.Itoa(B_all[i].count)
		full_s := fmt.Sprintf("|%*s | %*s |", 16, s, 5, k)
		file_res.WriteString(full_s + "\n")
	}
	file_res.WriteString(dashes + "\n")
	file_res.Close()
	IO_END <- 68008

}

func controller(P_B_msg [] chan int, V_B_msg [] chan int, P_B chan P, V_B chan V, B_IO chan B, B_IO_msg chan int) {
	fmt.Println("Controller made")

	<-B_IO_msg //IO started controller
	V_count := len(V_B_msg)


	V_units_total := 0
	for i := 0; i < V_count; i++ {
		select {
		case temp := <-V_B_msg[i]:
			V_units_total += temp
			//fmt.Println("Consuma sended temp ", i)
		default:
			fmt.Println("Dis din't send temp", i)
		}
	}
	V_to_done := V_units_total
	fmt.Println("Just befor consumin")
	P_count := len(P_B_msg)
	P_to_done := P_count

	for i := 0; i < V_count; i++ {
		V_B_msg[i] <- 0
		//fmt.Println("CONSUMERS, CONSUM!!!")
	}

	var B_all []B
	removed_cycle := false
	added_B := false
	end_loop := false
	fmt.Println("Just before loopin")
	cycles_removed := false
	for ((P_to_done > 0 || removed_cycle == true) || (len(B_all) > 0) || added_B == true) && (end_loop == false){
		fmt.Println("Loop started. B size: ", len(B_all))
		removed_cycle = false
		added_B = false
		select {
		case p_temp := <-P_B:
			fmt.Println("P sendin data! Woooo, workin", p_temp)
			add_to_B(p_temp, &B_all)
			added_B = true
		default:
			time.Sleep(20 * time.Millisecond)
		}
		//If producers haven't done their producing, will test if some did done this
		if (P_to_done > 0) {
			for i := 0; i < P_count; i++ {
				select {
				case <-P_B_msg[i]:
					P_to_done--
				default:
					fmt.Println("P still active ", i)
					fmt.Println("P to done: ", P_to_done)
				}
			}
		}
		select {
		case V_temp := <-V_B:
			V_to_done--
			removed := remove_from_B(V_temp, &B_all)
			if (removed == true) {
				removed_cycle = true
				cycles_removed = true
				fmt.Println("Removed ", V_temp)

			} else{
				fmt.Println("Wasnt removed: ", V_temp)
			}
		default:
			fmt.Println("Consumer didn't consume")
		}

		if (((cycles_removed == false && V_to_done == 0) || (cycles_removed == true && len(B_all) == 0)) && P_to_done == 0) { //NEED TO CHANGE to (removed_cycle == false && V_to_done == 0 && P_to_done == 0)
			fmt.Println("End stuff?")
			for i := 0; i < V_count; i++ {
				V_B_msg[i] <- 1
			}
			end_loop = true
		}
		if ((V_to_done == 0 && cycles_removed == true) && end_loop == false) {
			for i := 0; i < V_count; i++ {
				V_B_msg[i] <- 0
			}
			V_to_done = V_units_total
			cycles_removed = false
		}
	}
	fmt.Println("Controller ended for loop")
	for i := 0; i < len(B_all); i++ {
		B_IO <- B_all[i]
	}
	close(B_IO)
	fmt.Println("Controller finally ended")
	B_IO_msg <- len(B_all)

}

func main() {
	filename_dat := "IFF59_MinelgaM_L2_dat_1.txt"
	filename_res := "IFF59_MinelgaM_L3a_rez.txt"

	// create communication channels
	IO_P_count := make(chan int)
	IO_V_count := make(chan int)
	IO_END := make(chan int)
	P_B := make(chan P, 100) // buffer of 100 in case of max 10 threads getting max 10 objects
	V_B := make(chan V, 100)
	IO_P := make(chan P, 10) // buffer of 10 for a single array of max size = 10
	IO_V := make(chan V, 10)
	B_IO := make(chan B, 100)
	B_IO_msg := make(chan int)

	go IO_routine(filename_dat, filename_res, IO_P_count, IO_V_count, IO_END, IO_P, IO_V, B_IO, B_IO_msg)

	P_count := <-IO_P_count
	V_count := <-IO_V_count
	fmt.Println(P_count)
	fmt.Println(V_count)

	for i := 0; i < P_count; i++ { //Producers initiate
		temp1 := make(chan int)
		temp2 := make(chan int)
		IO_P_msg = append(IO_P_msg, temp1)
		P_B_msg = append(P_B_msg, temp2)
		go producer(IO_P_msg[i], P_B_msg[i], IO_P, P_B)
	}

	for i := 0; i < V_count; i++ { //Consumers initiate
		temp1 := make(chan int)
		temp2 := make(chan int)
		IO_V_msg = append(IO_V_msg, temp1)
		V_B_msg = append(V_B_msg, temp2)
		go consumer(IO_V_msg[i], V_B_msg[i], IO_V, V_B)
	}

	go controller(P_B_msg, V_B_msg, P_B, V_B, B_IO, B_IO_msg)

	<-IO_END //Waits till de IO end

}