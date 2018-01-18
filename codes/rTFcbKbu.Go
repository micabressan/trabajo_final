	hitResult := make([]chan int, boards)
	dartsSend := make([]chan int, boards)

	//For each value in the slices, create a channel of coordinate struct type for xyValues, or integer for hitResult
	for i := range hitResult {
		hitResult[i] = make(chan int)
		dartsSend[i] = make(chan int)
	}

	//Create a time object of the current time for measurement
	startTimer := time.Now()

	//Launch the go routines for each board with corresponding channels
	for i := 0; i < boards; i++ {
		go DartBoard(i, dartsSend[i], hitResult[i])
		dartsSend[i] <- (dartsNumber / boards)
	}

	// Send darts to the dartboards here???

	for dartsThrown = 0; dartsThrown < dartsNumber; {
		dartsThrown++
		select {
		case count := <-hitResult[0]:
			totalCount += count
		// DART BOARD 1
		case count := <-hitResult[1]:
			totalCount += count
		// DART BOARD 2
		case count := <-hitResult[2]:
			totalCount += count
		}
	}