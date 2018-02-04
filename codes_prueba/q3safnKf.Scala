def lpolacz(list1:Stream[Int], list2:Stream[Int]):Stream[Int] = {
    (list1, list2) match {
      case (Stream.Empty, Stream.Empty) => Stream.Empty
      case (Stream.cons(v, f), Stream.Empty) => Stream.cons(v, f)
      case (Stream.Empty, Stream.cons(v,f)) => Stream.cons(v, f)
      case (Stream.cons(v1, f1), Stream.cons(v2, f2)) =>
        if (v1 <= v2)
          Stream.cons(v1, lpolacz(f1, Stream.cons(v2, f2)))
        else
          Stream.cons(v2, lpolacz(Stream.cons(v1, f1), f2))
    }
  }