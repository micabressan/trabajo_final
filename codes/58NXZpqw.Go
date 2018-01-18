package main                                                                    
                                                                                
import (
		"fmt"
        "golang.org/x/tour/tree"                                                
)                                                                               
                                                                         
// Walk walks the tree t sending all values                                     
// from the tree to the channel ch.                                             
func Walk(t *tree.Tree, ch chan int){                                           
        if t.Left != nil {                                                      
                Walk(t.Left, ch)                                                
        }                                                                       
		ch <- t.Value                                                   
        if t.Right != nil {                                                     
                Walk(t.Right, ch)                                               
        }                                                                       
}                                                                               

func helper(t *tree.Tree, ch chan int) {
	Walk(t, ch)                                                         
    close(ch)  		
}

// Same determines whether the trees                                            
// t1 and t2 contain the same values.                                           
func Same(t1, t2 *tree.Tree) bool {
	ch1 := make(chan int)
	ch2 := make(chan int)
	go helper(t1, ch1)
	go helper(t2, ch2)       
    for {                                                    
		v1, ok1 := <-ch1
		v2, ok2 := <-ch2
		if !ok1 || !ok2 {
			return ok1 == ok2
		}
		if v1 != v2 {
			break
		}
	}
	return false
}

func main() {                                                                   
        t1 := tree.New(1)
		t2 := tree.New(1)
		fmt.Println(Same(t1, t2))
}