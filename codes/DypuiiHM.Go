package main

import (
	"log"
	"regexp"

	"github.com/Syfaro/telegram-bot-api"
)

const group_id int64 = -1001342203264

func main() {

	bot, err := tgbotapi.NewBotAPI("544857738:AAEI0ItlxtteT8dQg3y9WpJcwcZW40iWoNw")
	if err != nil {
		log.Panic(err)
	}

	bot.Debug = false
	log.Printf("Authorized on account %s", bot.Self.UserName)

	var ucfg tgbotapi.UpdateConfig = tgbotapi.NewUpdate(0)
	var delme tgbotapi.DeleteMessageConfig
	ucfg.Timeout = 60

	upd, _ := bot.GetUpdatesChan(ucfg)

	zhel, _ := regexp.Compile("([Жж]|[Jj]|[Zz][Hh])([Ee]|[Ее])|([Лл]|[Ll])")
	loh, _ := regexp.Compile("([Ll]|[Лл])([Оо]|[Oo])|([Hh]|[Хх]|[Xx])")
	opros, _ := regexp.Compile("[Оо][Пп][Рр][Оо][Сс]|[Гг][Оо][Лл][Оо][Сс][Оо][Вв]*")

	//var insurvey = false

	for update := range upd {
		if update.Message == nil {
			continue
		}
		//update := <-upd:
		UserName := update.Message.From.UserName
		FirstName := update.Message.From.FirstName
		LastName := update.Message.From.LastName
		ChatID := update.Message.Chat.ID
		MessageID := update.Message.MessageID
		Text := update.Message.Text

		log.Printf("[%s] %d %d %s", UserName, ChatID, MessageID, Text)

		if Text == "" {
			reply := "xaxa смешно даун"
			msg := tgbotapi.NewMessage(ChatID, reply)
			log.Printf("%d | %d | %s | %s", MessageID, ChatID, Text, err)
			bot.Send(msg)
			continue
		} else if Text[0] == '/' {

			if Text == "/greetme"+"@"+bot.Self.UserName {
				reply := " что это за милаша " + FirstName + " " + LastName + " сюда зашла ? ? ? "
				msg := tgbotapi.NewMessage(ChatID, reply)
				bot.Send(msg)
			}

		} else if zhel.MatchString(Text) && loh.MatchString(Text) {
			reply := " ругаться " + FirstName + " " + LastName + ", нехорошо ? ? ? "
			delme.ChatID = ChatID
			delme.MessageID = MessageID
			_, err := bot.DeleteMessage(delme)
			log.Printf("%d | %d | %s | %s", MessageID, ChatID, Text, err)
			msg := tgbotapi.NewMessage(ChatID, reply)
			bot.Send(msg)
		} else if opros.MatchString(Text) {

			reply := " выберите тему для голосования "
			msg := tgbotapi.NewMessage(ChatID, reply)
			bot.Send(msg)

			log.Printf("%d | %d | %s | %s", MessageID, ChatID, Text, err)

		} else {
			log.Printf("no reaction at all, latest msg is %s , err is %s", Text, err)
		}

	}

}