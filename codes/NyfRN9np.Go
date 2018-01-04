package main
import (
	"net/http"
	"io/ioutil"
	"fmt"
)

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
	site := "https://www.ya.ru"
	content, err := GET(site)
	if err == nil {
		fmt.Println(content)
	}
}