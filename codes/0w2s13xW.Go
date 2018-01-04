package main

import (
    "encoding/json"
    "fmt"
    "log"
    "net/http"

    "goji.io"
    "goji.io/pat"
    "gopkg.in/mgo.v2"
    "gopkg.in/mgo.v2/bson"
)

func ErrorWithJSON(w http.ResponseWriter, message string, code int) {
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(code)
    fmt.Fprintf(w, "{message: %q}", message)
}

func ResponseWithJSON(w http.ResponseWriter, json []byte, code int) {
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(code)
    w.Write(json)
}

type Anggota struct {
    _id    string   `json:"id"`
    Nama    string   `json:"nama"`
    Departemen   string   `json:"departemen"`
}

Data := type struct {
  status bool
  ResultCode int
  Message string
  Value []*Anggota
}

func main() {
    session, err := mgo.Dial("localhost")
    if err != nil {
        panic(err)
    }
    defer session.Close()

    session.SetMode(mgo.Monotonic, true)
    ensureIndex(session)

    mux := goji.NewMux()
    mux.HandleFunc(pat.Get("/anggota"), allAnggotas(session))
    mux.HandleFunc(pat.Get("/testing"), testing(session))
    mux.HandleFunc(pat.Post("/anggota"), addAnggota(session))
    mux.HandleFunc(pat.Get("/anggota/:nama"), anggotaByName(session))
    mux.HandleFunc(pat.Put("/anggota/:nama"), updateAnggota(session))
    mux.HandleFunc(pat.Delete("/anggota/:nama"), deleteAnggota(session))
    http.ListenAndServe("localhost:8080", mux)
}

func ensureIndex(s *mgo.Session) {
    session := s.Copy()
    defer session.Close()

    c := session.DB("bempnj").C("anggota")

    index := mgo.Index{
        Key:        []string{"id"},
        Unique:     true,
        DropDups:   true,
        Background: true,
        Sparse:     true,
    }
    err := c.EnsureIndex(index)
    if err != nil {
        panic(err)
    }
}

func allAnggotas(s *mgo.Session) func(w http.ResponseWriter, r *http.Request) {
    return func(w http.ResponseWriter, r *http.Request) {
        session := s.Copy()
        defer session.Close()

        c := session.DB("bempnj").C("anggota")

        var anggotas []Anggota
        err := c.Find(bson.M{}).All(&anggotas)
        if err != nil {
            ErrorWithJSON(w, "Database error", http.StatusInternalServerError)
            log.Println("Failed get all anggota: ", err)
            return
        }
        respBody, err := json.MarshalIndent(anggotas, "", "  ")

        if err != nil {
            log.Fatal(err)
        }

        ResponseWithJSON(w, respBody, http.StatusOK)

    }
}