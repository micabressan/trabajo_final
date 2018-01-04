package main

import (
	"http"
	"websocket"
	"fmt"
)

func main() {
	http.Handle("/ws", websocket.Handler(ws))
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic("ListenAndServe: " + err.String())
	}
}

func ws(ws *websocket.Conn) {
	defer func() {
		ws.Close()
	}()
	fmt.Printf("New websocket connection\n")

	var b []byte
	ws.SetReadTimeout(30 * 1e9)
	n, err := ws.Read(b)
	if err != nil {
		fmt.Printf("read error: %v\n", err)
	}
	fmt.Printf("rec(%d):%s\n", n, b)
}