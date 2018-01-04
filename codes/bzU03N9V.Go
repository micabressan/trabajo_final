import (
	"http"
	"io"
	"fmt"
)

type state struct {
	somedata int
}

func main() {
	hello := state{somedata: 41}
	http.HandleFunc("/hello", hello.Server)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic("ListenAndServe: " + err.String())
	}
}

func (self *state) Server(w http.ResponseWriter, req *http.Request) {
	// I want to use somedata here...
	io.WriteString(w, fmt.Sprintf("hello, world! %d\n", self.somedata))
}

/*
	When I compile this I get the following error

	"method hello.(*state).Server is not an expression, must be called"

	I take it that's not an appropriate way to pass state?

	Is a closure the only way?
*/