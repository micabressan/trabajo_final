import akka.actor._

case class Ball(count: Int)

object Main {
  def main(args: Array[String]): Unit = {
    val actorSystem = ActorSystem("MySystem")
    val player1 = actorSystem.actorOf(Props(new Player))
    val player2 = actorSystem.actorOf(Props(new Player))

    player1.tell(Ball(5), player2)
  }
}

import akka.actor.Actor

class Player extends Actor {
  def receive = {
    case Ball(0) => context.system.terminate()
    case Ball(count) =>
      require(count > 0)
      if (count % 2 == 0) print("ping\n") else print("pong\n")
      sender ! Ball(count - 1)
  }
}



================================


import akka.actor._

import scala.collection.mutable.ArrayBuffer

case class Ball(count: Int)

object Main {
  def main(args: Array[String]): Unit = {
    val actorSystem = ActorSystem()
    val players = ArrayBuffer[ActorRef]()
    val player0 = actorSystem.actorOf(Props(classOf[Player], 0, players))
    val player1 = actorSystem.actorOf(Props(classOf[Player], 1, players))
    val player2 = actorSystem.actorOf(Props(classOf[Player], 2, players))

    players += player0 += player1 += player2

    player0 ! Ball(0)
  }
}

import akka.actor.{Actor, ActorRef}

import scala.collection.mutable.ArrayBuffer
import scala.util.Random

class Player(val num: Int, val players: ArrayBuffer[ActorRef]) extends Actor {
  val random = new Random()

  def receive = {
    case Ball(count) =>
      var nextPlayerIdx = random.nextInt(players.length)
      while (nextPlayerIdx == num) nextPlayerIdx = random.nextInt(players.length)
      println("Player " + num + " recieved throw number: " + count + ". Throwing to " + nextPlayerIdx + ". Throw number " + (count + 1))
      Thread.sleep(1000)
      players(nextPlayerIdx) ! Ball(count + 1)
  }
}