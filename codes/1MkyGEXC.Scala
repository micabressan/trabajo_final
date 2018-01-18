object TicTacToe extends App {
  Game.start
}

class Desk {

  val desk = Array.fill[Array[Symbol]](3)(Array.fill[Symbol](3)('none))

  override def toString: String =
    "  1 2 3\n" +
      (List("A","B","C").zip(desk.map((a: Array[Symbol]) => a.foldLeft("")((s: String, n: Symbol)
        => s + " " + symStr(n))))).map((l: (String, String)) => l._1 + l._2).map(_ + "\n").reduce(_ + _)

  def getCell(x: Int)(y: Int): (Symbol, Boolean) = {
    val r = desk(x)(y)
    (r, !(r eq 'none))
  }

  def occupied(x: Int)(y: Int): Boolean = getCell(x)(y)._2

  def putP(x: Int)(y: Int)(s: Symbol): Boolean = 
    if (occupied(x)(y)) {
      println(s"$x $y already occupied by ${symStr(getCell(x)(y)._1)}!")
      false
    } else {
      desk(x)(y) = s
      true
    }

  def coordMatch(s: String): ((Int, Int), Boolean) = s.toList match {
    case (row :: line :: Nil) => {
      val x = row match {
        case 'A' => 0
        case 'B' => 1
        case 'C' => 2
        case _ => Int.MinValue
      }
      val y = line.toInt - 49
      ((x, y), if((x + y) >= 0 && y < 3) true else {
        println("Parse error")
        false
      })
    }
    case _ => {
      println("Parse error")
      ((0,0), false)
    }
  }

  def symStr(s: Symbol): String = s match {
    case 'X => "X"
    case 'O => "0"
    case _ => " "
  }

  def put(sign: Symbol): Boolean = {
    val sSign = symStr(sign)
    println(s"TURN FOR $sSign \nChoose place (example: A1):")
    val coords = coordMatch(io.StdIn.readLine)
    if (coords._2) putP(coords._1._1)(coords._1._2)(sign) else false
  }

  def checkWinLine(a: Array[Symbol], s: Symbol): Boolean = a.deep == Array(s,s,s).deep

  def checkRow(a: Array[Array[Symbol]], s: Symbol, i: Int): Boolean = checkWinLine(a.map(_(i)), s)

  def checkDi(a: Array[Array[Symbol]], s: Symbol): Boolean = {

    def loop(xs: Array[Int]): Boolean =
      xs.map((n: Int) => desk(n)(n)).deep == Array(s,s,s).deep

  val indx = (0 to 2).toArray

    loop(indx) || loop(indx.reverse)

  }

  def win(s: Symbol): Boolean =
    desk.map(checkWinLine(_, s)).reduce(_ || _) || (0 to 2).map(checkRow(desk, s, _)).reduce(_ || _) || checkDi(desk, s)

}

object Game {

  def start = {
    val d = new Desk
    loop(d,d,'X)
  }

  def anti(s: Symbol): Symbol = s match {
    case 'X => 'O
    case 'O => 'X
  }

  def loop(desk: Desk, bufferDesk: Desk, sign: Symbol): Unit = {
    val antiSign = anti(sign)
    println(desk)
    if (desk.win(antiSign)) println(s"$antiSign WIN!") else 
    if (bufferDesk.put(sign)) loop(bufferDesk, bufferDesk, anti(sign))
    else loop(desk,desk, sign)
  }

}