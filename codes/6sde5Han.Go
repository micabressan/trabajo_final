main.go
-------
package main

import (
	_ "net/http/pprof"
	"fmt"
	"github.com/valyala/fasthttp"
	"time"
	"github.com/Sirupsen/logrus"
	"sync"
	"strings"
)

var urls []string

var urlsCount = 20
var timeout = time.Millisecond * 700

func initUrls() {

	for i := 0; i < urlsCount; i++ {
		urls = append(urls, fmt.Sprintf("http://xml.adoptim.com/search?feed=99810&auth=bu64S2&subid=%d&ua=mozilla&url=http://ya.ru&user_ip=3.0.0.0&query=www", i))
	}
}

func main() {

	initUrls()

	clearScreen()
	print(0, 0, strings.Repeat(".", urlsCount - 1), true)
	fmt.Print("\n")

	logrus.Info("Listening on 127.0.0.1:8000")

	fasthttp.ListenAndServe("127.0.0.1:8000", handler)

}

func handler(ctx *fasthttp.RequestCtx) {

	var wg sync.WaitGroup

	wg.Add(urlsCount)

	for idx, url := range urls {
		go func(idx int, url string) {
			print(0, idx, "*", false)

			defer print(0, idx, ".", false)
			defer wg.Done()

			code, _, err := fasthttp.GetTimeout(nil, url, timeout)
			if err != nil {
				logrus.Error("Response error:", err)
				return
			}
			if code != 200 {
				logrus.Error("Response code:", code)
			}

		}(idx, url)
	}

	wg.Wait()

	fmt.Fprint(ctx, "complete")
}


display.go
----------
package main

import "fmt"

func clearScreen() {
	fmt.Print("\033[2J")
}

func print(x, y int, message string, clearLine bool) {

	s := fmt.Sprintf("\033[%d;%dH", x, y)

	fmt.Print()
	if clearLine {
		s = s + fmt.Sprint("\033[K")
	}
	fmt.Print(s + message)
}