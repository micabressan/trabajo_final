package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
)

var (
	regNrRegExp    = regexp.MustCompile("^.*Reg.*nr.*$")
	finnCodeRegExp = regexp.MustCompile("^.*finnkode=([0-9]+).*$")
)

func main() {
	urls := []string{
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=2005&REGISTRATION_CLASS=1&sort=1",
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=2005&REGISTRATION_CLASS=2&sort=1",
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=1986&YEAR_MODEL_TO=1997&REGISTRATION_CLASS=1&sort=1",
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=1986&YEAR_MODEL_TO=1997&REGISTRATION_CLASS=2&sort=1",

		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_TO=1985&REGISTRATION_CLASS=1&sort=1",
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=1998&YEAR_MODEL_TO=2004&REGISTRATION_CLASS=2&sort=1",
		"http://www.finn.no/finn/car/used/result?MOTOR_DEALER_SEGMENT=3&CAR_SALESFORM=1&YEAR_MODEL_FROM=1998&YEAR_MODEL_TO=2004&REGISTRATION_CLASS=1&sort=1",
	}

	retultFileName := "data/results.html"
	var total uint64
	for index, url := range urls {
		foldername := fmt.Sprintf("data/category_%d/", index)
		os.MkdirAll(foldername, 0600)
		filename := foldername + "RegNrs.txt"
		os.Create(filename)
		f, err := os.OpenFile(filename, os.O_APPEND|os.O_RDWR, 0600)
		if err != nil {
			panic(err)
		}
		defer f.Close()

		page := 1
		categoryTotal := 0
		hasMore := true
		for hasMore {
			doc, _ := loadURL(fmt.Sprintf("%s&page=%d", url, page))
			selection := doc.Find("#resultlist .inner.pvn")
			hasMore = selection.Length() > 0
			if hasMore {
				selection.Each(func(i int, s *goquery.Selection) {
					a := s.Find("h2 a")
					href, ok := a.Attr("href")
					var regNrString string
					if ok {
						autoSelection, _ := loadURL(href)
						dt := autoSelection.Find("div[data-automation-id='information'] dt")
						dd := dt.FilterFunction(func(i int, s *goquery.Selection) bool {
							str, _ := s.Html()
							m := regNrRegExp.FindStringSubmatch(str)
							return m != nil
						}).Next()
						regNrString, _ = dd.Html()
						if regNrString == "" {
							regNrString = "[noname]"
						}
						finnkode := finnCodeRegExp.FindStringSubmatch(href)[1]

						// Get images
						imagesURL := fmt.Sprintf("http://www.finn.no/finn/car/used/viewimage?finnkode=%s", finnkode)
						imagesSelection, _ := goquery.NewDocument(imagesURL)
						imagesSelection.Find(".inner .thumbinnerwrap img").Each(func(i int, s *goquery.Selection) {
							imageURL, ok := s.Attr("src")
							if ok {
								imageURL = strings.Replace(imageURL, "_thumb", "_xl", -1)
								imageName := fmt.Sprintf("%s_%s_%d.jpg", regNrString, finnkode, time.Now().Nanosecond()/100)
								response, e := http.Get(imageURL)
								if e != nil {
									log.Fatal(e)
								}

								defer response.Body.Close()
								//open a file for writing
								file, err := os.Create(foldername + imageName)
								defer file.Close()
								if err != nil {
									log.Fatal(err)
								}
								// Use io.Copy to just dump the response body to the file. This supports huge files
								_, err = io.Copy(file, response.Body)
								if err != nil {
									log.Fatal(err)
								}
							}
						})

						writeInfo(f, href, regNrString)

						total++
						categoryTotal++

						str := fmt.Sprintf("<meta http-equiv=\"refresh\" content=\"5\" ><body>Current category: %d<br>\nCurrent page: %d<br>\nScrapped in category:%d<br>\nTotal scrapped: %d<br>\n</body>", index+1, page, total, categoryTotal)

						ioutil.WriteFile(retultFileName, []byte(str), 0666)
					}
				})
				page++
			}
		}
	}

	str := fmt.Sprintf("Finished. Total: %d", total)
	ioutil.WriteFile(retultFileName, []byte(str), 0666)
}

var i int

func loadURL(url string) (*goquery.Document, error) {
	i++
	wait := time.Millisecond * 300
	if i > 100 {
		i = 0
		wait = time.Millisecond * 5000
	}
	timeout := time.NewTimer(wait)
	<-timeout.C

	result, err := goquery.NewDocument(url)
	if err != nil {
		log.Fatal(url, " is unreached: ", err.Error())
		return nil, err
	}

	return result, nil
}

func writeInfo(f *os.File, link string, regNr string) {
	text := fmt.Sprintf("%s %s\n", link, regNr)
	if _, err := f.WriteString(text); err != nil {
		panic(err)
	}
}