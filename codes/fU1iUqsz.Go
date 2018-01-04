package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net"
	"os"
	"strconv"

	"github.com/mgutz/logxi/v1"
)
import "proto"

// Client - состояние клиента.
type Client struct {
	logger log.Logger   // Объект для печати логов
	conn   *net.UDPAddr // Объект TCP-соединения
	v1     []int        // 1 вектор
	v2     []int        // 2 вектор
	init   bool         // Были ли инициализ массивы
	number int          // Номер актуального сообщения клиента
}

// NewClient - конструктор клиента, принимает в качестве параметра
// объект UDP-соединения.
func NewClient(conn *net.UDPAddr) *Client {
	return &Client{
		logger: log.New(fmt.Sprintf("client %s", conn.String())),
		conn:   conn,
		v1:     nil,
		v2:     nil,
		init:   false,
		number: -1,
	}
}

//собственно сам сервер
func main() {
	var (
		serverAddrStr string
		helpFlag      bool
	)
	flag.StringVar(&serverAddrStr, "addr", "127.0.0.1:6000", "set server IP address and port")
	flag.BoolVar(&helpFlag, "help", false, "print options list")

	if flag.Parse(); helpFlag {
		fmt.Fprint(os.Stderr, "server [options]\n\nAvailable options:\n")
		flag.PrintDefaults()
	} else if serverAddr, err := net.ResolveUDPAddr("udp", serverAddrStr); err != nil {
		log.Error("resolving server address", "error", err)
	} else if conn, err := net.ListenUDP("udp", serverAddr); err != nil {
		log.Error("creating listening connection", "error", err)
	} else {
		log.Info("server listens incoming messages from arrOfClients")
		arrOfClients := make([]*Client, 0)
		buf := make([]byte, 128)
		for {
			errorMsg := ""
			if bytesRead, addr, err := conn.ReadFromUDP(buf); err != nil {
				log.Error("receiving message from client", "error", err)
			} else {
				//проверка на существование такого клиента
				k := -1
				for i := 0; i < len(arrOfClients); i++ {
					if arrOfClients[i].conn.String() == addr.String() {
						k = i
					}
				}
				//Новенький
				if k == -1 {
					arrOfClients = append(arrOfClients, NewClient(addr))
					k = len(arrOfClients) - 1
				}
				var Message proto.Request
				if err := json.Unmarshal(buf[:bytesRead], &Message); err != nil {
					errorMsg = "malformered one or more fields"
				} else {
					//в иксе будет лежать номер сообщения
					if x, err := strconv.Atoi(Message.Number); err != nil {
						log.Error("cannot parse answer", "answer", Message.Number, "error", err)
						errorMsg = "cannot parse Number field"
					} else {
						//обработка запроса ( < создано во имя избежания дубликаций)
						if arrOfClients[k].number < x {
							client := arrOfClients[k]
							switch Message.Command {
							case "quit":
								var raw json.RawMessage
								raw, _ = json.Marshal(interface{}(nil))
								var send_m json.RawMessage
								send_m, _ = json.Marshal(proto.Response{"ok", &raw})
								client.logger.Info("shutting down connection")
								if _, err = conn.WriteToUDP(send_m, addr); err != nil {
									log.Error("confirmation message to client", "error", err, "client", addr.String())
								}
								//получение векторов и записывание их в базу
							case "vecs":
								if Message.Data == nil {
									errorMsg = " data field is absent"
								} else {
									var frac proto.VectorsDot
									if err := json.Unmarshal(*Message.Data, &frac); err != nil {
										errorMsg = "malformed data field"
									} else {
										if err != nil {
											errorMsg = "cannot parse Data field"
										} else {
											client.v1 = frac.VectorF
											client.v2 = frac.VectorS
											if len(client.v1) != len(client.v2) {
												errorMsg = "malformed data field"
											} else {
												client.logger.Info("performing init_vecs", "value", "vecs")
											}
										}
									}
								}
								if errorMsg == "" {
									client.init = true
									send_response("ok", nil, conn, client.conn)
								} else {
									send_response("failed", errorMsg, conn, client.conn)
								}
								//вытаскивание векторов из базы и просчет скалярного произведения
							case "dotV":
								var mult int
								//достаточно условие инициализированности векторов
								if Message.Data == nil {
									errorMsg = " data field is absent"
								} else {
									if client.init {
										for k := 0; k < len(client.v1); k++ {
											mult += client.v1[k] * client.v2[k]
										}
										//отправляем результат
									} else {
										errorMsg = "not inited vecs!"
									}
								}
								if errorMsg == "" {
									send_response("result", mult, conn, client.conn)
								} else {
									send_response("failed", errorMsg, conn, client.conn)
								}
							default:
								send_response("failed", "unknown command", conn, client.conn)
							}
							arrOfClients[k].number = x
						}
					}
				}
			}
		}
	}
}

//отправка информации клиенту
func send_response(status string, data interface{}, conn *net.UDPConn, addr *net.UDPAddr) {
	var raw json.RawMessage
	var send_m json.RawMessage
	raw, _ = json.Marshal(data)
	send_m, _ = json.Marshal(proto.Response{status, &raw})
	if _, err := conn.WriteToUDP(send_m, addr); err != nil {
		log.Error("sending response to client", "error")
	}
}