package main
 
import (
    "bufio"
    "flag"
    "fmt"
    "log"
    "os"
)
 
func main() {
 
    flag.Parse()
    flags := flag.Args()
 
    var text string
    var scanner *bufio.Scanner
    var err error
 
    if len(flags) > 0 {
 
        file, err := os.Open(flags[0])
 
        if err != nil {
            log.Fatal(err)
        }
 
        scanner = bufio.NewScanner(file)
 
    } else {
        scanner = bufio.NewScanner(os.Stdin)
    }
 
    for scanner.Scan() {
        text += scanner.Text()
    }
 
    err = scanner.Err()
    if err != nil {
        log.Fatal(err)
    }
 
    fmt.Println(text)
}