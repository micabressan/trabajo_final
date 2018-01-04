package main

import (
	"bufio"
	"compress/gzip"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/gorilla/mux"
)

func cerr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

type gzipResponseWriter struct {
	io.Writer
	http.ResponseWriter
}

func (w gzipResponseWriter) Write(b []byte) (int, error) {
	return w.Writer.Write(b)
}

func Gzip(handler http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if !strings.Contains(r.Header.Get("Accept-Encoding"), "gzip") {
			handler.ServeHTTP(w, r)
		}
		w.Header().Set("Content-Encoding", "gzip")
		gz := gzip.NewWriter(w)
		defer gz.Close()
		gzw := gzipResponseWriter{Writer: gz, ResponseWriter: w}
		handler.ServeHTTP(gzw, r)
	})
}

func handleConnection(c net.Conn) {
	defer c.Close()

	r := bufio.NewReader(c)
	log.Print(r)
	fmt.Fprintln(c, r)

}

func NewListener() (err error) {
	// Listen on TCP port 2000 on all interfaces.
	l, err := net.Listen("tcp", ":2000")
	return err
	defer l.Close()
	for {
		// Wait for a connection.
		conn, err := l.Accept()
		return err
		// Handle the connection in a new goroutine.
		// The loop then returns to accepting, so that
		// multiple connections may be served concurrently.
		// Echo all incoming data.
		go handleConnection(conn)
	}
}

func NewSender(paths ...string) {
	for _, p := range paths {
		f, err := os.Open(p)
		cerr(err)
		r := bufio.NewReader(f)
		conn, err := net.Dial("tcp", "127.0.0.1:2000")
		cerr(err)
		io.Copy(conn, r)
	}
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "test")
}

func main() {
	// err := StartListener()
	r := mux.NewRouter()
	r.HandleFunc("/", Gzip(indexHandler))
	http.ListenAndServe(":8000", r)

}