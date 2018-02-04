package main

import "net/http"
import "fmt"
import "io/ioutil"

func main() {
    http.HandleFunc("/", handle)
    http.ListenAndServe(":80", nil)
}

func handle(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, read(r.URL.Path))
}

func read(file string) string {
    html, err := ioutil.ReadFile(findFile(file))
    if err == nil {
        return string(html)
    } else {
        return "404 page not found"
    }
}

func findFile(name string) string {
    var file string

    if name == "/" {
        file = "home"
    } else {
        file = name
    }

    return file+".html"
}