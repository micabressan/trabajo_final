package main

import (
    "bufio"
    "fmt"
    "os"
    "regexp"
)

func main() {
    r, err := regexp.Compile(`Hello`)
        myRegex := regexp.MustCompile("/abc/zzz/")
        myString := "abc def ghi"
        myRegex.ReplaceAllString(myString, "$2 $1") // "def abc ghi"


        reg, MyErr := regexp.Compile("\\x00")
        if MyErr != nil {
                panic(MyErr)
        }
        //safe := reg.ReplaceAllString("a*- +fe 5 v90 34,j*.A    E6", "")


    if err != nil {
        fmt.Printf("There is a problem with your regexp.\n")
        return
    }

    file, err := os.Open("DataWithNullsEveryOtherCharacter.csv")
    if err != nil {
        panic(err)
    }

    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
                myStr := scanner.Text()
        // fmt.Printf(">>[%s]\n", myStr)
                safe := reg.ReplaceAllString(myStr, "")
        fmt.Printf("%s\n", safe)
    }