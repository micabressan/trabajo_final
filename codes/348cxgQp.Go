package main

import (
	"encoding/json"
	"fmt"
	"testing"
)

type I struct {
	A string
	B int
	M map[string]string
}

type T struct {
	A string
	B int
	M map[string]string
	I interface{}
}

var d = createT()

func BenchmarkJsonMarshal(b *testing.B) {

	for n := 0; n < b.N; n++ {
		b, _ := json.Marshal(d)
		b = b
	}

}

func BenchmarkStreamPrintPlusV(b *testing.B) {

	for n := 0; n < b.N; n++ {
		b := fmt.Sprintf("%+v", d)
		b = b
	}
}
func BenchmarkStreamPrintHashV(b *testing.B) {

	for n := 0; n < b.N; n++ {
		b := fmt.Sprintf("%#v", d)
		b = b
	}
}
func BenchmarkStreamPrintPureV(b *testing.B) {

	for n := 0; n < b.N; n++ {
		b := fmt.Sprintf("%v", d)
		b = b
	}
}

func createT() T {

	s := I{
		A: "string",
		B: 42,
		M: map[string]string{
			"Key1": "Value1",
			"Key2": "Value2",
		},
	}

	return T{
		A: "string",
		B: 42,
		M: map[string]string{
			"Key1": "Value1",
			"Key2": "Value2",
		},
		I: s,
	}
}

/*

 go test -benchmem -bench=.
BenchmarkJsonMarshal-4        	  500000	      3095 ns/op	    1216 B/op	      25 allocs/op
BenchmarkStreamPrintPlusV-4   	  500000	      2677 ns/op	     616 B/op	      21 allocs/op
BenchmarkStreamPrintHashV-4   	  500000	      3546 ns/op	     696 B/op	      21 allocs/op
BenchmarkStreamPrintPureV-4   	 1000000	      2223 ns/op	     560 B/op	      14 allocs/op
PASS
ok  	_/home/adam/Go/src	7.009s

*/