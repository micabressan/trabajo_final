case class Document(serial: String, number: String)

def validate(document: Document): Document = document match {
  case Document("", _) => document
  case _ if document.number.nonEmpty => document
  case Document(serial, _) =>
    serial.length match {
      case 1 => document
      case 2 | 3 => Document("", serial)
      case _ => Document(serial.take(3), serial.drop(3))
    }
}