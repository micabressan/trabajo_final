package projecteulerscala

import scala.collection.mutable.HashMap

object Problem349 extends App {
  val isBlack = HashMap.empty[Tuple2[Int, Int], Boolean]
    
  var (x, y) = (0, 0)
  var direction = 0
  val maxturns = 10 ^^ 7
  var turn = BigInt(0)
  
  type Direction = Int
  
  while (maxturns > turn) {
    // read square
    val _isBlack = !isBlack.contains(x, y) || isBlack(x, y)
    val s = if (_isBlack) "black" else "white"
    
    // flip colour of square
    isBlack += (x, y) -> !_isBlack
    
    // turn counterclockwise if black
    if (_isBlack) direction = (direction + 3) % 4
    else direction = (direction + 1) % 4
    
    val Up = 0
    val Right = 1
    val Down = 2
    val Left = 3
    
    // move
    direction match {
      case Up => y += 1 
      case Down => y -= 1
      case Left => x -= 1
      case Right => x += 1
      case _ => {}
    }
    
    // increment turn
    turn += 1
  }
}