  def eval(expr: Expression): Int = {
 
	def toInt(b: Boolean): Int = if(b) 1 else 0
  
	def toBool(i: Int): Boolean = i != 0
	
 	expr match{
 		case Var(varID) => getVar(varID)
 		case IntLiteral(value) => value
 		case Plus(lhs, rhs) => eval(lhs) + eval(rhs)
 		case Minus(lhs, rhs) => eval(lhs) - eval(rhs)
 		case Times(lhs, rhs) => eval(lhs) * eval(rhs)
 		case Division(lhs, rhs) => eval(lhs) / eval(rhs)
 		case Modulo(lhs, rhs) => eval(lhs) % eval(rhs)
 		case Equals(lhs, rhs) => toInt(eval(lhs) == eval(rhs))
 		case GreaterThan(lhs, rhs) => toInt(eval(lhs) > eval(rhs))
 		case LessThan(lhs, rhs) => toInt(eval(lhs) < eval(rhs))
    		case And(lhs, rhs) => toInt(toBool(eval(lhs)) && toBool(eval(rhs)))
    		case Or(lhs, rhs) => toInt(toBool(eval(lhs)) || toBool(eval(rhs)))
    		case Neg(expr) => -eval(expr)
    		case Not(expr) => toInt(!toBool(eval(expr)))
	}
  }