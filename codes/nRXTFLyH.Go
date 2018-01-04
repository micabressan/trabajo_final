package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net"
	"strconv"
	"github.com/mgutz/logxi/v1"
	"proto"
)

type Status struct {
	ua     int
	ub     int
	X1     int
	Y1     int
	X2     int
	Y2     int
	flag   bool
	number int
	resp   []byte
}

// Client - состояние клиента.
type Client struct {
	logger log.Logger   // Объект для печати логов
	conn   *net.UDPConn // Объект UDP-соединения
	dict   map[int]Status
	ua     int
	ub     int
	X1     int
	Y1     int
	X2     int
	Y2     int
	flag   bool // Заданы ли прямые пересечения
	number int
	resp   []byte
	addr   *net.UDPAddr
}

// NewClient - конструктор клиента, принимает в качестве параметра
// объект TCP-соединения.
func NewClient(conn *net.UDPConn) *Client {
	return &Client{
		logger: log.New(fmt.Sprintf("client %s", /*conn.RemoteAddr().String()*/ "ss")),
		conn:   conn,
		dict:   make(map[int]Status),
		ua:     0,
		ub:     0,
		X1:     0,
		X2:     0,
		Y1:     0,
		Y2:     0,
		flag:   false,
		number: 0,
		resp:   nil,
		addr:   nil,
	}
}

// serve - метод, в котором реализован цикл взаимодействия с клиентом.
// Подразумевается, что метод serve будет вызаваться в отдельной go-программе.
func (client *Client) serve() {
	defer client.conn.Close()
	for {
		var req proto.Request
		buf := make([]byte, 256)
		var status Status
		if bytesnumb, addr, err := client.conn.ReadFromUDP(buf); err == nil {
			if _, ok := client.dict[addr.Port]; !ok {
				client.dict[addr.Port] = Status{0, 0, 0, 0, 0, 0, false, 0, nil}
			}
			status, _ = client.dict[addr.Port]
			client.addr = addr
			client.number = status.number
			if err1 := json.Unmarshal(buf[:bytesnumb], &req); err1 == nil {
				client.logger.Info("received command", "command", req.Command)
				if req.Command == "quit" {
					client.number++
					client.respond("ok", nil)
					delete(client.dict, addr.Port)
					continue
				}
				if req.CommandNum == 0 {
					client.dict[addr.Port] = Status{0, 0, 0, 0, 0, 0, false, 0, nil}
					client.respond("start", nil)
				}
				status, _ = client.dict[addr.Port]
				client.ua = status.ua
				client.ub = status.ub
				client.X1 = status.X1
				client.Y1 = status.Y1
				client.X2 = status.X2
				client.Y2 = status.Y2
				client.flag = status.flag
				client.resp = status.resp
				client.number = status.number

				client.handleRequest(&req)
				client.dict[addr.Port] = Status{client.ua, client.ub, client.X1, client.Y1, client.X2,
					client.Y2, client.flag, client.number, client.resp}
				//client.logger.Info("shutting down connection")
			} else {
				println(err1, "err1")
			}
		}
	}
}

