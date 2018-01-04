package main

import (
	"encoding/json"
	"net"
	"net/http"
	"strings"
)

var rooms map[string][]*room

func main() {

	http.HandleFunc("/room/create", create)
	http.HandleFunc("/room/join", join)

	http.ListenAndServe(":8080", nil)
}

type roomCreation struct {
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

type room []member

func ErrorResp(w http.ResponseWriter, msg string) {
	type errorResp struct {
		Error string `json:"error"`
	}
	json.NewEncoder(w).Encode(errorResp{msg})
}

func create(w http.ResponseWriter, r *http.Request) {
	temp := roomCreation{}
	json.NewDecoder(r.Body).Decode(&temp)
	if len(rooms[temp.Name]) > 0 {
		ErrorResp(w, "Room exists, you may wanna join it or try another name")
		return
	}

	adress := r.RemoteAddr[:strings.Index(r.RemoteAddr, ":")]

	tempConn, err := net.Dial("tcp", adress)
	if err != nil {
		ErrorResp(w, err.Error())
		return
	}

	admin := member{
		Admin: true,
		Conn:  tempConn,
		ID:    temp.ID,
		Name:  temp.Name,
	}

	rooms[temp.Name] = append(rooms[temp.Name], &room{admin})

	json.NewEncoder(w).Encode(struct {
		Response string `json:"response"`
	}{"Room " + temp.Name + " created"})
}

func join(w http.ResponseWriter, r *http.Request) {

}