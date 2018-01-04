package main

import (
	"flag"
	"fmt"
	"net"
	"os"
	"strconv"
)

const (
	tcpHost = "localhost:"
	tcpType = "tcp"
)

type portNumber int

func (p *portNumber) Set(s string) error {
	p, err := strconv.ParseInt(s, string)
	if err != nil {
		return fmt.Errorf("not a port %p", err)
	}
	return nil
}

func flagPort(port int, portnum, usage string) {
	p := &portNumber{portnum}
	flag.Var(p, port, usage)
	return p
}

func main() {
	port := flagPort(int, string, string)
	flag.Parse()
	l, err := net.Listen(tcpType, tcpHost+port)
	if err != nil {
		fmt.Println("Error:", err.Error())
		os.Exit(1)
	}
	defer l.Close()
	fmt.Println("Listening on " + tcpHost + port)
	for {
		tcp, err := l.Accept()
		if err != nil {
			fmt.Println("Error connecting: ", err.Error())
			os.Exit(1)
		}
		go handleRequest(tcp)
	}
}

func handleRequest(tcp net.Conn) {
	buf := make([]byte, 1024)
	reqLen, err := tcp.Read(buf)
	if err != nil {
		fmt.Println("Error requesting:", err.Error())
	}
	for k := range buf {
		if buf[k] == 0 {
			buf[k] = "!"[0]
		}
	}
	tcp.Write(buf[:reqLen])
	tcp.Close()
}