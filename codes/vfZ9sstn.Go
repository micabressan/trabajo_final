package main

import (
    "big"
    "fmt"
    "crypto/rand"
    "os"
)

func main() {
    for i := 0; i < 4; i++ {
        if bigIndex, err := rand.Int(rand.Reader, big.                          NewInt(int64(len(wordlist)))); err != nil {
            fmt.Println(err)
            os.Exit(1)
        } else {
            fmt.Println(wordlist[int(bigIndex.Int64())])
        }   
    }   
}