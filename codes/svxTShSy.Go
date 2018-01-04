package main

import (
	"fmt"
	"log"
	"os"
	"reflect"

	"github.com/BurntSushi/toml"
	"github.com/bwmarrin/discordgo"
)

func must(err error) {
	if err != nil {
		log.Println(err)
		panic(err)
	}
}

func printInterface(i interface{}) {
	fmt.Println("-------", reflect.TypeOf(i).Elem().Name(), "------------")
	toml.NewEncoder(os.Stdout).Encode(i)
	fmt.Println()
}

func main() {
	s, err := discordgo.New("Bot TOKEN")
	must(err)

	fmt.Println("attempting to connect to websocket...")
	must(s.Open())

	s.AddHandler(func(s *discordgo.Session, d interface{}) {
		switch d.(type) {
		// Cases in which the event will be printed
		case *discordgo.VoiceStateUpdate,
			*discordgo.Ready:
			printInterface(d)
		}

	})

	<-make(chan struct{})
}