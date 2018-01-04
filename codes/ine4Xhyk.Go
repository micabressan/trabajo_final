package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"
)

type (
	facebook struct {
		Data []data `json:"data"`
	}
	data struct {
		ID string `json:"id"`
	}
)

func main() {
	var id, oldid, accesstoken, pageid, msg string
	accesstoken = input("Enter access_token :")
	pageid = input("Enter Page ID :")
	msg = input("Enter Msg :")
	act := false
	for {
		if !act {
			fmt.Println("System :> Get Feed...")
			feed := api(pageid + "/feed?access_token=" + accesstoken)
			var fb facebook
			json.Unmarshal([]byte(feed), &fb)
			id = fb.Data[0].ID
			fmt.Println("System :> new ID = " + id + " | Old ID = " + oldid)
			if id != oldid {
				act = true
				comments := api(id + "/comments?message=" + url.QueryEscape(msg) + "&method=post&access_token=" + accesstoken)
				if comments != "" {
					act = false
					oldid = id
					fmt.Println("System :> Comments Success " + comments)
				} else {
					act = false
					fmt.Println("System :> Can't Comments ID = " + id + " !!!!")
				}
			}
		} else {
			fmt.Println("System :> Running comments...")
		}
	}
}
func input(enter string) string {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print(enter)
	text, _ := reader.ReadString('\n')
	return text
}
func api(path string) string {
	resp, err := http.Get("https://graph.facebook.com/" + path)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	html := string(body)
	return html
}