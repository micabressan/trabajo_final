package main

import "fmt"

const printStackSize = 100

type Node struct {
  Val int
  Left *Node
  Right *Node
}

type BinaryTree struct {
  root *Node
}

func (tree *BinaryTree) Add(x int) {
  /*
    Adds an int to the binary tree by creating a Node in the
    appropriate leaf. Internally we travel the tree by using
    a while loop instead of recursion.
  */

  node := tree.root

  // Create root node if it doesn't exist
  if node == nil {
    tree.root = &Node{Val:x}
    return
  }

  // Insert x in the appropriate leaf node
  for {

    if node.Val >= x {
      if node.Left == nil {
        node.Left = &Node{Val:x}
        break
      }
      node = node.Left
      continue

      } else {
        if node.Right == nil {
          node.Right = &Node{Val:x}
          break
        }
        node = node.Right

      }
  }
}

func (tree *BinaryTree) Print() {
  /*
    Traversal of the BinaryTree in pre-order while
    printing out the nodes value. Internally uses
    a stack (using GoLang's slices).
  */

  // var node *Node = tree.root
  node := tree.root

  if node == nil {
    return
  }

  stack := make([]*Node, 0, printStackSize)
  stack = append(stack, node)

  for len(stack) != 0 {
    // Pop the first element on the stack
    nodePtr := stack[len(stack) - 1]
    stack = stack[:len(stack) - 1]

    fmt.Printf("%d ", nodePtr.Val)

    // The reason why we first evaluate right then left is because
    // we are placing the node on a stack, therefore we will get to
    // the left value BEFORE the right
    if nodePtr.Right != nil {
      stack = append(stack, nodePtr.Right)
    }

    if nodePtr.Left != nil {
      stack = append(stack, nodePtr.Left)
    }


  }

  fmt.Printf("\n")
}

func (tree *BinaryTree) AddR(x int) {
  /*
    Recursive version of add()
  */

  node := tree.root

  if node == nil {
    tree.root = &Node{Val:x}
    return
  }

  addNodeR(node, x)
}

func addNodeR(n *Node, val int) {
  if n.Val >= val {
    if n.Left == nil {
      n.Left = &Node{Val:val}
      return
    }
    addNodeR(n.Left, val)
  } else {
    if n.Right == nil {
      n.Right = &Node{Val:val}
      return
    }
    addNodeR(n.Right, val)
  }
}

func main() {

  /*
    Builds the following binary tree:

                  11
                8   50
              4    20  60
            4   5
  */

  // Iterative adding elements
  tree := BinaryTree{}

  tree.Add(11)
  tree.Add(8)
  tree.Add(4)
  tree.Add(50)
  tree.Add(4)
  tree.Add(5)
  tree.Add(20)
  tree.Add(60)

  tree.Print()

  // Recursive adding elements
  treeR := BinaryTree{}

  treeR.AddR(11)
  treeR.AddR(8)
  treeR.AddR(4)
  treeR.AddR(50)
  treeR.AddR(4)
  treeR.AddR(5)
  treeR.AddR(20)
  treeR.AddR(60)

  treeR.Print()

}