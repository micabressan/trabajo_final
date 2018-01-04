import java.io._
import scala.io.Source
import scala.collection._
import util.control.Breaks._

class Person(val Name: String, val Sex: String)

object GEDCOM_Parser{
  
	def GetName(x: Array[String]): String = x.slice(2, x.length).mkString(" ").replaceAll("/", "").trim
	def GetId  (x: Array[String]): String = x(1).substring(2, x(1).length - 1)
	def GetSex (x: Array[String]): String = if (x(2) == "M") "M" else "F"
	def toInt  (x: String       ):    Int = { try { x.toInt } catch { case e: Exception => 0 }}

  def main(args: Array[String]): Unit = {
    
    val filename = "myTree.ged"
    var people   = mutable.Map[Int, Person]()

    var id:   Int     = 0
	  var name: String  = ""

    for (line <- Source.fromFile(filename).getLines) {
        val a = line.split(" ")

        if ( a.size > 2 )
        {
          if ( a(2) == "INDI" ) id = toInt(GetId(a))

          if ( a(1) == "SEX"  ) people += id -> new Person(name, GetSex(a))

          if ( a(1) == "NAME" ) name = GetName(a)
        }
    }
	
    val output       = new PrintWriter(new File("MyFamily.pl"))
    var husb: String = ""
    var wife: String = ""

    for (line <- Source.fromFile(filename).getLines) {
      val a = line.split(" ")

      if ( a(1) == "HUSB" ) husb = ( people( toInt(a(2).substring( 2, a(2).length - 1 )))).Name
      if ( a(1) == "WIFE" ) wife = ( people( toInt(a(2).substring( 2, a(2).length - 1 )))).Name 

      if ( a(1) == "CHIL" )
      {
        val child =  (  people(toInt(a(2).substring(2, a(2).length - 1 )))).Name
        output.write ( "parent(\""+ husb + "\", \""+ child + "\").\n")
        output.write ( "parent(\""+ wife + "\", \""+ child + "\").\n")
      }	
    }

    people.values foreach (x => output.write ("sex(\""+ x.Name + "\", " + x.Sex + ").\n"))
    output.close()
  }
}