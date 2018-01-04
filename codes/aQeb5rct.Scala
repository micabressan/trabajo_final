  def deCrypt(s: String): String = {
    //skapa en samling av Ints
    val xs = s.filterNot(x => x == ' ' || x == '\n').split(",").map(_.toInt)

    // konvertera till ascii
    for (x <- xs.length - 2 to 0 by -1) xs(x) -= xs(x + 1)

    // skicka tillbaka strängen
    xs.map(_.toChar).mkString
  }