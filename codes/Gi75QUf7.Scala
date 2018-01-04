object size extends Poly1 {
  implicit def caseInt = at[Int](x => 1)
  implicit def caseString = at[String](_.length)
  implicit def caseTuple[T, U]
    (implicit st : Case.Aux[T, Int], su : Case.Aux[U, Int]) =
      at[(T, U)](t => size(t._1)+size(t._2))
}

scala> size(23)
res4: Int = 1

scala> size("foo")
res5: Int = 3

scala> size((23, "foo"))
res6: Int = 4

scala> size(((23, "foo"), 13))
res7: Int = 5