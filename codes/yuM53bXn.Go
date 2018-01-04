
const LETTER_OFFSET = 97;


func theJanitor(word string) []int {
    distances := make([]int, 26)
    positions := make([]int, 26)
    
    for wordIndex, value := range word {
        index := value - LETTER_OFFSET
        if distances[index] > 0 {
            distances[index] = wordIndex - positions[index] + 1  
        } else {
            distances[index] = 1
            positions[index] = wordIndex
        }
    }
    
    return distances
}