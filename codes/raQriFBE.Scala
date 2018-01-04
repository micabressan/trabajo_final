def lrepeat(stream:Stream[Int]):Stream[Int] = {
  def helper(reps:Int, rest:Stream[Int]):Stream[Int] = (reps, rest) match {
    case (_, Stream.Empty) => Stream.Empty
    case (0, h #:: tail) => {
      helper(h + 1, tail)
    }
    case (_, head #:: _) => head #:: helper(reps - 1, rest)
  }
  val (h #:: tail) = stream
  helper(h, stream)
}

lrepeat: (stream: Stream[Int])Stream[Int]


val result1 = lrepeat(Stream(1, 2, 3, 4, 5)) force
result1: scala.collection.immutable.Stream[Int] = Stream(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)