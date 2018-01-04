package main

import (
    "net/http"
    "log"
    "github.com/vaughan0/go-ini"
    "encoding/json"
)

type Section struct {
    Name string      `json:"service"`
    Domains []string `json:"domains"`
}

type ISP []Section

type Service struct {
    Name string `json:"service"`
}

var isp = ISP{}

func uploadData(w http.ResponseWriter, r *http.Request) {

    file, err := ini.LoadFile("isp.ini")

    if err != nil {
        http.Error(w, "{\"error\":\"cant_read_ini_file\"}", 500)
        return
    }

    for name, iniSection := range file {
        section := Section{}
        section.Name = name

        for key, value := range iniSection {
            if value == "1" {
                section.Domains = append(section.Domains, key);
            }
        }

        isp = append(isp, section)
    }
}

func getData(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(isp)
}

func getServiceByDomain(w http.ResponseWriter, r *http.Request) {
    if len(isp) == 0 {
        http.Error(w, "{\"error\":\"no_content\"}", 204)
    }

    domain := r.URL.Path[len("/service/"):]

    for _, section := range isp {
        for _, sectionDomain := range section.Domains {
            if sectionDomain == domain {
                json.NewEncoder(w).Encode(Service{Name: section.Name})
                return
            }
        }
    }

    http.Error(w, "{\"error\":\"service_not_found\"}", 404)
}

func main() {
    http.HandleFunc("/", getData)
    http.HandleFunc("/service/", getServiceByDomain)
    http.HandleFunc("/upload", uploadData)
    err := http.ListenAndServe(":9098", nil)
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}