package remote

import (
	"log"
	"net/http"

	"github.com/chrj/schrute/bot"
)

type sayHandler struct {
	b *bot.Bot
}

func (h *sayHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {

	if req.Method != "POST" {
		http.Error(w, "Use POST", http.StatusMethodNotAllowed)
		return
	}

	err := req.ParseForm()
	if err != nil {
		log.Printf("error parsing form: %v", err)
		http.Error(w, "Oops", http.StatusInternalServerError)
		return
	}

	channel := req.PostForm.Get("channel")
	msg := req.PostForm.Get("msg")
	
	if channel == "" || msg == "" {
		http.Error(w, "Missing params", http.StatusBadRequest)
		return
	}

	h.b.Say(channel, msg)

}

func Register(b *bot.Bot) {

	bind := ":4280"

	m := http.NewServeMux()
	m.Handle("/say", &sayHandler{b})

	go func() {
		log.Printf("Listening for remote messages on: %s", bind)
		log.Fatal(http.ListenAndServe(bind, m))
	}()

}