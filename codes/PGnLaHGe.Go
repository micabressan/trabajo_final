package main

import (
	"flag"
	"log"
	"net/http"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"math"
	"strconv"
	"time"
	"strings"
	"errors"
	"bytes"
	"github.com/valyala/fasthttp"
)

type mirror struct {
	name string
	url  string
}
type mirrorsArray []mirror

func (i *mirrorsArray) String() string {
	var buffer bytes.Buffer
	for k, mirror := range *i {
		if k > 0 {
			buffer.WriteRune('\n')
		}
		buffer.WriteString(mirror.name)
		buffer.WriteRune('=')
		buffer.WriteString(mirror.url)
	}
	return buffer.String()
}

func (i *mirrorsArray) Set(value string) error {
	parts := strings.SplitN(value, "=", 2)
	if len(parts) != 2 {
		return errors.New("mirror not in format name=url")
	}
	*i = append(*i, mirror{
		name: parts[0],
		url:  parts[1],
	})
	return nil
}

var (
	addr    = flag.String("listen-address", ":9420", "The address to listen on for HTTP requests.")
	mirrors mirrorsArray
)

func main() {
	flag.Var(&mirrors, "mirror", "Mirror to observe")
	flag.Parse()
	client := fasthttp.Client{}
	registry := prometheus.NewRegistry()
	for _, mirror := range mirrors {
		var lastsyncUrl = mirror.url + "/lastsync"
		registry.MustRegister(prometheus.NewCounterFunc(prometheus.CounterOpts{
			Name: "sync_delay",
			Help: "Time difference between Tier 1 mirror",
			ConstLabels: prometheus.Labels{
				"name": mirror.name,
				"url":  mirror.url,
			},
		}, func() float64 {
			statusCode, body, err := client.Get(nil, lastsyncUrl)
			if err != nil {
				log.Print(err)
				return math.NaN()
			}
			if statusCode != fasthttp.StatusOK {
				log.Printf("Error while loading lastsync from %s: %d", mirror.name, statusCode)
				return math.NaN()
			}
			syncTime, err := strconv.ParseInt(strings.TrimSpace(string(body)), 10, 64)
			if err != nil {
				log.Print(err)
				return math.NaN()
			}
			return float64(time.Now().Unix() - syncTime)
		}))
	}
	log.Fatal(http.ListenAndServe(*addr, promhttp.HandlerFor(registry, promhttp.HandlerOpts{})))
}