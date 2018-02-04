import akka.actor._
import scala.collection.mutable.ArrayBuffer
import scala.util.Random

case class Ball(count: Int)

class Player(val num: Int, players: ArrayBuffer[ActorRef]) extends Actor {
  val random = new Random()
  override def receive = {
    case Ball(counter) =>
      var tmp = random.nextInt(players.length)
      while (tmp == num)
        tmp = Random.nextInt(players.length)
      println("From " + num + " to " + tmp + "; throw ID: " + counter)
      Thread.sleep(400)
      players(tmp) ! Ball(counter + 1)
    case _ =>
      throw new Exception("unhandled msg")
  }
}

object BallGameTest extends App {
  val system = ActorSystem("MySystem")
  var players = ArrayBuffer[ActorRef]()
  val player1 = system.actorOf(Props(classOf[Player], 0, players))
  val player2 = system.actorOf(Props(classOf[Player], 1, players))
  val player3 = system.actorOf(Props(classOf[Player], 2, players))
  players += player1 += player2 += player3
  player1 ! Ball(0)
}