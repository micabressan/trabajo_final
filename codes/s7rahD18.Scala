/**
  * @author semkagtn
  */
class MySpec
  extends WordSpec
    with Matchers {

  import MySpec._

  case class Point(x: Int, y: Int, tags: Seq[String] = Seq.empty)
  case class Circle(center: Point, radius: Int)

  "circles" should {

    "be correct" in {
      val actual = Seq(
        Circle(Point(1, 2, tags = Seq("tag")), -1),
        Circle(Point(4, -1), 6)
      )
      val expected = Seq(
        Circle(Point(1, 2), 3),
        Circle(Point(4, 5), 6),
        Circle(Point(7, 8), 9)
      )

      actual should smartEqual(expected).ignoreFields("/1/center/y".r)
      // Output:
      // CHANGED /0/radius: -1 != 3
      // REMOVED /2/center/x: 7
      // REMOVED /2/center/y: 8
      // REMOVED /2/radius: 9

      // Без ignoreFields("/1/center/y") было бы:
      // CHANGED /0/radius: -1 != 3
      // CHANGED /1/center/y: -1 != 5
      // REMOVED /2/center/x: 7
      // REMOVED /2/center/y: 8
      // REMOVED /2/radius: 9
    }
  }
}