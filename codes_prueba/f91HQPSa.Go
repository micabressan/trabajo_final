package main

import (
	"net"
	"fmt"
	"encoding/json"
	"sync"
)

// removing some boilerplate
func logErr(err error) {
	if err != nil {
		fmt.Println(err)
	}
}


// This structure is pretty much the only thing we comunicate through the tcp socket.
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

// preparing the signaler
var newRoom chan *Room

func main() {
	rooms := &Rooms{}
	newRoom = make(chan *Room, 1)

	// we open a tcp port in order for everyone to be able to connect to us and
	// perhaps have a chit chat
	listener, err := net.Listen("tcp", ":9000")
	logErr(err)

	// we decide what to do with ppl who wanna join us
	go manageNewcomers(listener, rooms)

	go manageNewRooms()

}

func manageNewcomers(listener net.Listener, rooms *Rooms) {
	// Every time we get a connection
	conn, err := listener.Accept()
	logErr(err)

	// we prepare something to translate in in
	message := Message{}

	// we then make it an "object" for out code to be able to use it
	json.NewDecoder(conn).Decode(&message)

	// we keep in mind who sent us the request
	thisGuy := &Member{
		ID:   message.IdGuy,
		Name: message.NameGuy,
		Conn: conn,
	}

	// and we try to figgure out what he wanted to tell us
	switch message.Action {
	// if he wanted to create a new room
	case "create":
		// we verify if the name is taken already
		// https://goo.gl/9m39Li
		doesExist, _ := rooms.Exists(message.RoomName)
		if !doesExist {
			// we make the lucky guy
			newRoom := &Room{
				Name:    message.RoomName,
				// the administrator of his own room
				Admin:   thisGuy,
				Members: []*Member{},
			}

			// and we put it there with the other rooms
			rooms.Add(newRoom)
		}
		break

	case "join":
		// however if he wants to join
		doesExist, where := rooms.Exists(message.RoomName)

		// we do the same thing of course
		if doesExist {
			// and we lead this nice gentleman to the room he wants to be in
			where.Add(thisGuy)
		}
		break
	}
}

func manageNewRooms() {
	// an infinite loop that is pretty much doing nothing until it gets the signal
	for {
		// this is the signal we get that a new room is created
		// in which we get a room -- haha
		room := <-newRoom

		// we then start a goroutine for that room in order to handle itself
		go func(room *Room) {
			for {

				// guess what. Preparing our recipent again
				message := Message{}

				// for every member and admin --- uuuuuugh, this could've been handled in a nicer way
				for _, member := range append(room.Members, room.Admin) { // a bit hacky but meh
					go func() {
						// you get the message again and translate it
						json.NewDecoder(member.Conn).Decode(&message)

						// you form a song
						newSong := Song{
							Name: message.SongName,
							Hash: message.HashSong,
						}

						// and you decide what these guys are trying to do to the perfect
						// empty room that was once in peace
						switch message.Action {
						// if they want to add a song
						case "add song":

							// and they are the administrators of the room
							// well then they can do anything
							if message.IdGuy == room.Admin.ID {
								// and they chose to do this
								room.AddSong(newSong)
							} else {
								// however if they are just some random guy who wants their favorite song
								// to be in their favorite playlist they just send a request formed
								// by the name of the song and it's hash
								message := Message{
									Action:   "ask for song",
									HashSong: message.SongName,
									SongName: message.HashSong,
								}

								// and they send it straight to the administrator. He'll know what to do
								json.NewEncoder(room.Admin.Conn).Encode(message)
							}
							break

						// if they want to remove a song
						case "remove song":
							// they must be the admin
							// we wouldn't want someone else to mess it up
							// right?
							if message.IdGuy == room.Admin.ID {
								room.RemoveSong(newSong)
							}
							break

						// if they wanna pause the song that is currently playing
						case "pause":
							// again they must be the admin
							if message.IdGuy == room.Admin.ID {
								// you wanna be a nice admin
								// and tell everyone that you decided to pause the song
								// so you go through everyone in your room
								for _, member := range room.Members {
									// you prepare what you want to say
									messageForEveryone := Message{
										Action:   "pause",
										HashSong: message.HashSong,
										Time:     message.Time,
									}

									// and send a message to everyone telling them what you did
									go json.NewEncoder(member.Conn).Encode(messageForEveryone)
								}
							}
						}

					}()
				}

			}
		}(room)
	}
}