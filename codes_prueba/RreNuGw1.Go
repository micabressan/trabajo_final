package main

import (
	//"fmt"
	"io"
	"os"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}

func (rot rot13Reader) Read(b []byte) (int, error) {
	for {
		_ , err := rot.r.Read(b)
		if err == io.EOF {
			break
		}
	}
	
	for i, v := range(b) {
		if v == 0 {
			break
		}
		switch {
			case 97 <= v && v <= 122:
				//fmt.Println(i, v, string(v), string((((v - 96) + 13) % 26) + 96))
				b[i] = (((v - 96) + 13) % 26) + 96
			case 65 <= v && v <= 90:
				//fmt.Println(i, v, string(v), string((((v - 64) + 13) % 26) + 64))
				b[i] = (((v - 64) + 13) % 26) + 64
			case v == 32:
				//fmt.Println(i, v, string(v), string(v))
				continue
		}
	}
	return len(b), io.EOF
}

func main() {
	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}