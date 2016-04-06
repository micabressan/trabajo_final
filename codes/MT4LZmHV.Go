package main

import (
	"io"
	"net/http"
)

func hello(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "This is the response")
}

func main() {
  http.HandleFunc("/test", hello)
  http.ListenAndServe(":8000", nil)
}