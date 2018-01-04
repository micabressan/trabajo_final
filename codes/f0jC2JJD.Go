package main

import (
	"strconv"
	"fmt"
	"os"
)

type huffmanNode struct {
	nodeChar byte
	weight int
	leftNode *huffmanNode
	rightNode *huffmanNode
}
func pathTarversal(node  *huffmanNode, code string, keyMap *map[byte]string){
	if (node == nil){
		return
	}
	if node.leftNode != nil || node.rightNode != nil{
		pathTarversal(node.leftNode, code+"0", keyMap)
		pathTarversal(node.rightNode, code+"1", keyMap)
	}else{
		(*keyMap)[node.nodeChar] = code
	}
}
func flatTree(node  *huffmanNode, direction string, fp *string){
	if (node == nil){
		return
	}
	(*fp)+=(direction)
	if node.leftNode != nil || node.rightNode != nil{
		flatTree(node.leftNode, "<", fp)
		flatTree(node.rightNode, ">", fp)
	}else{
		if node.nodeChar > 127 {
			(*fp)+=("!"+string(255 - node.nodeChar))
		}else{
			(*fp)+=("."+string(node.nodeChar))
		}
	}
}
func buildTree(nodeArray []*huffmanNode) *huffmanNode{
	currentArray := nodeSorting(nodeArray)
	i:=0
	for ; len(currentArray) != 1 ; currentArray = nodeSorting(currentArray){
		i++
		parentNode := huffmanNode{}
		parentNode.leftNode=currentArray[0]
		parentNode.rightNode=currentArray[1]
		parentNode.weight = (*currentArray[0]).weight+(*currentArray[1]).weight
		parentNode.nodeChar=128
		currentArray[1] = &parentNode
		currentArray[0] = nil
	}
	return currentArray[0]
}
func removeNil(nodeArray []*huffmanNode) []*huffmanNode{
	var newArray []*huffmanNode
	for _,node := range nodeArray{
		if node != nil{
			newArray = append(newArray, node)
		}
	}
	return newArray
}
func nodeSorting(nodeArray []*huffmanNode) []*huffmanNode{
	nodeArray = removeNil(nodeArray)
	var newArray []*huffmanNode
	if len(nodeArray) > 2{
		firstChunkArray := nodeSorting(nodeArray[:len(nodeArray)/2])
		secondChunkArray := nodeSorting(nodeArray[(len(nodeArray)/2):])
		firstChunkIndex := 0
		secondChunkIndex := 0
		index:=0
		for range nodeArray{
			if (firstChunkIndex > len(firstChunkArray)-1){
				newArray = append(newArray,secondChunkArray[secondChunkIndex:]...)
				break
			}
			if (secondChunkIndex > len(secondChunkArray)-1){
				newArray = append(newArray,firstChunkArray[firstChunkIndex:]...)
				break
			}
			if (firstChunkArray[firstChunkIndex].weight < secondChunkArray[secondChunkIndex].weight) {
				newArray = append(newArray,firstChunkArray[firstChunkIndex])
				firstChunkIndex++
			}else{
				newArray = append(newArray,secondChunkArray[secondChunkIndex])
				secondChunkIndex++
			}
			index++
		}
	}else if len(nodeArray) == 2{
		newArray=append(newArray, nodeArray...)
		if nodeArray[0].weight > nodeArray[1].weight{
			newArray[0]=nodeArray[1]
			newArray[1]=nodeArray[0]
		}
	}else{
		newArray=append(newArray, nodeArray...)
	}
	return newArray
}
func main()  {
	var filename, outputFile string
	fmt.Printf("Input File:")
	fmt.Scanf("%s ",&filename)
	bucket := make(map[byte]int, 1)
	keyMap := make(map[byte]string, 1)
	binString := ""
	var charBuffer []byte
	var nodeArray []*huffmanNode
	filepipe, _ := os.Open(filename)
	fileInfo, _ := os.Stat(filename)
	inputFileLength := fileInfo.Size()
	charBuffer = make([]byte, fileInfo.Size())
	filepipe.Read(charBuffer)
	fmt.Print("Preparing...")
	for _,char := range charBuffer{
		count, exist := bucket[char];
		if exist{
			bucket[char] = count+1
		}else{
			bucket[char] = 1
		}
	}
	fmt.Print("OK\nBuilding node...")
	for key, value := range bucket{
		nodeArray = append(nodeArray,&huffmanNode{
			nodeChar:key,
			weight:value,
			leftNode:nil,
			rightNode:nil,
		})
	}
	fmt.Print("OK\nBuilding tree...")
	parentNode:=buildTree(nodeArray)
	fmt.Print("OK\nMap key with binary code...")
	fmt.Print("OK\n")
	fmt.Printf("Output File:")
	fmt.Scanf("%s ",&outputFile)
	file,_ := os.Create(outputFile)
	flattenStr := ""
	flatTree(parentNode,"",&flattenStr)
	flattenStr += "****"
	file.WriteString(flattenStr)
	pathTarversal(parentNode,"",&keyMap)
	for index,char := range charBuffer{
		binString += keyMap[char]
		if (len(binString) >= 8){
			character,_ := strconv.ParseInt(binString[0:8],2,32)
			file.Write([]byte{byte(character)})
			binString = binString[8:]
		}
		fmt.Printf("\rEncoding... %d%%", index*100/len(charBuffer))
	}
	fmt.Print("OK\n")
	file.Close()
	fileInfo,_ = os.Stat(outputFile)
	fmt.Printf("Compressed from %d -> %d",inputFileLength,fileInfo.Size())
}