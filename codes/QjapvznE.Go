package main

import (
	"http"
	"io"
	"websocket"
	"fmt"
	"time"
)

///// Main /////
func main() {
    http.Handle("/", http.FileServer(http.Dir("/opt/chat/htdocs")))
	http.Handle("/ws", websocket.Handler(ws));
	err := http.ListenAndServe(":8080", nil);
	if err != nil {
		panic("ListenAndServe: " + err.String())
	}
}


func ws(ws *websocket.Conn) {
    fmt.Printf("New websocket connection\n")
	io.Copy(ws, ws);
    for {
        ws.Write([]byte("hello world"))
        time.Sleep(3*1e9)
    }
}