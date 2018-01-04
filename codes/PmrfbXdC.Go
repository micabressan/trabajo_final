 package main

import (
	"strconv"
	"strings"
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"runtime"
	"time"
	"flag"
)

func comma(v uint64) string {
	sign := ""
	if v < 0 {
		sign = "-"
		v = 0 - v
	}

	parts := []string{"", "", "", "", "", "", ""}
	j := len(parts) - 1

	for v > 999 {
		parts[j] = strconv.FormatUint(v%1000, 10)
		switch len(parts[j]) {
		case 2:
			parts[j] = "0" + parts[j]
		case 1:
			parts[j] = "00" + parts[j]
		}
		v = v / 1000
		j--
	}
	parts[j] = strconv.Itoa(int(v))
	return sign + strings.Join(parts[j:len(parts)], ",")
}

func formatRate(rate float64) string {
	if(rate >= 1000000000) {
		return fmt.Sprintf("%.2f gC/s", rate / 1000000000)
	} else if(rate >= 1000000) {
		return fmt.Sprintf("%.2f mC/s", rate / 1000000)
	} else if(rate >= 1000) {
		return fmt.Sprintf("%.2f kC/s", rate / 1000)
	} else {
		return fmt.Sprintf("%.2f C/s", rate)
	}
}

func steps(n uint64) uint64 {
	if n <= 0 { return 0; } 
	if n == 1 { return 0; } 

	var steps uint64 

	i := n
	for i != 1 { 
		for (i & 1) == 1 { 
			i = ((3 * i) + 1) / 2 
			steps += 2 
		}

		for (i & 1) == 0 { 
			i /= 2 
			steps++
		}
	}

	return steps
}

type work struct {
	start uint64
	end uint64
}

func worker(req chan work, resp chan uint64) {
	for {
		w := <- req

		var total uint64
		for i := w.start; i < w.end; i++ {
			total += steps(i)
		}
		resp <- total
	}
}

func main() {
	var nthreads int
	var blockSize uint64

	flag.IntVar(&nthreads, "threads", runtime.NumCPU(), "number of worker threads")
	flag.Uint64Var(&blockSize, "work", 1000000, "work unit size")
	flag.Parse()

	if(nthreads <= 0) {
		fmt.Printf("Must have > 0 threads")
		return
	}

	fmt.Printf("Running with %d threads, work size %s\n", nthreads, comma(blockSize))

	reqs  := make([]chan work, nthreads)
	resps := make([]chan uint64, nthreads)

	for i := 0; i < nthreads; i++ {
		reqs[i] = make(chan work)
		resps[i] = make(chan uint64)
		go worker(reqs[i], resps[i])
	}

	stop := make(chan os.Signal, 2)
	signal.Notify(stop, syscall.SIGINT, syscall.SIGTERM)
	go func() {
		<-stop
		os.Exit(0)
	}()

	startTime := time.Now()

	var current uint64
	for {
		for _, req := range reqs {
			var w work
			w.start = current
			w.end = current + blockSize
			req <- w
			current += blockSize
		}

		var total uint64
		for _, resp := range resps {
			total += <-resp
		}

		elapsed := time.Since(startTime)

		fmt.Printf("%s | %s | %s\n", elapsed, comma(current), formatRate(float64(current) / float64(elapsed) * float64(time.Second)))
	}
}