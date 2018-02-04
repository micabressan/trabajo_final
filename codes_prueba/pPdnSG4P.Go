package main

import (
	"net"
	"fmt"
	"encoding/json"
	"sync"
)

func logErr(err error) {
	if err != nil {
		fmt.Println(err)
	}
}

type Message struct {
	Action   string `json:"Action"`
	IdGuy    string `json:"IdGuy"`
	RoomName string `json:"RoomName"`
	NameGuy  string `json:"NameGuy"`
	SongName string `json:"SongName"`
	HashSong string `json:"HashSong"`
	Time     int    `json:"Time"`
}

type Member struct {
	ID   string
	Name string
	Conn net.Conn
}

type Room struct {
	*sync.Mutex
	Name    string
	Admin   *Member
	Members []*Member
	Songs   []Song
}

type Rooms struct {
	*sync.Mutex
	list []*Room
}

type Song struct {
	Name string
	Hash string
}

func (rooms *Rooms) Exists(roomName string) (bool, *Room) {
	rooms.Lock()
	defer rooms.Unlock()

	for _, room := range rooms.list {
		if room.Name == roomName {
			return true, room
		}
	}
	return false, nil
}

func (rooms *Rooms) Add(room *Room) {
	rooms.Lock()
	rooms.list = append(rooms.list, room)
	rooms.Unlock()
}

func (room *Room) Add(member *Member) {
	room.Lock()
	room.Members = append(room.Members, member)
	room.Unlock()
}

func (room *Room) AddSong(song Song) {
	room.Lock()
	room.Songs = append(room.Songs, song)
	room.Unlock()
}
func (room *Room) RemoveSong(song Song) {
	room.Lock()
	defer room.Unlock()
	for i, songCurr := range room.Songs {
		if songCurr == song {
			room.Songs = append(room.Songs[:i], room.Songs[i+1:]...)
			return
		}
	}
}

var newRoom chan *Room

func main() {
	rooms := &Rooms{}
	newRoom = make(chan *Room, 1)

	listener, err := net.Listen("tcp", ":9000")
	logErr(err)

	go manageNewcomers(listener, rooms)

	go func() {
		for {
			room := <-newRoom

			go func(room *Room) {
				for {

					message := Message{}

					for _, member := range append(room.Members, room.Admin) { // a bit hacky but meh
						go func() {
							json.NewDecoder(member.Conn).Decode(&message)

							newSong := Song{
								Name: message.SongName,
								Hash: message.HashSong,
							}

							switch message.Action {
							case "add song":

								if message.IdGuy == room.Admin.ID {
									room.AddSong(newSong)
								} else {
									message := Message{
										Action:   "ask for song",
										HashSong: "", //TODO to be added
										SongName: "", //TODO same here
									}

									json.NewEncoder(room.Admin.Conn).Encode(message)
								}
								break

							case "remove song":
								if message.IdGuy == room.Admin.ID {
									room.RemoveSong(newSong)
								}
								break

							case "pause":
								if message.IdGuy == room.Admin.ID {
									for _, member := range room.Members {
										messageForEveryone := Message{
											Action:   "pause",
											HashSong: message.HashSong,
											Time:     message.Time,
										}

										go json.NewEncoder(member.Conn).Encode(messageForEveryone)
									}
								}
							}

						}()
					}

				}
			}(room)
		}
	}()

}

func manageNewcomers(listener net.Listener, rooms *Rooms) {
	conn, err := listener.Accept()
	logErr(err)

	message := Message{}

	json.NewDecoder(conn).Decode(&message)

	thisGuy := &Member{
		ID:   message.IdGuy,
		Name: message.NameGuy,
		Conn: conn,
	}

	switch message.Action {
	case "create":
		doesExist, _ := rooms.Exists(message.RoomName)
		if doesExist {
			newRoom := &Room{
				Name:    message.RoomName,
				Admin:   thisGuy,
				Members: []*Member{},
			}

			rooms.Add(newRoom)
		}
		break

	case "join":
		doesExist, where := rooms.Exists(message.RoomName)

		if doesExist {
			where.Add(thisGuy)
		}
		break
	}
}