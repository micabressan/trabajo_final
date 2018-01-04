package main
 
import (
	"math/rand"
	"fmt"
	"time"
	"math"
	"runtime"
)
 
type ProbeRes struct {
	np int
	p, d float64
}
type Frac struct {
	n int
	d int
}
var DaysInYear int = 365
 
func main(){
	sigma := 5.0
	for i := 2; i <= 5;i++{
		res, dur := GetNP(i,sigma,0.5)
		fmt.Printf("%d collision: %d people, P = %f +/- %f, took %s\n",i,res.np,res.p,res.d,dur)
	}
}
 
func GetNP(n int, n_sigmas, p_thresh float64) (res ProbeRes, dur time.Duration){
	start := time.Now()
	res.np = DaysInYear*(n-1)
	for i := 0; i < DaysInYear * (n-1);i++ {
		tmp := probe(i,n,n_sigmas,p_thresh)
		if tmp.p > p_thresh && tmp.np < res.np{
			res = tmp
		}
	}
	dur = time.Since(start)
	return
}
func probe(np,n int, n_sigmas, p_thresh float64) ProbeRes{
	var p,d float64
	var runs, yes int
	cRes := make(chan Frac,runtime.NumCPU())
	for i:=0; i < runtime.NumCPU();i++{
		go SimN(np,n,25,cRes)
	}
	for math.Abs(p - p_thresh) < n_sigmas * d || runs < 100{
		f := <-cRes
		yes += f.n
		runs += f.d
		p = float64(yes) / float64(runs)
		d = math.Sqrt(p * (1 - p) / float64(runs))
		go SimN(np,n,runs/3,cRes)
 
	}
	return ProbeRes{np,p,d}
}
func SimN(np,n, ssize int, c chan Frac){
	yes := 0
	for i := 0;i < ssize;i++  {
		if Sim(np,n) {
			yes++
		}
 
	}
	c <- Frac{yes,ssize}
}
func Sim(p,n int) ( res bool){
	Cal := make([]int,DaysInYear)
	for i := 0;i < p ;i++{
		Cal[rand.Intn(DaysInYear)]++
	}
	for _,v := range Cal{
		if v >= n {
			res = true
		}
	}
	return
}