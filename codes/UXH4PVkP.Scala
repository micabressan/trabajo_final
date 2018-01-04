import scalaz.Scalaz._

object Calculator {

  def foldingFunction(list: List[Double], next: String): Option[List[Double]] = (list, next) match {
    case (x :: y :: ys, "*") => ((y * x) :: ys).point[Option]
    case (x :: y :: ys, "+") => ((y + x) :: ys).point[Option]
    case (x :: y :: ys, "-") => ((y - x) :: ys).point[Option]
    case (xs, numString) => numString.parseInt.toOption map {_ :: xs}
  }

  def solveRPN(s: String): Option[Double] = for {
    List(x) <- s.split(' ').toList.foldLeftM(Nil: List[Double]) {foldingFunction}
  } yield x

  def calculationResult(n: String): String = solveRPN(n) match {
    case Some(result) => result.toString
    case None => "EГГОГ"
  }

}