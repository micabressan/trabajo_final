  def mkGraph2[A](orig:A, getNs:A=>Seq[A]):Graph[A] = {
    val seen = mutable.Map[A,Graph[A]]()
    def innerMk(o:A): Graph[A] = {
      val result = ArrayBuffer[Graph[A]]()
      for (n <- getNs(o)) {
        if (!seen.contains(n)) {
          val cur = innerMk(n)
          result += cur
        } else {
          val g = seen(n)
          result += g
        }
      }
      val g = Graph(o,result)
      seen(o) = g
      g
    }
    innerMk(orig)
  }