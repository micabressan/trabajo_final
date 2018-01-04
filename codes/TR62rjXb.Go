package main

import "fmt"
import "strings"

func main() {
	fmt.Println(strings.Repeat("a", 9999))
}

====

package main

import "fmt"
import "strings"

func main() {
	fmt.Println(strings.Repeat("a", 99999))
}