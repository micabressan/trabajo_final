package main

import (
	"log"
	"net"
	"os"
	"io"
	"bytes"
	"encoding/binary"
	"fmt"
	"io/ioutil"
)

var sessionId uint16 = 1

func isErrorPresent(message string, err error) bool {
	if err != nil {
		log.Printf("[WARN] %s (%s)\n", message, err.Error())
		return true
	}
	return false
}

func main() {
	// Listen on TCP port 2000 on all interfaces.
	l, err := net.Listen("tcp", ":7862")
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("Server listening...")

	defer l.Close()
	for {
		// Wait for a connection.
		conn, err := l.Accept()
		if err != nil {
			log.Fatal(err)
		}
		// Handle the connection in a new goroutine.
		// The loop then returns to accepting, so that
		// multiple connections may be served concurrently.
		go func(c net.Conn) {
			// So this is new session

			// Create directory
			sessionDir := fmt.Sprintf("session_%d", sessionId)
			err := os.Mkdir(sessionDir, 0777)
			if isErrorPresent("Cannot create new directory", err) { return }

			// Create buffer and read all incoming data into it
			var buf bytes.Buffer
			readlen, err := io.Copy(&buf, c)
			if isErrorPresent("Cannot read incoming data", err) { return }

			// Check that this is valid packet (readlen % 30008 = 0)
			if readlen % 30008 != 0 {
				log.Printf("Data seems to be invalid package (length: %d)", readlen)
				return
			}

			// Iterate over all packages and save each into file
			var databuf []byte = make([]byte, 30008)
			for ;; {
				// Read buffer
				readln, err := buf.Read(databuf)
				if err == io.EOF || isErrorPresent("Cannot read chunk from packet", err) || readln != 30008 {
					break;
				}
				// Read position
				var x, y int32
				reader := bytes.NewReader(databuf)
				binary.Read(reader, binary.LittleEndian, &x)
				binary.Read(reader, binary.LittleEndian, &y)
				// Save to file
				ioutil.WriteFile(fmt.Sprintf("%s/%d_%d.mapdata", sessionDir, x, y), databuf, 0777)
			}
			c.Close()
		}(conn)
	}
}