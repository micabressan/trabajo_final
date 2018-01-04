#Program allows for user input of any given size array
#Then splits the array to a beginning and end portion
#where a number is then tested by both ends of the array
#to see if contents within the array are either larger
#or smaller than the test number 'x'


#Intro dialogue
puts "How many elements in the array?"
arraySize = gets.to_i
element_array = Array.new


#Loop structure for Array input and size
x = 0
while x < arraySize
	print "Please insert element for spot: ", x+1, "\n"
	array_input = gets.to_i
	element_array.insert(x, array_input)
x+=1
end

#Display Initial Array with index and get testing size
print "Array is: ",element_array, "\n"
print "Array size is ",arraySize, "\n"
print "Partition index is: ", index = (arraySize/2)-1, ", 0 inclusive"
puts ""

#test number to compute with the split array
print "What is the test number to test the array with? \n"
x = gets.to_i
puts""


#Start two nodes at the opposite ends of the array
traverseNode1 = 0
traverseNode2 = arraySize - 1

while (traverseNode1 < index || traverseNode2 > index)
	#beggining to shift to end
	node1 = element_array[traverseNode1]
	#end to shift to beginning
	node2 = element_array[traverseNode2]


	#End node, if node is less than x 
	#then move node to beginning of array, with index and delete original
	#relationalIncrementor allows the head node of the array to increment
	#in relation to the tail node
	if (node2 <= x)
		relationalIncrementor = 1
		print "Ending Node Switch at array position ", (traverseNode2), "\n"
		print "With element contents of: ", node2, "\n"
		element_array.insert(traverseNode1, node2)
		element_array.delete_at(traverseNode2+1)
		print "Ending Node state after move: ", element_array, "\n"
		traverseNode2 -= 1
		
	#if the end node is larger, keep it on the right side of the array
	else
		print "Holding on Ending Node with contents: ", node2, "\n"
		relationalIncrementor = 0 
		traverseNode2 -= 1
		
	end
	

	#Beginning node, if node is greater than x
	#then move node to end of array with given index and delete original
	#relationalIncrementor is used to determine if tail node has moved a
	#segment of data in the current the head node's current location
	if (node1 >= x) 
		print "Beginning Node Switch at array position ", (traverseNode1), "\n"
		print "With element contents of: ", node1, "\n"
		element_array.insert(traverseNode2+2, node1)
		element_array.delete_at(traverseNode1+relationalIncrementor)
		print "Begining node state after move: ", element_array, "\n"
		traverseNode1 += 1
		
	#if the head node is smaller, keep it on the left side of the array
	else
		print "Holding on Beginning node with contents: ", node1, "\n"
		traverseNode1 += 1	
	end


	#print array elements and wait for user input to continue
	puts ""
	puts "Array at current state"
	print element_array, "\n"
	wait = gets
	puts ""
	puts ""
end

puts ""

#user input to end program
print "Press any key to exit..."
end_return=gets