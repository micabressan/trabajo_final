case class Point(x: Int, y: Int)

trait Rectangular {

  def topLeft: Point
  def bottomRight: Point

  def left = topLeft.x
  def right = bottomRight.x

  def top = topLeft.y
  def bottom = bottomRight.y

  def width = right - left
  def high = top - bottom

}

class Rectangle(val topLeft: Point, val bottomRight: Point) extends Rectangular {
  def area(): Int = high * width
}

val rec = new Rectangle(Point(1, 5), Point(4, 1))
rec.area()