implicit val serialization: ((Option[String], Boolean)) => Array[Byte] = {
    case (x, y) => (x.getOrElse("") + y).getBytes		  
}