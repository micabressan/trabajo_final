// Scala Implementierung in Anlehnung an die Haskell Version von
// https://github.com/almost/regex-crossword-solver/blob/master/recross.hs

import scala.util.matching.Regex

object HexRegexCrossword {

  // Aufgabe 2
  // 2.1
  type Coords = (Int, Int)
  type Possibilities = List[Char]
  type Hex = List[(Coords, Possibilities)]
  type GameState = (Int, Hex)

  // 2.2
  def validCoords(x: Int, y: Int, size: Int): Boolean = {
    // Eine Koordinate ist gÃ¼ltig, wenn sie im Intervall [-size, size] liegt.
    def ok(i: Int): Boolean = i.abs <= size

    // In dem gegebenen achsenbasierten Koordinatensystem gilt die Bedingung, dass immer x + y + z = 0 gelten muss.
    // Dadurch kann aus x und y die Koordinate z berechnet werden.
    val z = -(x + y)

    // Alle Koordinaten mÃ¼ssen gÃ¼ltig sein.
    ok(x) && ok(y) && ok(z)
  }

  // 2.3
  def allPossibilites(): Possibilities =
    '!' :: '$' :: '?' :: '\\' :: ('A' to 'Z').toList ::: ('0' to '9').toList

  // 2.4
  def startGameState(size: Int): GameState = {
    def startHex(): Hex =
    // Alle Koordinaten-Kombinationen durchprobieren und fÃ¼r die gÃ¼ltigen Koordinaten ein Hex-Feld anlegen.
      (for {
        x <- -size to size
        y <- -size to size
        if validCoords(x, y, size)
      } yield ((x, y), allPossibilites())).toList

    // RÃ¼ckgabewert muss ein GameState-Tuple sein.
    (size, startHex())
  }

  // Aufgabe 3
  // 3.1
  // Eine Variation der in der Aufgabenstellung geforderten simplePrinter-Funktion.
  def simplePrinter(x: Int, y: Int, z: Int, p: Possibilities): String = p.length match {
    case 1 => p.head.toString + " " // das letzte verbleibende Element ausgeben
    case l if l == allPossibilites().length => "* " // noch keine EinschrÃ¤nkung vorgenommen
    case l if l < allPossibilites().length => "+ " // MÃ¶glichkeiten konnten schon eingeschrÃ¤nkt werden
    case _ => "- " // falls keine MÃ¶glichkeiten mehr vorhanden
  }

  // 3.2
  def printGameState(gs: GameState, printer: ((Int, Int, Int, Possibilities) => String)): String = {
    // Hilfsfunktion, die die z-Koordinate berechnet, die verbleibenden MÃ¶glichkeiten abruft und die printer-Funktion aufruft.
    def printCell(x: Int, y: Int): String = {
      val z = -(y + x)
      getPossibilities(x, y, gs) match {
        case None => "" // Wenn das Ergebnis None ist, wurde ein ungÃ¼ltiges Hex-Feld angefragt. Wir ignorieren dies mit einem leeren String.
        case Some(p) => printer(x, y, z, p) // Bei einem gÃ¼ltigen Feld Ã¼bernimmt die printer-Funktion die Bestimmung des Ergebnis-Strings.
      }
    }

    // Hilfsfunktion, die eine Zeile des Hex-Feldes erzeugt:
    // - List.fill(n)(c) erzeugt eine Liste der LÃ¤nge n mit Elementen c. Da die "mittlerste" Zeile die lÃ¤ngste ist und die Koordinaten 0 hat,
    //   kÃ¶nnen wir fÃ¼r jede Zeile darÃ¼ber oder darunter den absoluten Wert der Zeilen-Koordinate nehmen um die Zeilen entsprechen einzurÃ¼cken.
    // - Nach den EinrÃ¼ckungsleerzeichen verwenden wir flatMap um fÃ¼r alle mÃ¶glichen x-Werte der Zeile, den Inhalt Ã¼ber die Hilfsfunktion ausgeben zu lassen.
    //   flatMap sorgt hier dafÃ¼r, dass das Ergebnis schon ein einzelner String ist, den wir Ã¼ber toList zu einer List[Char] wandeln und mit der
    //   EinrÃ¼ckungsliste verbinden kÃ¶nnen.
    // - Zum Schluss wird die List[Char] durch mkString(s) zu einem String zusammengesetzt. Dabei wird zwischen jedem Listenelement der Seperator s
    //   (hier ein Leerzeichen) eingefÃ¼gt.
    def printRow(y: Int): String = (List.fill(y.abs)(' ') ::: (-gs._1 to gs._1).flatMap(printCell(_, y)).toList).mkString(" ")

    // FÃ¼r jede Zeile wird die Zeilen-Hilfsfunktion aufgerufen und die Ergebnis-Liste durch ZeilenumbrÃ¼che zu einem einzigen String zusammengebaut
    (-gs._1 to gs._1).map(printRow).mkString("\n")
  }

