// sketch.go
package main

import "fmt"

func main() {
	fmt.Println(A)
}

// sketch_test.go
package main

var A int = 10

// Console
[12:36:21] ~/go/src/sandbox/sketchbox $ go build .
# sandbox/sketchbox
./sketch.go:6:14: undefined: A