package main

import (
	"io"
	"os"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}

func (cypher rot13Reader) Read(r []byte) (int, error) {
	const rot13Coded = "NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm"
	const rot13Decoded = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	b := make([]byte, len(r))
	n, err := cypher.r.Read(b)
	for i, val := range b {
		strIndex := strings.IndexByte(rot13Coded, val)
		if strIndex != -1 {
			r[i] = rot13Decoded[strIndex]
		} else {
			r[i] = b[i]
		}
	}
	return n, err
}

func main() {
	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}