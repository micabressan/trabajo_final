package Msg
import "encoding/json"
import "fmt"
import "os"

func checkError(err error) {
    if err  != nil {
        fmt.Println("Error: " , err)
        os.Exit(0)
    }
}

type Msg struct {
    Type string `json:"type"`
	Dst  int    `json:"dst"`
	Data string `json:"data"`
}

func (msg Msg) ToJson() string {
	buf, err := json.Marshal(msg)
    checkError(err)
	return string(buf)
}

func (msg Msg) Empty() bool {
	return msg.Data == ""
}

func New(buf []byte) Msg {
	msg := &Msg{}
	err := json.Unmarshal(buf, msg)
	checkError(err)
	return *msg
}