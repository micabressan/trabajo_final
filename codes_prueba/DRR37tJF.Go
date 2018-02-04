package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
)

var p = fmt.Println

func remoteCall(directory string) {
	urlStr := "http://pastebin.com/api/api_post.php"

	data := url.Values{}
	data.Set("api_dev_key", "")
	data.Add("api_option", "trends")

	p(data.Encode())

	client := &http.Client{}
	r, _ := http.NewRequest("POST", urlStr, bytes.NewBufferString(data.Encode()))
	rsp, err := client.Do(r)
	if err != nil {
		panic(err)
	}

	defer rsp.Body.Close()

	body, _ := ioutil.ReadAll(rsp.Body)

	p(string(body))

}

func main() {
	directory := flag.String("d", "./", "path/to/working/directory")
	flag.Parse()

	remoteCall(*directory)
}