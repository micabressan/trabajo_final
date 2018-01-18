package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
)

const (
	URL   = "https://api.github.com/graphql"
	TOKEN = "<TOKEN>"
)

func main() {
	queries := []string{
		`query {
			repositoryOwner(login: "tslnc04") {
				repositories(last: 10) {
					nodes {
						description
					}
				}
		  	}
		}`,
	}

	for _, query := range queries {
		makeRequest(queryToRequest(strconv.QuoteToASCII(query)))
	}
}

func queryToRequest(queryString string) string {
	return `{"query": ` + queryString + `}`
}

func makeRequest(requestString string) {
	req, err := http.NewRequest("POST", URL, strings.NewReader(requestString))

	if err != nil {
		panic(err)
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+TOKEN)

	client := &http.Client{}
	resp, err := client.Do(req)

	if err != nil {
		panic(err)
	}

	defer resp.Body.Close()

	fmt.Println("Status:", resp.Status)
	body, _ := ioutil.ReadAll(resp.Body)
	fmt.Println("Body:", string(body))
}