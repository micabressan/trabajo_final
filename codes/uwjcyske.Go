package main

import (
	"fmt"
	"log"
	"net/http"
)

func main()  {
	http.HandleFunc("/", index)
	http.HandleFunc("/product", product)
	log.Fatal(http.ListenAndServe("localhost:8000", nil))
}

func index(w http.ResponseWriter, r *http.Request)  {
	fmt.Println("index page")
	fmt.Fprintf(w, "index page")
}

func product(w http.ResponseWriter, r *http.Request){
	fmt.Println("product page")
	fmt.Fprintf(w, "product page")
}