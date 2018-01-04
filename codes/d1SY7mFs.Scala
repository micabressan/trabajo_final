
/**
  * Created by Szymon - Laptop on 12/12/2017.
  */
import java.util
import java.util.Scanner
object Main {
  def main(args: Array[String]) {
    println("Jaka figure chcesz stworzyc? Podaj numer")
    println("1. Kwadrat")
    println("2. Prostokat")
    println("3. Kolo")
    println("4. Trojkat Rownoboczny")
   val number= scala.io.StdIn.readLine()
    number match {
      case "1" => println("Podaj dlugosc boku kwadratu")
      case "2" => println("Podaj dlugosci boków prostokata")
      case "3" => println("Podaj dlugosc promienia")
      case "4" => println("Podaj dlugosc boku trojkata")
      case _ => "Ty retardzie"
    }
    val line = new java.util.Scanner(System.in)

    number match {
      case "1" => println(new Square(line.nextInt))
      case "2" => println(new Rectangle((line.nextInt),line.nextInt()))
      case "3" => println(new Square(line.nextInt))
      case "4" => println(new Square(line.nextInt))
    }

  }
}

abstract class Figure {
  def area(): Double

  def circuit(): Double

}

  class Square(x:Int) extends Figure{
    val a=x
    override def area: Double = {
      return a*a
    }

    override def circuit: Double = {
      return 4*a
    }
    override def toString() =
      "kwadrat: pole = " + area + " obwód = " + circuit
  }

  class Triangle(x:Int, y:Int, z:Int) extends Figure {
    val a = x
    val b = y
    val c = z

    override def area(): Double = {
      return a * b * c
    }

    override def circuit(): Double = {
      return a + b + c
    }
    override def toString() =
      "trojkat rownoboczny: pole = " + area + " obwód = " + circuit
  }

  class Rectangle(x:Int,y:Int) extends Figure{
    val a=x
    val b=y
    override def area(): Double = {
      return a*b
    }

    override def circuit(): Double = {
      return 2*a+2*b
    }

    override def toString() =
      "prostokat: pole = " + area + " obwód = " + circuit
  }

  class Circle(x:Int) extends Figure{
    val r=x
    override def circuit(): Double = {
      return 2*Math.PI*r
    }

    override def area(): Double = {
      return Math.PI*r*r
    }
    override def toString() =
      "kolo: pole = " + area + " obwód = " + circuit
  }