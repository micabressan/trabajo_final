package main

import (
    "net/http"
    "time"
    "fmt"
    "os"
)


func main() {
    go killAfter(12)

    http.Handle("/hello", hello())
    portString := fmt.Sprintf(":%d", 7777)
    http.ListenAndServe(portString, nil)
}


func hello() http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request){
        w.Write([]byte("Hello!"))
    })
}


func killAfter(timeout int) {
    var startTime = time.Now()

    for {
        if time.Since(startTime) > time.Duration(timeout) * time.Second {
            os.Exit(0)
        }
    }
}