package main

import (
	"strconv"
	"os"
	"fmt"
	"net"
	"github.com/skorobogatov/input"
	"golang.org/x/net/html"
	"encoding/json"
	"net/http"
	"io/ioutil"
)

import (
	s "strings"
)

//структура для передачи сообщений
type Request struct {
	//в поле Depth находится глубина
	Depth int `json:"depth"`

	//в поле Data находится текст сообщения
	Data string `json:"data"`

	Substring string `json:"substring"`

	Num int `json:"num"`
}

//массив для упрощения ввода
var data = []string{"127.0.0.1:5000",
	"127.0.0.15:6000",
	"127.0.0.23:4000",
	"127.0.12.125:6000",
	"127.1.0.150:6000"}

var err bool

type Pir struct {
	name string
	m    [100]string
	pos  int
}

func NewPir(name string) *Pir {
	return &Pir{
		name: name,
		pos:  0,
	}
}

func getAttr(node *html.Node, key string) string {
	for _, attr := range node.Attr {
		if attr.Key == key {
			return attr.Val
		}
	}
	return ""
}

func isElem(node *html.Node, tag string) bool {
	return node != nil && node.Type == html.ElementNode && node.Data == tag
}

func isA(node *html.Node) bool {
	return isElem(node, "a")
}

func search(node *html.Node) []*string {
	if isA(node) {
		var items []*string
		var href string
		href = getAttr(node, "href")
		items = append(items, &href)
	}
	for c := node.FirstChild; c != nil; c = c.NextSibling {
		if items := search(c); items != nil {
			return items
		}
	}
	return nil
}

func downloadWeb(href string) []*string {
	log.Info("sending request to ", href)
	if response, err := http.Get(href); err != nil {
		log.Error("request to ", href, " error", err)
	} else {
		defer response.Body.Close()
		status := response.StatusCode
		log.Info("got response from ", href, " status", status)
		if status == http.StatusOK {
			if doc, err := html.Parse(response.Body); err != nil {
				log.Error("invalid HTML from ", href, " error", err)
			} else {
				log.Info("HTML from ", href, " parsed successfully")
				return search(doc)
			}
		}
	}
	return nil
}

func getTexts(site string) (content string, err error) {
	response, err := http.Get(site)
	if err == nil {
		defer response.Body.Close()
		content, err := ioutil.ReadAll(response.Body)
		if err == nil {
			return string(content[:]), nil
		} else {
			return "", err
		}
	} else {
		return "", err
	}
}

func find(depth int, href string, subs string, num int) {
	if depth > 0 {
		fmt.Printf(("Finding a substring")
		var items []*string
		var str string
		items = downloadWeb(href)
		depth--
		var k int
		k = 0
		for i := 0; i < len(items); i++ {
			if k >= num {
				k = 0
			}
			if k != num {
				if addr, err := net.ResolveTCPAddr("tcp", data[k]); err != nil {
					fmt.Printf("error: %v\n", err)
				} else if conn, err := net.DialTCP("tcp", nil, addr); err != nil {
					fmt.Printf("error: %v\n", err)
				} else {
					defer conn.Close()
					enc := json.NewEncoder(conn)
					str = *items[i]
					enc.Encode(&Request{depth, str, subs, k})
				}
			}
			k++

		}
		content, _ := getTexts(href)
		if s.Contains(content, subs) {
			fmt.Printf(href, " found substring")
		}
	} else {
		depth--
		content, _ := getTexts(href)
		if if s.Contains(content, subs) {
			fmt.Printf(href, " found substring")
		}
	}
}

//цикл обработки команд пользователя
//find - найти подстроку
//exit - закончить сеанс
func begin(pir *Pir, num int) {
	for {
		fmt.Printf("command: ")
		var command string
		fmt.Scanln(&command)

		switch command {
		case "find":
			var n int
			fmt.Printf("depth: ")
			fmt.Scan(&n)

			fmt.Printf("substring: ")
			subs := input.Gets()

			fmt.Printf("reference: ")
			href := input.Gets()

			find(n, href, subs, num)

		case "exit":
			addr, _ := net.ResolveTCPAddr("tcp", pir.name)
			conn, _ := net.DialTCP("tcp", nil, addr)
			enc := json.NewEncoder(conn)
			enc.Encode(&Request{-1, "", "", -1})
			return
		default:
			fmt.Printf("error: unknown command\n")
			continue
		}
	}
}

func main() {
	if num, err := strconv.Atoi(os.Args[1]); err != nil {
		log.Error("error with args command line", "reason", err)
	} else {
		fmt.Printf("start %d\n", num)
		if addr, err := net.ResolveTCPAddr("tcp", data[num]); err != nil {
			log.Error("address resolution failed", "address", data[num])
		} else {
			if listener, err := net.ListenTCP("tcp", addr); err != nil {
				log.Error("listening failed", "reason", err)
			} else {
				pir := NewPir(data[num])

				//обработка команд пользователя
				go begin(pir, num)

				//Цикл приёма и сохранения входящих сообщений от пиров
				for {
					if conn, err := listener.AcceptTCP(); err != nil {
						log.Error("cannot accept connection", "reason", err)
					} else {
						defer conn.Close()
						dec := json.NewDecoder(conn)
						var ans Request
						if err := dec.Decode(&ans); err != nil {
							log.Error("cannot decode message", "reason", err)
						} else if ans.Depth == -1 && ans.Data == "" {
							break
						} else {
							find(ans.Depth, ans.Data, ans.Substring, ans.Num)
						}
					}
				}
			}
		}
	}
}