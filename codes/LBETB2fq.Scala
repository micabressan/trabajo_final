import scala.util.parsing.combinator._
import scala.language.postfixOps

object Main {
  def main(args:Array[String]) = {
    val sc = new java.util.Scanner(System.in)

    val input = collection.mutable.ListBuffer[String]()
    while(sc.hasNextLine) {
    	input += sc.nextLine
    }

    HtmlTagParser.parse(input.mkString("\n"))
  }


  // HTML parser
  object HtmlTagParser extends RegexParsers {

  	def element: HtmlTagParser.Parser[Unit] = startTag ~ content ~ endTag ^? ({
  			case (stag ~ _ ~ etag) if stag == etag =>
  		}, _ => "error")
  	
    def startTag = "<" ~> tagName <~ tagAttr <~ ">"
  	
    def endTag = "</" ~> tagName <~ ">"
  	
    def tagName = """[a-zA-Z]+""".r
  	
    def tagAttr = """[^>]*""".r
  	
    def content = ("""[^<]*""".r ~ element)*

  	def parse(str: String) = parseAll(element, str) match {
  		case NoSuccess(_, next) => println(next.pos.line)
  		case _ =>
  	}
    
  }


  case class Tag(start: String, end: String) {}

}