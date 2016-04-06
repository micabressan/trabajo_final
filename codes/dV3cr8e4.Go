//cat so2tcp.go
package main

import (
	"net"
	"os"
)

func worker(socket net.Conn) {
	defer socket.Close()
	network, err := net.Dial("tcp", string(os.Args[2]))
	if err != nil {
		println("connect error:", err)
		return
	}
	defer network.Close()
	buf := make([]byte, 10240)
	for {
		nr, err := socket.Read(buf)
		if err != nil {
			println("error reading socket:", err)
			return
		}
		_, err = network.Write(buf[0:nr])
		if err != nil {
			println("error writing network:", err)
			return
		}

		nr2, err := network.Read(buf)
		if err != nil {
			println("error reading socket:", err)
			return
		}
		_, err = socket.Write(buf[0:nr2])
		if err != nil {
			println("error writing network:", err)
			return
		}
	}
	return
}

func main() {
	socket, err := net.Listen("unix", string(os.Args[1]))
	if err != nil {
		println("listen error:", err)
		os.Exit(254)
	}
	for {
		accepted, err := socket.Accept()
		if err != nil {
			println("accept error:", err)
			continue
		}
		go worker(accepted)
	}
}