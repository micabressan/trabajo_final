package basic.tutorial

object BetterPascalTriangle {

  def main(args: Array[String]){
    val num = scala.io.StdIn.readInt()

    (0 until num).foreach( n => {

      val row = (0 to n).map( r => {
        factorial(n) / (factorial(r) * factorial(n -r))
      }).mkString(" ")

      println(row)

    })
  }

  def factorial(y: Int): Int = (1 to y).foldLeft(1)(_ * _)
}