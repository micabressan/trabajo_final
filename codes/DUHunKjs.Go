package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	out := os.Stdout
	if !(len(os.Args) == 2 || len(os.Args) == 3) {
		panic("usage go run main.go . [-f]")
	}
	path := os.Args[1]
	printFiles := len(os.Args) == 3 && os.Args[2] == "-f"
	err := dirTree(out, path, printFiles)
	if err != nil {
		panic(err.Error())
	}
}

func dirTree(out io.Writer, path string, pf bool) error {
	fmt.Fprintln(out, path)
	return printTree(out, path, "", 0, false, pf)
}

func printTree(out io.Writer, path, parentIndent string, level int, last, pf bool) error {
	if !strings.HasSuffix(path, "/") {
		path = path + "/"
	}

	// Получаем содержимое директории.
	dirFiles, err := ioutil.ReadDir(path)
	if err != nil {
		return err
	}

	// Фильтруем содержимое на основе указания флага -f.
	var requiredFiles []os.FileInfo
	for _, file := range dirFiles {
		if file.IsDir() {
			requiredFiles = append(requiredFiles, file)
		} else if pf {
			requiredFiles = append(requiredFiles, file)
		}
	}

	// Итерируемся по содержимому.
	for i, file := range requiredFiles {
		name := filepath.Base(file.Name())

		// Генерируем отступ и имя (с префиксом)
		indent := generateIndent(parentIndent, level, last)
		nameWithPrefix := generatePrefix(i == len(requiredFiles)-1) + name

		// Выводим отступ и имя (с префиксом).
		fmt.Fprintln(out, indent+nameWithPrefix)

		if file.IsDir() {
			printTree(out, path+name, indent, level+1, i == len(requiredFiles)-1, pf)
		}
	}

	return nil
}

func generateIndent(parentIndent string, level int, last bool) string {
	if level > 0 {
		if last {
			return parentIndent + "    "
		} else {
			return parentIndent + "│   "
		}
	}
	return ""
}

func generatePrefix(last bool) string {
	if last {
		return "└───"
	}
	return "├───"
}