var Mux sync.Mutex

func foo() {
	Mux.Lock()
	// some code
	Mux.Unlock()
}