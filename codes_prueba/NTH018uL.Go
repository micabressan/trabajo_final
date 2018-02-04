package main

import "fmt"
import "net/http"

func main() {
	http.ListenAndServe(":5555", nil)
}