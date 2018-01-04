package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
    "strings"
    "log"
)

type preke struct {
    pavadinimas string
    kiekis int
}

type sunkvezimis struct {
    pavadinimas string
    nr  int
    kaina float64
}
 
func main() {
    //fmt.Printf("hello, world\n")
    P, V := Nuskaitymas()
    
    fmt.Println(len(P), "sunkvezimis")
    fmt.Println(len(V), "prekes")
    Spausdinimas(P, V)
}

func Spausdinimas(P [][] sunkvezimis, V [][] preke){
    file, err := os.Create("IFF56_BorovikovasM_L3a_rez.txt")
    if err != nil {
        log.Fatal("Cannot create file", err)
    }
    defer file.Close()

    fmt.Fprintln(file, "-- Rezultatai --")
    fmt.Println("-- Rezultatai --")

    fmt.Fprintln(file, "-- P masyvai --")    
    fmt.Println("-- P masyvai --")

    for i := 0; i < len(P); i++{
        fmt.Fprintf(file, "Masyvas P%d\n",i+1)
        fmt.Fprintf(file, "%2s %-12s %6s %10s\n" , "Nr.", "Pavadinimas", "id", "Kaina")
        fmt.Printf("Masyvas P%d\n",i+1)
        fmt.Printf("%2s %-12s %6s %10s\n" , "Nr.", "Pavadinimas", "id", "Kaina")
        for j := 0; j < len(P[i]); j++{
            fmt.Fprintf(file, "%2d) %-12s %6d %10.2f\n", j+1, P[i][j].pavadinimas, P[i][j].nr, P[i][j].kaina)
            fmt.Printf("%2d) %-12s %6d %10.2f\n", j+1, P[i][j].pavadinimas, P[i][j].nr, P[i][j].kaina)
        }
    } 

    fmt.Fprintln(file, "-- V masyvai --")    
    fmt.Println("-- V masyvai --")

    for i := 0; i < len(V); i++{
        fmt.Fprintf(file, "Masyvas V%d\n",i+1)
        fmt.Fprintf(file, "%2s %-12s %8s\n" , "Nr.", "Pavadinimas", "Kiekis")
        fmt.Printf("Masyvas P%d\n",i+1)
        fmt.Printf("%2s %-12s %8s\n" , "Nr.", "Pavadinimas", "Kiekis")
        for j := 0; j < len(V[i]); j++{
            fmt.Fprintf(file, "%2d) %-12s %8d\n", j+1, V[i][j].pavadinimas, V[i][j].kiekis)
            fmt.Printf("%2d) %-12s %8d\n", j+1, V[i][j].pavadinimas, V[i][j].kiekis)
        }
    } 

}

func Nuskaitymas()( sunkvezimiai [][] sunkvezimis, prekes [][] preke) {
	file, err := os.Open("IFF56_BorovikovasM_L3a_dat1.txt")
	if err != nil {
		panic(err)
	}
    defer file.Close()
    
    sunkvezimiai = make([][] sunkvezimis,0)
    krovinys := make([]sunkvezimis, 0)

	prekes = make([][] preke,0)
    krepselis := make([]preke, 0)    

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	pKiek, _ := strconv.Atoi(scanner.Text())
	scanner.Scan()
	vKiek, _ := strconv.Atoi(scanner.Text())
	//fmt.Println(pKiek)
    //fmt.Println(vKiek)
        
	for i := 0; i < pKiek; i++ {
		scanner.Scan()
		line := scanner.Text()
		if line != "" {
			values := strings.Split(line, " ")
			kiek, _ := strconv.Atoi(values[1])
			//fmt.Println(kiek)
			for j := 0; j < kiek; j++ {
				scanner.Scan()
				line := scanner.Text()
				if line != "" {
                    s := strings.Split(line, " ")
                    pav := s[0]
                    kiekis, _ := strconv.Atoi(s[1])
                    kaina, _ := strconv.ParseFloat(s[2], 64)                   
                    krovinys = append(krovinys,sunkvezimis{pav, kiekis, kaina})                                   
                }                
            }
            sunkvezimiai = append(sunkvezimiai, krovinys)
            krovinys = nil
            //fmt.Println(sunkvezimiai[i])
		}
    }

    for i := 0; i < vKiek; i++ {
		scanner.Scan()
		line := scanner.Text()
		if line != "" {
			values := strings.Split(line, " ")
			kiek, _ := strconv.Atoi(values[1])
			//fmt.Println(kiek)
			for j := 0; j < kiek; j++ {
				scanner.Scan()
				line := scanner.Text()
				if line != "" {
                    s := strings.Split(line, " ")
                    pav := s[0]
                    kiekis, _ := strconv.Atoi(s[1])
                    krepselis = append(krepselis, preke{pav, kiekis})  
				}
            }
            prekes = append(prekes, krepselis)
            krepselis = nil
            //fmt.Println(prekes[i])
		}
	}

	if err := scanner.Err(); err != nil {
		panic(err)
    }
    return
}