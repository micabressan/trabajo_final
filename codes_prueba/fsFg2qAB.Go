package main

import (
        "sync"

        "github.com/bwmarrin/discordgo"
)

type Game struct {
        PlayerMap map[string]PlayerAtt
}

type PlayerAtt struct {
        Role int
}

var Games = make(map[string]*Game)
var mutex = &sync.Mutex{}

func StartGame(s *discordgo.Session, m *discordgo.MessageCreate) {
        mutex.Lock()
        defer mutex.Unlock()

        if m.Author.ID == s.State.User.ID {
                return
        }

        if m.Content == "!start" {
                if Games[m.ChannelID] != nil {
                        s.ChannelMessageSend(m.ChannelID, "A game has already been started in this channel...")
                } else {
                        Games[m.ChannelID] = &Game{}
                        Games.PlayerMap = make(map[string]PlayerAtt)
                        s.ChannelMessageSend(m.ChannelID, ":wolf: A new game of Werewolf is starting! For a tutorial, type !help.\r\n\r\n")
                }
        }
}