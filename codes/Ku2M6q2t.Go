func Exception(handler func()) (err os.Error) {
	defer func() {
		if r:= recover(); r != nil {
			err = os.NewError("something fucked up! :D")
		}
	}()
	handler()
	return
}