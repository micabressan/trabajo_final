val listOfPair = List(
  (1, List("a", "b")),
  (1, List("c", "d")),
  (2, List("x"))
)


listOfPair
  .groupBy(_._1)
  .map {
    case (key, listOfKeyValuePair) => 
      (key, listOfKeyValuePair.flatMap(_._2))
  }