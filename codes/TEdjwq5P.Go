package main

import (
	"fmt"
	"log"
	"sync"
	"time"

	"github.com/nats-io/gnatsd/logger"
	"github.com/nats-io/gnatsd/server"
	"github.com/nats-io/go-nats"
)

var NatsURL string

func main() {

	gnatsd := server.New(&server.Options{Port: server.RANDOM_PORT})
	gnatsd.SetLogger(
		logger.NewStdLogger(false, false, false, false, false),
		false, false)
	go gnatsd.Start()
	defer gnatsd.Shutdown()

	if !gnatsd.ReadyForConnections(time.Second) {
		log.Fatal("Cannot start the gnatsd server")
	}
	NatsURL = "nats://" + gnatsd.Addr().String()

	nc, err := nats.Connect(NatsURL)
	if err != nil {
		panic(err)
	}

	ch := make(chan *nats.Msg)
	csub, err := nc.ChanSubscribe("foo", ch)
	if err != nil {
		panic(err)
	}

	ssub, err := nc.SubscribeSync("foo")
	if err != nil {
		panic(err)
	}

	var subMsgCount int
	sub, err := nc.Subscribe("foo", func(*nats.Msg) {
		subMsgCount++
	})
	defer sub.Unsubscribe()

	wg := sync.WaitGroup{}
	wg.Add(2)

	go func() {
		defer wg.Done()
		defer csub.Unsubscribe()
		var msgcount int
		for {
			select {
			case <-ch:
				msgcount++
			case <-time.After(time.Second):
				fmt.Printf("ChanSubscribe received %d messages\n", msgcount)
				return
			}
		}
	}()

	go func() {
		defer wg.Done()
		defer ssub.Unsubscribe()
		var msgcount int
		for {
			_, err := ssub.NextMsg(time.Second)
			if err == nats.ErrTimeout {
				fmt.Printf("SubscribeSync received %d messages\n", msgcount)
				return
			}
			if err != nil {
				panic(err)
			}
		}
	}()

	const msgcount = 20

	for i := 0; i != msgcount; i++ {
		if err := nc.Publish("foo", []byte("dummy")); err != nil {
			panic(err)
		}
	}
	fmt.Printf("Sent %d messages\n", msgcount)

	wg.Wait()
	fmt.Printf("Subscribe received %d messages\n", subMsgCount)
}