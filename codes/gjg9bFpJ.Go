package main

import (
        "flag"
        "fmt"
        "math/rand"
        "time"
)

const ITERATIONS = 10000000

var x = 0
var selectivity = flag.Float64("selectivity", 0.5, "selectivity")

func main() {
        flag.Parse()
        start := time.Now()
        for i := 0; i < ITERATIONS; i++ {
                if rand.Float64() < *selectivity {
                        x++
                }
        }
        fmt.Println(time.Now().Sub(start).Seconds())
}