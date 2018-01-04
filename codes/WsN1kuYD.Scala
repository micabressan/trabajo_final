case class Document(serial: String, number: String) {
 def normalize: Document = {
    this match {
      case Document(serial, "") if serial.count(_.isLetterOrDigit) <= 2 => Document("", serial)
      case Document(serial, "") => splitSerial(serial)
      case other => other
    }
  }

  private def splitSerial(serial: String): Document = {
    val newSerial = serial.foldLeft("") { (left, char) =>
      if (left.count(_.isLetterOrDigit) < 2) left :+ char else left
    }
    val newNumber = serial.drop(newSerial.length)
    Document(newSerial, newNumber)
  }
}