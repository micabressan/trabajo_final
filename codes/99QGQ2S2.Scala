object Main {
  def main(args: Array[String]): Unit = {
    var s = scala.io.Source.fromFile("krypto.txt", "UTF-8").getLines.mkString("\n")
    println(deCrypt(s))
  }

  def deCrypt(s: String): String = {
    //skapa en samling av Ints
    val xs = s.filterNot(x => x == ' ' || x == '\n').split(",").map(_.toInt)

    // konvertera till ascii
    for (x <- xs.length - 2 to 0 by -1) xs(x) -= xs(x + 1)

    // skicka tillbaka strängen
    xs.map(_.toChar).mkString
  }
}