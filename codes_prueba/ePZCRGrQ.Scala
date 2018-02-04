val numbers = ('0'.toInt to '0'.toInt + 9).map(_.toChar)

case class Document(serial: String, number: String)

def validate(document: Document): Document = {
  if (document.serial.nonEmpty) { //Presuming that serial starts with № and contains only numbers and letters
    val serial = document.serial.substring(1)
    val numberOccurrences = serial.count(symbol => numbers.contains(symbol))
    val letterOccurrences = serial.length - numberOccurrences
    if (numberOccurrences > 0 && serial.length - numberOccurrences > 0) {
      if (numberOccurrences + letterOccurrences > 2) {
        val letterIndex = serial.indexWhere(symbol => !numbers.contains(symbol)) + 1
        val numberIndex = serial.indexWhere(symbol => numbers.contains(symbol)) + 1
        val largerIndex = if (letterIndex > numberIndex) letterIndex else numberIndex
        Document(document.serial.substring(0, largerIndex + 1), document.serial.substring(largerIndex + 1))
      }
      else if (numberOccurrences + letterOccurrences < 3)
        Document("", document.serial)
      else document
    } else document
  } else document
}
val doc = Document("№44Aa5123431", "")
validate(doc)