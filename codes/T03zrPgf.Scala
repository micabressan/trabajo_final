val inputList = input.toList
val cycledList = (cycle(inputList) take (inputList.length + 1)).force.toList
val result = cycledList.tail.zip(cycledList).filter(a => a._1 == a._2).map(a => a._1).sum