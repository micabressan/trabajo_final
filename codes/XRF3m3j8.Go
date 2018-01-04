package main

import (
	"http"
	"io"
)

type mydata struct {
	somedata int
}

func main() {
	// How to pass the below array to HelloServer()?
	var passme [10]mydata
	passme[1].somedata = 1 // must be used to pass compile

	http.HandleFunc("/hello", HelloServer)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic("ListenAndServe: " + err.String())
	}
}

// hello world, the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	// Sure do wish I could use `passme` here...

	io.WriteString(w, "hello, world!\n")
}