case class Document(serial: String, number: String)

def validate(document: Document): Document = document match {
  case Document("", _) => document
  case _ if document.number.nonEmpty => document
  case Document(serial, _) =>
    serial.substring(1).length match {
      case 0 => document
      case 1 | 2 => Document("", serial)
      case _ => Document(serial.substring(0, 3), serial.substring(3))
    }
}
val document = Document("№44Aa5123431", "")
validate(document)