// handleRequest - метод обработки запроса от клиента. Он возвращает true,
// если клиент передал команду "quit" и хочет завершить общение.
func (client *Client) handleRequest(req *proto.Request) bool {
	if client.number == req.CommandNum {
		if _, err := client.conn.WriteToUDP([]byte(client.resp), client.addr); err != nil {
			log.Error("sending request to server", "error", err)
		} else {
			return false
		}
	}
	if client.number+1 != req.CommandNum {
		return false
	}
	client.number++
	switch req.Command {
	case "add":
		errorMsg := ""
		if req.Data == nil {
			errorMsg = "data field is absent"
		} else {
			var vect proto.Vector
			var x4x3, y1y3, y4y3, x1x3, x2x1, y2y1 int
			if err := json.Unmarshal(*req.Data, &vect); err != nil {
				errorMsg = "malformed data field"
			} else {
				if x1, ok := strconv.Atoi(vect.CoordX1); ok!=nil {
					errorMsg = "malformed data field"
				} else {
					client.logger.Info("performing addition", "value", strconv.Itoa(x1))
					if x2, ok := strconv.Atoi(vect.CoordX2); ok!=nil {
						errorMsg = "malformed data field"
					} else {
						client.logger.Info("performing addition", "value", strconv.Itoa(x2))
						if x3, ok := strconv.Atoi(vect.CoordX3); ok != nil {
							errorMsg = "malformed data field"
						} else {
							client.logger.Info("performing addition", "value", strconv.Itoa(x3))
							if x4, ok := strconv.Atoi(vect.CoordX4); ok != nil {
								errorMsg = "malformed data field"
							} else {
								client.logger.Info("performing addition", "value", strconv.Itoa(x4))
								if y1, ok := strconv.Atoi(vect.CoordY1); ok != nil {
									errorMsg = "malformed data field"
								} else {
									client.logger.Info("performing addition", "value", strconv.Itoa(y1))
									if y2, ok := strconv.Atoi(vect.CoordY2); ok != nil {
										errorMsg = "malformed data field"
									} else {
										client.logger.Info("performing addition", "value", strconv.Itoa(y2))
										if y3, ok := strconv.Atoi(vect.CoordY3); ok != nil {
											errorMsg = "malformed data field"
										} else {
											client.logger.Info("performing addition", "value", strconv.Itoa(y3))
											if y4, ok := strconv.Atoi(vect.CoordY4); ok != nil {
												errorMsg = "malformed data field"
											} else {
												client.logger.Info("performing addition", "value", strconv.Itoa(y4))
												x4x3 = x4 - x3
												y1y3 = y1 - y3
												y4y3 = y4 - y3
												x1x3 = x1 - x3
												x2x1 = x2 - x1
												y2y1 = y2 - y1
												if y4y3*x2x1-x4x3*y2y1 == 0 || (y4y3*x2x1-x4x3*y2y1 == 0 && y4y3*x2x1-x4x3*y2y1 == 0) {
													client.ub = -100
													client.ua = -100
												} else {
													client.ua = (x4x3*y1y3 - y4y3*x1x3) / (y4y3*x2x1 - x4x3*y2y1)
													client.ub = (x2x1*y1y3 - y2y1*x1x3) / (y4y3*x2x1 - x4x3*y2y1)
													client.X1 = x1
													client.Y1 = y1
													client.X2 = x2
													client.Y2 = y2
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if errorMsg == "" {
			client.respond("ok", nil)
		} else {
			client.logger.Error("addition failed", "reason", errorMsg)
			client.respond("failed", errorMsg)
		}
	case "intersect":
		if (client.ua < 0 || client.ua > 1) || (client.ub < 0 || client.ub > 1) {
			client.logger.Error("calculation failed", "reason", "no intersection point in a segment")
			client.respond("failed", "no intersection point in a segment")
		} else {
			var X, Y int
			X = client.X1 + client.ua*(client.X2-client.X1)
			Y = client.Y1 + client.ub*(client.Y2-client.Y1)
			client.respond("result", "("+strconv.Itoa(X)+", "+strconv.Itoa(Y)+")")
		}
	default:
		client.logger.Error("unknown command")
		client.respond("failed", "unknown command")
	}

	return false
}

// respond - вспомогательный метод для передачи ответа с указанным статусом
// и данными. Данные могут быть пустыми (data == nil).
func (client *Client) respond(status string, data interface{}) {
	var raw json.RawMessage
	raw, _ = json.Marshal(data)
	if d, err1 := json.Marshal(proto.Response{client.number, status, &raw}); err1 == nil {
		client.resp, _ = json.Marshal(proto.Response{client.number, status, &raw})
		if _, err := client.conn.WriteToUDP(d, client.addr); err != nil {
			log.Error("sending request to server", "error", err)
		}
		log.Info("sending mes")
	} else {
		log.Error("sending request to server1", "error", err1)
	}
}

func main() {
	// Работа с командной строкой, в которой может указываться необязательный ключ -addr.
	var addrStr string
	flag.StringVar(&addrStr, "addr", "127.0.0.1:6000", "specify ip address and port")
	flag.Parse()

	// Разбор адреса, строковое представление которого находится в переменной addrStr.
	if addr, err := net.ResolveUDPAddr("udp", addrStr); err != nil {
		log.Error("address resolution failed", "address", addrStr)
	} else {
		log.Info("resolved UDP address", "address", addr.String())

		// Инициация слушания сети на заданном адресе.
		if conn, err := net.ListenUDP("udp", addr); err != nil {
			log.Error("listening failed", "reason", err)
		} else {

			//обслуживание клиента
			NewClient(conn).serve()
		}
	}
}