package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"github.com/mgutz/logxi/v1"
	"github.com/skorobogatov/input"
	"net"
	"os"
	"strconv"
	"time"
)
import "proto"

var number = 0

func main() {
	var (
		serverAddrStr string
		n             int
		helpFlag      bool
	)
	flag.StringVar(&serverAddrStr, "server", "127.0.0.1:6000", "set server IP address and port")
	flag.IntVar(&n, "n", 10, "set the number of requests")
	flag.BoolVar(&helpFlag, "help", false, "print options list")
	if flag.Parse(); helpFlag {
		fmt.Fprint(os.Stderr, "client [options]\n\nAvailable options:\n")
		flag.PrintDefaults()
	} else if serverAddr, err := net.ResolveUDPAddr("udp", serverAddrStr); err != nil {
		log.Error("resolving server address", "error", err)
	} else if conn, err := net.DialUDP("udp", nil, serverAddr); err != nil {
		log.Error("creating connection to server", "error", err)
	} else {
		defer conn.Close()
		for i := 0; i < n; i++ {
			fmt.Printf("command = ")
			command := input.Gets()
			switch command {
			case "quit":
				send_request("quit", nil, conn)
				return
			case "vecs":
				var frac proto.VectorsDot
				fmt.Printf("size of vecs = ")
				var size int
				var val string
				fmt.Scan(&size)
				fmt.Printf("vector1 = ")
				val = input.Gets()
				//fmt.Print(val)
				var arr = strings.Split(val, " ")
				//fmt.Print(len(arr))
				v1 := make([]int, len(arr))
				for i := 0; i < size; i++ {
					for !isInt(arr[i]) {
						fmt.Print("\nIncorrect num, retry :")
						fmt.Scan(&arr[i])
					}
					v1[i], _ = strconv.Atoi(arr[i])
				}
				fmt.Printf("vector2 = ")
				val = input.Gets()
				arr = strings.Split(val, " ")
				v2 := make([]int, len(arr))
				for i := 0; i < size; i++ {
					for !isInt(arr[i]) {
						fmt.Print("\nIncorrect num, retry :")
						fmt.Scan(arr[i])
					}
					v2[i], _ = strconv.Atoi(arr[i])
				}
				frac.VectorF = v1
				frac.VectorS = v2
				resp = send_request("vecs", &frac, conn)
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
						var frac string
						if err := json.Unmarshal(*resp.Data, &frac); err != nil {
							fmt.Printf("error: malformed data field in response\n")
						} else {
							fmt.Printf("result: %s\n", frac)
						}
					}
				default:
					fmt.Printf("error: server reports unknown status %q\n", resp.Status)
				}
			case "dotV":
				resp = send_request("dotV", &frac, conn)
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
						var frac string
						if err := json.Unmarshal(*resp.Data, &frac); err != nil {
							fmt.Printf("error: malformed data field in response\n")
						} else {
							//...
							fmt.Printf("result: %s\n", frac)
						}
					}
				default:
					fmt.Printf("error: server reports unknown status %q\n", resp.Status)
				}
			default:
				fmt.Printf("error : unknown command\n")
				continue
			}
		}
	}
}

func send_request(command string, data interface{}, conn *net.UDPConn) proto.Response {
	for {
		var raw json.RawMessage
		var send_m json.RawMessage
		raw, _ = json.Marshal(data)
		x := strconv.Itoa(number)
		send_m, _ = json.Marshal(proto.Request{command, &raw, x})
		buf := make([]byte, 10000)
		number++
		conn.SetWriteDeadline(time.Now().Add(time.Second))
		if _, err := conn.Write(send_m); err != nil {
			log.Error("sending request to server", "error")
		}
		var res proto.Response
		conn.SetReadDeadline(time.Now().Add(time.Second))
		if bytesRead, err := conn.Read(buf); err != nil {
			log.Error("reading response from server timeout", "error")
		} else {
			if err := json.Unmarshal(buf[:bytesRead], &res); err != nil {
				log.Error("cannot parse response massage")
			}
			return res
		}
	}
}