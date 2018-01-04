for {
	select {
	case websocket.JSON.Receive(ws, &input): // here lies the problem...
		blah()
	case <-cancelchan:
		return
	}
}