  // Rekursive Funktion, die alle Hex-Felder nach den gegebenen Koordinaten durchsucht, und bei Erfolg die mit dem Hex-Feld verbundenen MÃ¶glichkeiten zurÃ¼ckgibt
  // Wenn das gesuchte Feld nicht in dem GameState vorhanden ist, wird None zurÃ¼ckgegeben
  def getPossibilities(x: Int, y: Int, gs: GameState): Option[Possibilities] = gs._2 match {
    case ((a, b), p) :: gss if a == x && b == y => Some(p)
    case (_, _) :: gss => getPossibilities(x, y, (gs._1, gss))
    case _ => None
  }

  // Aufgabe 4
  // 4.1
  def generator[A](el: List[Possibilities]): List[String] = {
    // Hilfsfunktion zum zusammensetzen aller mÃ¶glichen Strings
    // In jedem Schritt der Rekursion wird jedes Element aus der ersten Liste (dem letztendlichen Ergebnis)
    // mit jedem Zeichen des Kopfes der verbleibenden MÃ¶glichkeiten kombiniert.
    def h(ergebnis: List[String], rest: List[Possibilities]): List[String] = rest match {
      case x :: xs => h(for {str <- ergebnis; chr <- x} yield str + chr.toString, xs)
      case _ => ergebnis
    }

    // Initial wir die Funktion mit den MÃ¶glichkeiten fÃ¼r die erste Position (umgewandelt in Strings) und den folgenden Positionen aufgerufen
    h(el.head.map(_.toString), el.tail)
  }

  // 4.2
  // Hier muss nur das Listenfunktional filter mit der gegebenen Funktion matches angewendet werden
  def reducePossibilities(r: Regex, l: List[String]): List[String] = l.filter(matches(r, _))

  // Testet ob ein regulÃ¤rer Ausdruck einen String vollstÃ¤ndig erfasst
  def matches(r: Regex, s: String): Boolean = r.findAllMatchIn(s).exists(_.toString == s)

  // 4.3
  // Aus der Darstellung fÃ¼r Achsen- bzw. WÃ¼rfelkoordinaten https://www.redblobgames.com/grids/hexagons/#coordinates-cube
  // kann die Reihenfolge des Durchlaufens der Koordinaten ermittelt werden.
  // Zum Zusammensetzten kann jeweils eine geschachtelte Listenkomprehension verwendet werden.
  def regexCoordinates(gs: GameState): List[List[Coords]] = {
    val xAxis = for {x <- -gs._1 to gs._1} yield (for {y <- (-gs._1 to gs._1).reverse if validCoords(x, y, gs._1)} yield (x, y)).toList
    val yAxis = for {z <- -gs._1 to gs._1} yield (for {x <- (-gs._1 to gs._1).reverse; y = -(x + z) if validCoords(x, y, gs._1)} yield (x, y)).toList
    val zAxis = for {y <- -gs._1 to gs._1} yield (for {x <- -gs._1 to gs._1; z = -(y + x) if validCoords(x, y, gs._1)} yield (x, y)).toList
    xAxis.toList ::: yAxis.toList ::: zAxis.toList
  }

