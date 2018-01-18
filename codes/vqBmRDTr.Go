package main

import (
	"golang.org/x/tour/tree"
	"fmt"
)
// type Tree struct {
//    Left  *Tree
//    Value int
//    Right *Tree
// }

// Walk walks the tree t sending all values
// from the tree to the channel ch.
func Walk(t *tree.Tree, ch chan int){
	ch <- t.Value
	if t.Left != nil {
		Walk(t.Left, ch)
	}
	if t.Right != nil {
		Walk(t.Right, ch)
	}
	if len(ch) == 10 {
		close(ch)
	}
}

func SyncWalk(t *tree.Tree){
	fmt.Println("SyncWalk", t.Value)
	if t.Left != nil {
		SyncWalk(t.Left)
	}
	if t.Right != nil {
		SyncWalk(t.Right)
	}
}

// Same determines whether the trees
// t1 and t2 contain the same values.
// func Same(t1, t2 *tree.Tree) bool

func main() {
	var treeSize int = 1
	t1 := tree.New(treeSize)
	ch1 := make(chan int)
	//SyncWalk(t1)
	go Walk(t1, ch1)
	 for {
	 	v, err := <-ch1
		fmt.Println("Walk", v)
		if err == false {
			break
		}
	}
	close(ch1)
}