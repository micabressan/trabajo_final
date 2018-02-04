package main

import (
	"encoding/json"
	"fmt"
	"net"
	"net/http"
	"strings"
)

var rooms map[string][]*member

func main() {

	rooms = make(map[string][]*member)

	http.HandleFunc("/room/create", create)
	http.HandleFunc("/room/join", join)

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println(err)
		return
	}
}

type roomReq struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	RoomName string `json:"room name"`
}

type member struct {
	ID    string
	Name  string
	Admin bool
	Conn  net.Conn
}

func ErrorResp(w http.ResponseWriter, msg string) {
	type errorResp struct {
		Error string `json:"error"`
	}
	json.NewEncoder(w).Encode(errorResp{msg})
}

func Resp(w http.ResponseWriter, msg string) {
	json.NewEncoder(w).Encode(struct {
		Response string `json:"response"`
	}{msg})
}

func create(w http.ResponseWriter, r *http.Request) {
	temp := roomReq{}
	json.NewDecoder(r.Body).Decode(&temp)
	if len(rooms[temp.Name]) > 0 {
		ErrorResp(w, "Room exists, you may wanna join it or try another name")
		fmt.Println(len(rooms[temp.Name]))
		return
	}

	fmt.Println(r.RemoteAddr)

	adress := r.RemoteAddr[:strings.Index(r.RemoteAddr, ":")]

	//debuggining
	if adress == "[" {
		adress = "localhost"
	}
	//debuggining
	fmt.Println(adress)

	tempConn, err := net.Dial("tcp", adress+":8090")
	if err != nil {
		ErrorResp(w, err.Error())
		return
	}
	fmt.Println("connected", adress)

	admin := &member{
		Admin: true,
		Conn:  tempConn,
		ID:    temp.ID,
		Name:  temp.Name,
	}

	rooms[temp.Name] = append(rooms[temp.Name], admin)

	Resp(w, "Room "+temp.Name+" created")
}

func join(w http.ResponseWriter, r *http.Request) {
	temp := roomReq{}

	json.NewDecoder(r.Body).Decode(&temp)
	defer r.Body.Close()

	if len(rooms[temp.Name]) == 0 {
		ErrorResp(w, "There's no such room")
		fmt.Println(len(rooms[temp.Name]))
		return
	}

	adress := r.RemoteAddr[:strings.Index(r.RemoteAddr, ":")]

	//debuggining
	if adress == "[" {
		adress = "localhost"
	}
	//debuggining

	tempConn, err := net.Dial("tcp", adress+":8090")
	if err != nil {
		ErrorResp(w, err.Error())
		return
	}

	currMember := &member{
		ID:    temp.ID,
		Name:  temp.Name,
		Admin: false,
		Conn:  tempConn,
	}

	rooms[temp.Name] = append(rooms[temp.Name], currMember)

	Resp(w, "Enterd room")
}