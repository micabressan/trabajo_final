package o1.sananmuunnos

object SanaTest extends App{
  
  val muunnosTests = Map[String, String](
    "henri kontinen" -> "konri hentinen",
    "tarja halonen" -> "harja talonen",
    "frakki kontti" -> "kokki frantti",
    "ovi kello" -> "kevi ollo",
    "haamu kontti" -> "koomu hantti",
    "hauva kontti" -> "kouva hantti",
    "puoskari kontti" -> "kooskari puntti",
    "köyhä kontti" -> "kouha köntti",
    "hauva läähättää" -> "läyvä haahattaa",
    "frakki stressi" -> "strekki frassi",
    "äyskäri kontti" -> "kouskari äntti",
    "hattu sfääri" -> "sfätty haari",
    "ovi silmä" -> "sivi olma",
    "haamu prätkä" -> "präämy hatka",
    "puoskari sfääri" -> "sfäöskäri puuri",
    "puoskari äyskäri" -> "äöskäri puuskari"
  )
  
  val toStringTests = Map[String, String](
    "struuma" -> "str|uu|ma",
    "alku" -> "|a|lku"
    
  )
  
  val testCases = muunnosTests.size + toStringTests.size
  var passed = 0
  
  muunnosTests.foreach(pair => {
    val muunntettavat = pair._1.split(" ")
    val muunnettu = Sana.muunnos(muunntettavat(0), muunntettavat(1))
    if ( pair._2.equals(muunnettu) ) passed += 1
    else println(s"'${muunnettu}'  does not equal  '${pair._2}'")
  })
  
  println("\nTesting toString method")
  
  toStringTests.foreach(pair => {
    val muunnettu = new Sana(pair._1).toString()
    if ( pair._2.equals(muunnettu) ) passed += 1
    else println(s"'${muunnettu}'  does not equal  '${pair._2}'")
  })
  
  println (s"Tests passed: $passed/$testCases")
  
}