package main

import (
    "bufio"
    "fmt"
    "os"
    "strings"
    "strconv"
    "math"
)

func main() {
   var sum1_1 int = 0
   var sum1_2 int = 0
   reader := bufio.NewReader(os.Stdin)
   input, _ := reader.ReadString('\n')
   
   input = strings.Replace(input, "\n", "", -1)
   
   var inputLen = len(input)
   
   var step int = inputLen/2

    for i:= 0; i < inputLen; i++ {
        
        if i == len(input)-1 {
           if (input[i] == input[0]) {
               inputVal, _ := strconv.Atoi(string(input[0]))

               sum1_1 += inputVal
           }
        } else {
           if input[i] == input[i+1] {
               inputVal, _ := strconv.Atoi(string(input[i]))
               
               sum1_1 += inputVal
           }
        }
        
        if (input[i] == input[int(math.Mod(float64(i+step),float64(inputLen)))]){
            inputVal, _ := strconv.Atoi(string(input[i]))
            sum1_2 += inputVal
        }
    }
    
    fmt.Printf("Day 1_1 the sum is: %d\n",sum1_1)
    fmt.Printf("Day 1_2 the sum is: %d\n",sum1_2)
    
}