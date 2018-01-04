package projecteulerscala

import scala.collection.mutable.HashMap

object Problem349 extends App {
  // map: (x, y) -> isBlack
  val grid = HashMap.empty[Tuple2[Int, Int], Boolean]

  var (x, y) = (0, 0)
  var direction = 0
  val maxturns = 10 ^^ 18
  var turn = BigInt(0)
  val distance = 10000
  
  var turnsSkipped = BigInt(0)
  var blacksSkipped = BigInt(0)

  var lastx = 0
  var amounts: List[BigInt] = Nil
  var turns: List[BigInt] = Nil

  while (maxturns > turn) {
    // read square
    val isBlack = (!grid.contains(x, y)) || grid(x, y)

    // flip colour of square
    grid += (x, y) -> !isBlack

    // turn counterclockwise if black
    if (isBlack) direction = (direction + 3) % 4
    else direction = (direction + 1) % 4

    // move
    direction match {
      case 0 => y += 1 // Up
      case 1 => x += 1 // Right
      case 2 => y -= 1 // Down
      case 3 => x -= 1 // Left
    }

    // increment turn
    turn += 1

    // count the map
    if ((lastx - x).abs == distance) {
      var black = count()

      logCounted(black, turn, x)

      // searching for a period
      if (turnsSkipped == 0) {
        var period = 1
        var i = 0
        var isPeriod = false
        while (period < amounts.size / 3 && !isPeriod) {
          isPeriod = true
          while (i < period && isPeriod) {
            isPeriod = 
              amounts(i) - amounts(i + period) == amounts(i + period) - amounts(i + 2 * period) &&
              turns(i) - turns(i + period) == turns(i + period) - turns(i + 2 * period)
            i += 1
          }
          if (!isPeriod) { 
            period += 1
            i = 0
          }
        }

        if (isPeriod) { // period found
          val blacksPerPeriod = amounts(0) - amounts(period)
          val turnsPerPeriod = turns(0) - turns(period)

          val periodsToSkip = (maxturns - turn) / turnsPerPeriod
          turnsSkipped = periodsToSkip * turnsPerPeriod
          blacksSkipped = periodsToSkip * blacksPerPeriod

          println()
          println("Period of " + blacksPerPeriod + " blacks in " + turnsPerPeriod + " turns found at turn " + turn + ".")
          println("Skipping : " + turnsSkipped + " turns (or " + periodsToSkip + " periods)")
          println("Skipping : " + blacksSkipped + " blacks")
          println()
          
          turn += turnsSkipped
        }
      }
    }
  }

  println("turn: " + turn + ", sum: " + (count() + blacksSkipped))
  
  def count() = {
    var sum = BigInt(0)
    val keys = grid.keySet
    for ((_x, _y) <- keys if grid(_x, _y)) {
      sum += 1
    }
    sum
  }
  
  def logCounted(black: BigInt, turn: BigInt, x: Int) {
    amounts ::= black
    turns ::= turn
    lastx = x
    
    print("(" + x + ", " + y + ") ")
    if (turns.size == 1) println("Counted " + black + " black tiles on turn " + turn + ".")
    else println("Counted " + black + " black tiles on turn " + turn + ", " + (turn - turns(1)) + " turns since last clear.")
  }
}