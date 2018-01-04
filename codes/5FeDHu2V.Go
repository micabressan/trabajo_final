package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"encoding/json"
)

type checks struct {
	comm string `json:"command"`
	interval int `json:"interval"`
	subscribers []string `json:"subscribers"`
	name string `json:"name"`
	issued float64 `json:"issued"`
	executed float64 `json:"executed"`
	duration float64 `json:"duration"`
	output string `json:"output"`
	status int `json:"status"`
	types string `json:"type"`
	history []int `json:"history"`
}

type results struct {
	client	string `json:"client"`
	checker []checks `json:"checks"`
}

type finalResults struct {
	clients []results
}

func main() {

	res, err := http.Get("DOMAIN")
	if err!=nil {
		panic(err.Error())
	}

	body, err := ioutil.ReadAll(res.Body)
	if err!=nil {
		panic(err.Error())
	}

	s, err := getResults([]byte(body))
	if err != nil {
		panic(err.Error())
	}

	fmt.Println(s)

}


func getResults(body []byte) (*finalResults, error) {
	var s = new(finalResults)
	err := json.Unmarshal(body, &s)
	if (err != nil) {
		fmt.Println(err)
	}
	return s, err
}