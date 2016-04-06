trait Parser extends RegexParsers with PackratParsers {
  import LambdaAST._
  
    lazy val identifier:PackratParser[String]  = 
      """[a-zA-Z]+""".r ^^ {_.toString}
    
    lazy val TERM:PackratParser[Term] = LABSTR | APP | ID | PEXPR
    
    lazy val PEXPR:PackratParser[Term] = "(" ~> TERM <~ ")" ^^ 
      { term => term }
      
    lazy val ID:PackratParser[Id] = 
      identifier ^^ Id
    
    lazy val LABSTR:PackratParser[Abstraction] = 
      ID ~ "." ~ TERM ^^
        { case id ~ _ ~ term => Abstraction(id,term) }
    
    lazy val APP:PackratParser[Application] = 
      TERM ~ TERM ^^
        { case t1 ~ t2 => Application(t1,t2) }
    
    lazy val FUNC:PackratParser[Func] = 
      ID ~ ID ~ "=" ~ TERM ^^
      { case name ~ arg ~ "=" ~ body => 
        Func(name,arg,body) } 
}


object LambdaAST {
  
  abstract trait Term 
  case class Id(id:String) extends Term
  case class Abstraction(id:Id,body:Term) extends Term
  case class Application(left:Term,right:Term) extends Term
  case class Func(name:Id,arg:Id,rhs:Term) extends Term
  
}