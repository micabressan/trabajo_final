def this(newBoard: Board) = {
  this(newBoard.height, newBoard.width)
  for (i <- 0 until width;
       j <- 0 until height
  board(i)(j) = newBoard.board(i)(j)
}