val numbersAndLetters = ('0'.toInt to '0'.toInt + 9).map(_.toChar) ++
  ('a'.toInt to 'a'.toInt + 25).map(_.toChar)

case class Document(serial: String, number: String)

def validate(document: Document): Document = document match {
  case Document("", _) => document
  case _ if document.number.nonEmpty => document
  case Document(serial, _) =>
    serial.count(symbol => numbersAndLetters.contains(symbol.toLower)) match {
      case 0 => document
      case 1 | 2 => Document("", serial)
      case _ =>
        val firstOccurrenceIndex = serial.indexWhere(symbol => numbersAndLetters.contains(symbol.toLower)) + 1
        val secondOccurrenceIndex = firstOccurrenceIndex + serial.drop(firstOccurrenceIndex).indexWhere(symbol => numbersAndLetters.contains(symbol.toLower)) + 1
        Document(serial.take(secondOccurrenceIndex), serial.drop(secondOccurrenceIndex))
    }
}