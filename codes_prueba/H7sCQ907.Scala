  val sums: Signal[(Vector[Int], Vector[Int])] = Signal{
    var rowSum : Vector[Int] = Vector.empty[Int]
    var colSum : Vector[Int] = Vector.empty[Int]
    for(hor <- 0 to 2){
      var tmp = 0
      var tmp2 = 0
      for (ver <- 0 to 2){
        tmp += cells(ver)(hor).value()
        tmp2 += cells(hor)(ver).value()
      }
      colSum = colSum :+ tmp
      rowSum = rowSum :+ tmp2
    }
    (rowSum, colSum)
  }