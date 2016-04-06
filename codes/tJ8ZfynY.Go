import (
    "bufio"
    "os"
    "sync"
)

type LogFile struct {
     sync.Mutex
     Log *bufio.Writer
 }

func (l LogFile) Init(logFilePath string) {
     temp, _ := os.OpenFile(".test", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
     l.Log = bufio.NewWriter(temp)
}
 
func main() {
    log := new(LogFile)
    log.Init("logFileTesterererer")
    log.Log.WriteString("Hello world")
    log.Lock()
    log.Log.Flush()
    log.Unlock()
}