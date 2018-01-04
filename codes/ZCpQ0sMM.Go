/*
Original code by Gregory Schier
https://schier.co/blog/2015/04/26/a-simple-web-scraper-in-go.html

Edited by Nicolas Banaczek
*/

package main

import (
	"fmt"
	"golang.org/x/net/html"
	"net/http"
	"strings"
	//"time"
)

type urls struct {
	origin string
	url string
}

// Helper function to pull the href attribute from a Token
func getHref(t html.Token) (ok bool, href string) {
	// Iterate over all of the Token's attributes until we find an "href"
	for _, a := range t.Attr {
		if a.Key == "href" {
			href = a.Val
			ok = true
		}
	}

	// "bare" return will return the variables (ok, href) as defined in
	// the function definition
	return
}

// Extract all http** links from a given webpage
func crawl(url string, ch chan urls, chFinished chan bool) {
	resp, err := http.Get(url)
	urls := urls{url,""}

	defer func() {
		// Notify that we're done after this function
		chFinished <- true
	}()

	if err != nil {
		fmt.Println("ERROR: Failed to crawl \"" + url + "\"")
		return
	}

	b := resp.Body
	defer b.Close() // close Body when the function returns

	z := html.NewTokenizer(b)

	for {
		tt := z.Next()

		switch {
		case tt == html.ErrorToken:
			// End of the document, we're done
			return
		case tt == html.StartTagToken:
			t := z.Token()

			// Check if the token is an <a> tag
			isAnchor := t.Data == "a"
			if !isAnchor {
				continue
			}

			// Extract the href value, if there is one
			ok, url := getHref(t)
			if !ok {
				continue
			}

			// Make sure the url begins in /wiki/
			hasProto := strings.Index(url, "/wiki/") == 0
			if hasProto {
				urls.url = "https://fr.wikipedia.org" + url
				ch <- urls
			}
		}
	}
}

func checkLoop(url string, path []string) bool {
	for _, x := range path {
		if x == url {return true}
	}
	return false
}

func isUnique(url string, table map[string][]string) bool {
	for _, slice := range table {
		for _, element := range slice {
			if url == element {
				return false
			}
		}
	}
	return true
}

func main() {
	foundUrls := make(map[string][]string)
	found := false
	targetUrl, startUrl := "",""

	fmt.Println("Page d'origine :")
	fmt.Scanln(&startUrl)
	fmt.Println("Page de fin :")
	fmt.Scanln(&targetUrl)

	seedUrls := []string{startUrl}

	// Channels
	chUrls := make(chan urls)
	chFinished := make(chan bool)

	//While our target isn't found...
	for !found {
		// Kick off the crawl process (concurrently)
		for _, url := range seedUrls {
			go crawl(url, chUrls, chFinished)
		}

		// Subscribe to both channels
		for c := 0; c < len(seedUrls); {
			select {
			case urls := <-chUrls:
				if urls.url == targetUrl {
					found = true
				}
				foundUrls[urls.url] = foundUrls[urls.origin]
				foundUrls[urls.url] = append(foundUrls[urls.url],urls.origin)
			case <-chFinished:
				c++
			}
		}
		seedUrls = []string{}

		//Create a new seed urls table
		for lastUrl, path := range foundUrls {
			if !checkLoop(lastUrl, path) && isUnique(lastUrl, foundUrls){
				seedUrls = append(seedUrls,lastUrl)
			}
		}
		//do once:
		//found = true

	}


	// We're done! Print the results...
	fmt.Println("\nFound", len(foundUrls), "unique urls\n")
	fmt.Println(strings.Replace(strings.Join(foundUrls[targetUrl]," -> ") + " -> " + targetUrl,"https://fr.wikipedia.org/wiki/","",-1))

	close(chUrls)
}