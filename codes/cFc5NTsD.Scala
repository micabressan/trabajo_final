//exercise 1

val myList = List("abc","ef","ghij")
myList.foldLeft(0)((sum, value) => sum + value.length)

//exercise 2

import scala.io.Source
import scala.collection.mutable.HashMap

class Censor {
    var theMap = new HashMap[String, String]

    /*in file myfile.txt

    Shoot,Pucky
    Darn,Beans

    */

    for(line <- Source.fromFile("myfile.txt").getLines()) {
        var parts = line.split(",")
        theMap += parts(0) -> parts(1)
    }

    def changeWords(thePhrase : String) = theMap.foldLeft(thePhrase)((output, input) => output.replaceAll(input._1, input._2))

}

class theText(txt: String) extends Censor {
    def original = txt

    def changed = changeWords(txt)
}


val text = new theText("Shoot, I forgot my Darn traits again")
println("Original String: " + text.original)
println("Censored String: " + text.changed)