package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"github.com/skorobogatov/input"
	"github.com/mgutz/logxi/v1"
	"net"
	"time"
	"proto"
)

var n int
var c *net.UDPConn


// interact - функция, содержащая цикл взаимодействия с сервером.
func interact(conn *net.UDPConn) {
	defer conn.Close()
	_ = send_request("start", nil)
	for {
		var resp proto.Response

		// Чтение команды из стандартного потока ввода
		fmt.Printf("command = ")
		command := input.Gets()

		// Отправка запроса.
		switch command {
		case "quit":
			resp = send_request("quit", nil)
			return
		case "add":
			var vect proto.Vector
			fmt.Printf("Vector 1 Coordinate X1 = ")
			vect.CoordX1 = input.Gets()
			fmt.Printf("Vector 1 Coordinate Y1 = ")
			vect.CoordY1 = input.Gets()
			fmt.Printf("Vector 1 Coordinate X2 = ")
			vect.CoordX2 = input.Gets()
			fmt.Printf("Vector 1 Coordinate Y2 = ")
			vect.CoordY2 = input.Gets()
			fmt.Printf("Vector 2 Coordinate X1 = ")
			vect.CoordX3 = input.Gets()
			fmt.Printf("Vector 2 Coordinate Y1 = ")
			vect.CoordY3 = input.Gets()
			fmt.Printf("Vector 2 Coordinate X2 = ")
			vect.CoordX4 = input.Gets()
			fmt.Printf("Vector 2 Coordinate Y2 = ")
			vect.CoordY4 = input.Gets()
			resp = send_request("add", &vect)
		case "intersect":
			fmt.Printf("Finding a point of intersection\n")
			resp = send_request("intersect", nil)
		default:
			fmt.Printf("error: bad command\n")
			continue
		}

		if resp.Status == "" {
			break
		}

		// Вывод ответа в стандартный поток вывода.
		switch resp.Status {
		case "ok":
			fmt.Printf("ok\n")
		case "failed":
			if resp.Data == nil {
				fmt.Printf("error: data field is absent in response\n")
			} else {
				var errorMsg string
				if err := json.Unmarshal(*resp.Data, &errorMsg); err != nil {
					fmt.Printf("error: malformed data field in response\n")
				} else {
					fmt.Printf("failed: %s\n", errorMsg)
				}
			}
		case "result":
			if resp.Data == nil {
				fmt.Printf("error: data field is absent in response\n")
			} else {
				var s float64
				if err := json.Unmarshal(*resp.Data, &s); err != nil {
					fmt.Printf("error: malformed data field in response\n")
				} else {
					fmt.Printf("result: %f\n", s)
				}
			}
		default:
			fmt.Printf("error: server reports unknown status %q\n", resp.Status)
		}
	}
}

// send_request - вспомогательная функция для передачи запроса с указанной командой
// и данными. Данные могут быть пустыми (data == nil).
func send_request(command string, data interface{}) proto.Response {
	n++
	var raw json.RawMessage
	buf := make([]byte, 256)
	raw, _ = json.Marshal(data)
	for {
		var resp proto.Response
		resp.CommandNum = -1
		c.SetDeadline(time.Now().Add(time.Second))
		if bytes, err1 := json.Marshal(proto.Request{n, command, &raw}); err1 == nil {
			if _, err := c.Write(bytes); err != nil {
				log.Error("sending request to server", "error", err)
			}
		} else {
			log.Error("sending request to server", "error", err1)
		}
		c.SetDeadline(time.Now().Add(time.Second))
		if bytesRead, err := c.Read(buf); err != nil {
			log.Info("no")
		} else if err1 := json.Unmarshal(buf[:bytesRead], &resp); err1 != nil {
			fmt.Println(bytesRead)
			fmt.Printf("error: %v\n", err1)
			resp.Status = ""
			return resp
		}
		if resp.CommandNum == n {
			return resp
		}
	}
}

func main() {
	n = -1

	// Работа с командной строкой, в которой может указываться необязательный ключ -addr.
	var addrStr string
	flag.StringVar(&addrStr, "server", "127.0.0.1:6000", "set server IP address and port")
	flag.Parse()

	// Разбор адреса, установка соединения с сервером и
	// запуск цикла взаимодействия с сервером.
	if addr, err := net.ResolveUDPAddr("udp", addrStr); err != nil {
		fmt.Printf("error: %v\n", err)
	} else if con, err := net.DialUDP("udp", nil, addr); err != nil {
		fmt.Printf("error: %v\n", err)
	} else {
		log.Info("Dial connection")
		c = con
		interact(con)
	}
}