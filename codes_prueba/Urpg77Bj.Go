package main
import (
	"net/http"
	"io/ioutil"
	"fmt"
	"golang.org/x/net/html"
	"strings"
	"bytes"
)

func str(content string) (str string, err error) {
	doc, err := html.Parse(strings.NewReader(content))
	if err != nil {
		return "", err
	}

	var buffer bytes.Buffer

	var f func(*html.Node)
	f = func(n *html.Node) {
		if n.Type == html.TextNode &&
			(n.Parent.Data == "a" || n.Parent.Data == "span" || n.Parent.Data == "h1" || n.Parent.Data == "h2" || n.Parent.Data == "h3" || n.Parent.Data == "p") {
			buffer.WriteString(n.Data + "\n")

			for _, a := range n.Attr {
				if a.Key == "value" {
					fmt.Println(a.Val)
					break
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			f(c)
		}
	}
	f(doc)
	return buffer.String(), nil
}

func GET(site string) (content string, err error){
	response, err := http.Get(site)
	if err == nil {
		defer response.Body.Close()
		content, err := ioutil.ReadAll(response.Body)
		if err == nil {
			return string(content[:]), nil
		} else {
			// TODO Handle this
			return "", err
		}
	} else	{
		// TODO Handle this
		return "", err
	}
}

func main() {
	site := "https://www.yandex.ru"
	content, err := GET(site)
	if err == nil {
		strs, err := str(content)
		if err == nil {
			fmt.Println(strs)
		}
	}
}