  // 4.4
  def runIteration(rl: List[Regex], gs: GameState): GameState = {
    def update(x: (List[Coords], Regex), h: Hex): Hex = {
      // Erst werden alle mÃ¶glichen Kombinationen der Zellen zu dem regulÃ¤ren Ausdruck erstellt
      val set: List[String] = generator(x._1.map((c: Coords) => getPossibilities(c._1, c._2, (gs._1, h)).getOrElse(List())))
      // Das Set aller MÃ¶glichkeiten wird dann durch matchen mit dem regulÃ¤ren Ausdruck reduziert
      val rSet: List[String] = reducePossibilities(x._2, set)

      // RÃ¼ckwandeln der Strings in List[Char] fÃ¼r die MÃ¶glichkeiten der einzelnen Zellen.
      // ZunÃ¤chst wird eine leere Liste, die fÃ¼r jede Position eine leere Liste an mÃ¶glichen Chars enthÃ¤lt, angelegt.
      val t: List[List[Char]] = List.fill(x._1.length)(List())
      // Ausgehend von dieser Liste ohne EintrÃ¤ge fÃ¼r die jeweiligen MÃ¶glichkeiten, wird mit fold durch die reduzierte Ergebnisliste gegangen.
      val u = rSet.foldRight(t)((m: String, l: List[List[Char]]) =>
        // Dabei wird der aktuelle String, der fÃ¼r jedes beteiligte Hex-Feld ein mÃ¶gliches Zeichen enthÃ¤lt, durch zip mit der Liste der MÃ¶glichkeiten nach Hex-Feldern verknÃ¼pft.
        // Das Resultat des zip-Aufrufs ist eine Liste von Tupeln (Char, Possibilites)
        m.zip(l).map(ct =>
          // Damit es keine Duplikate fÃ¼r die einzelnen Positionen gibt, wird beim Zusammenfassen der TupeleintrÃ¤ge Ã¼berprÃ¼ft, ob der Char schon in der Liste der MÃ¶glichkeiten existiert.
          if (ct._2.contains(ct._1)) ct._2 else ct._1 :: ct._2).toList)

      // Zum Schluss muss das alte Hex ohne die Hex-Felder, die aktualisiert wurden, kopiert werden.
      // Die aktualisierten Felder werden dann angehÃ¤ngt um ein vollstÃ¤ndiges aktualisiertes Hex zu bekommen.
      h.filter(_ match { case (c, _) => !x._1.contains(c); case _ => false }) ::: x._1.zip(u)
    }

    // Die zunÃ¤chst werden die Koordinatenlisten mit den regulÃ¤ren AusdrÃ¼cken zu einer Liste von Tupeln (Koordinatenliste, regulÃ¤rer Ausdruck) zusammen gezipped.
    // Das aktuelle Hex wird dann kontinuierlich durch den fold mit der update-Funktion und allen regulÃ¤ren AusdrÃ¼cken aktualisiert.
    // Damit das Ergebnis wieder ein GameState ist, muss das Ergebnis zu einem entsprechenden Tupel zusammengesetzt werden.
    (gs._1, regexCoordinates(gs).zip(rl).foldRight(gs._2)(update))
  }

  def main(args: Array[String]): Unit = {
    val g1RegX: List[Regex] = List(
      """[^XRAY]?[CROWN]*$""".r,
      """^[D-F\?][^CAMPED]+""".r,
      """[KIP?\!]*(BU|L|B){1,2}""".r
    )
    val g1RegY: List[Regex] = List(
      """[78NGUA\!E]{2}""".r,
      """(F|^L|Y)?[POWER!]*""".r,
      """[^ZENI$](TA|NG|LE|R)""".r
    )
    val g1RegZ: List[Regex] = List(
      """[FIND]?\$?[LAKME]""".r,
      """[^PESCE]?[POS3]*.""".r,
      """[^OPRES!]+[^STICKO]*""".r
    )
    val g1r = g1RegX ::: g1RegY ::: g1RegZ

    val g1s = startGameState(1)
    println(printGameState(g1s, simplePrinter))
    println(printGameState(runIteration(g1r, g1s), simplePrinter))
  }

}