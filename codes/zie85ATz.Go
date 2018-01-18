package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

var b, q, f string = `./`, `├───`, `└───`
var n, p int = 1, 0

func printTree(p, a, idx, l int, s string) int {
	if idx == 1 {
		if a == l-1 {
			fmt.Println(f + s)
			return 0
		}
		fmt.Println(q + s)
		return 0
	}
	w := ""
	for x := 0; x < idx-p-1; x++ {
		w += "│ "
	}
	for x := 0; x < p; x++ {
		w += "  "
	}
	if a == l-1 {
		fmt.Println(w + f + s)
		return 0
	} else {
		fmt.Println(w + q + s)
		return 0
	}
}

func tree(g []os.FileInfo, p int) {
	for idx, file := range g {
		printTree(p, idx, n, len(g), file.Name())
		if file.IsDir() {
			if idx == len(g)-1 {
				p++
			}
			n++
			b1 := b
			b += file.Name() + `/`
			files, err := ioutil.ReadDir(b)
			if err != nil {
				fmt.Print(err)
			}
			tree(files, p)
			b = b1
			n--
			if p > 0 {
				p--
			}
		}
	}
}

func main() {
	files, err := ioutil.ReadDir(".")
	if err != nil {
		fmt.Print(err)
	}
	tree(files, p)
}