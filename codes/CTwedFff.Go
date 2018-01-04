package main
 
import (
    "fmt"
    "encoding/json"
    json2 "github.com/CrazyAuthor/another/json"
    _ "net"
)
 
var answer = 42
 
const (
    statusOk = iota
    statusWarn = iota
    statusError = iota
)
 
func init() {
    fmt.Println( "hi there!" )
}
 
func logMsg( level string, msg ...string ) {
    fmt.Printf( "[%v] [%s] %s\n", time.Now(), level, strings.Join( msg, " " ) )
}
 
func do_something() {
    ch_n := make( chan int, 3 )
    defer close( ch_n )
     
    for i := 0; i < 5; i++ {
        var ii = i
        go func() {
            var sum int = 0
            for {
                select {
                    case n, ok := <-ch_n:
                        if ok {
                            sum += n
                        } else {
                            fmt.Printf( "[%d] sum is %d\n", ii, sum )
                            return
                        }
                }
            }
        }()
    }
     
    arr := make( []int, 0, 5 )
    for k := 0; k < 20; k++ {
        arr = append( arr, k )
    }
     
    for _, x := range arr {
        ch_n <- x
    }
}
 
func main() {
    do_something()
}