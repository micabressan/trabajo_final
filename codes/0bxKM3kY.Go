package main

import "golang.org/x/tour/reader"

type MyReader struct{}

func (MyReader) Read(x []byte) (int, error) {
	i := 0
	for i < len(x) {
		x[i] = 'A'
		i += 1
	}
	return i, nil
}

// TODO: Add a Read([]byte) (int, error) method to MyReader.

func main() {
	reader.Validate(MyReader{})
}