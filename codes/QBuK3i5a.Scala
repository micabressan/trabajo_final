  //because scala can :D
  implicit def Bool2Int(b: Boolean): Int = if (b) 1 else 0
 
  implicit def Expr2Bool(e: Expression): Boolean = eval(e) != 0
 
  implicit def Expr2Int(e: Expression): Int = eval(e)

  //evaluating Expression
  def eval(expr: Expression): Int = expr match {
      case Var(varID) => getVar(varID)
      case IntLiteral(value) => value
      case Plus(lhs, rhs) => lhs + rhs
      case Minus(lhs, rhs) => lhs - rhs
      case Times(lhs, rhs) => lhs * rhs
      case Division(lhs, rhs) => lhs / rhs
      case Modulo(lhs, rhs) => lhs % rhs
      case Equals(lhs, rhs) => lhs == rhs
      case GreaterThan(lhs, rhs) => lhs > rhs
      case LessThan(lhs, rhs) => lhs < rhs
      case And(lhs, rhs) => lhs && rhs
      case Or(lhs, rhs) => lhs || rhs
      case Neg(expr) => -expr
      case Not(expr) => !expr
  }