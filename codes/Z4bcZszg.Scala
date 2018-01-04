///////////////////////////////////////////// Nix lösning3333
package tictactoe

class FastOptimalPlayer(name: String, pType: Int) extends Player(name: String, pType: Int) {


  val boardCache = scala.collection.mutable.Map.empty[String, Int]
  evalBoards(Array.fill(9)(0),0,-pType)

  def hash(game: Array[Int]): String = {
    game.mkString
  }

  /**
    * Returns the best move the player has.
    */

  def move(game: Array[Int], depth: Int): Int =  {
    println(name + ": ")
    boardCache(hash(game))
  }

  def move2(game: Array[Int], depth: Int): Int =  {
    var move = -1

    for (i <- game.indices) {
      if (game(i) == 0) {
        game(i) = pType
        val oppEval = eval(game, depth + 1, -pType)
        if (oppEval == -1) {
          move = i
          game(i) = 0
          return  move
        }
        else if (oppEval == 0) {
          move = i
        }
        game(i) = 0
      }
    }
    move
  }

  def eval(game: Array[Int], depth: Int, who: Int): Int = {
    if (gameWon(game, -who)) return -1
    if (depth == 9) return 0
    var min = 1
    for (i <- 0 until 9) {
      if (game(i) == 0) {
        game(i) = who
        val score = eval(game, depth + 1, -who)
        if (score < min) {
          min = score
        }
        game(i) = 0
      }
    }
    -min
  }

  def evalBoards(game: Array[Int], depth: Int, who: Int): Int = {
    if (boardCache.isDefinedAt(hash(game))) {
      return boardCache(hash(game))
    }

    if (gameWon(game, -who)) return -1
    if (depth == 9) return 0
    var min = 1
    for (i <- 0 until 9) {
      if (game(i) == 0) {
        game(i) = who
        val score = evalBoards(game, depth + 1, -who)
        if (score < min) {
          min = score
        }
        game(i) = 0
      }
    }
    val bestMove = move2(game, depth)
    boardCache += (hash(game) -> bestMove)
    -min
  }
}




/////////////////////////////////////////////////////
Här är min

package tictactoe

class FastOptimalPlayer2(name: String, pType: Int) extends Player(name: String, pType: Int) {


  val boardCache = scala.collection.mutable.Map.empty[String, Int]
  evalBoards(Array.fill(9)(0),0,-pType)

  def hash(game: Array[Int]): String = {
    game.mkString
  }

  /**
    * Returns the best move the player has.
    */

  def move(game: Array[Int], depth: Int): Int =  {
    println(name + ": ")
    val p = moveBoards(game, depth)
    //println(boardCache)
    p
  }

  /**
    * Methods to evaluate all possible boards and turns
    */

  def moveBoards(game: Array[Int], depth: Int): Int =  {
    //var move1 = List.empty[Int]
    //var move2 = List.empty[Int]
    var move = -1

    for (i <- game.indices){
      if (game(i) == 0){
        game(i) = pType
        val evaluation = evalBoards(game,depth + 1,-pType)
        if (evaluation == -1){
          //move1 :+= i
          return i
        }
        else if (evaluation == 0){
          //move2 :+= i
          move = i
        }
        game(i) = 0
      }
    }
    move
    //if (move1.nonEmpty) shuffle(move1).head
    //else shuffle(move2).head
  }

  def evalBoards(game: Array[Int], depth: Int, who: Int): Int = {
    if (boardCache.contains(hash(game))) return boardCache(hash(game))

    if (gameWon(game, -who)) return -1
    if (depth == 9) return 0
    var min = 1
    for (i <- game.indices) {
      if (game(i) == 0) {
        game(i) = who
        val score = evalBoards(game, depth + 1, -who)
        if (score < min) {
          min = score
        }
        game(i) = 0
      }
    }
    boardCache += hash(game) -> -min
    -min
  }
}