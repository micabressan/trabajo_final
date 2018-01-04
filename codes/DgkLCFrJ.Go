type S struct {
	Mux sync.Mutex
}

func Foo(s S){
	s.Mux.lock()
	// some code
	s.Mux.Unlock()
}