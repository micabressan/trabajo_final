
package main

import (
    "fmt"
    "json"
)

type message struct {
    id string
    msg string
}

func main() {
    m := message{"123","test message"}
    fmt.Printf("%s\n",m.id)
    fmt.Printf("%s\n",m.msg)
    j,err := json.Marshal(m)
    if err != nil {
        fmt.Printf("\nError: %v\n", err)
    }
    fmt.Printf("%s\n",j)
}