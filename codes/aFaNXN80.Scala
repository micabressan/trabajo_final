import akka.typed.{ActorRef, ActorSystem, Behavior, Signal}
import akka.typed.scaladsl.Actor
import akka.typed.scaladsl._
import akka.typed.scaladsl.AskPattern._

import scala.concurrent.{Await, Future}
import scala.concurrent.duration._

object Counter {
  sealed trait Message
  case class Inc(i: Int = 1) extends Message
  case class IncrementAndGet(i: Int, replyTo: ActorRef[Count]) extends Message
  case class Get(replyTo: ActorRef[Count]) extends Message

  case class Count(i: Int)
}

import Counter._

class Counter extends Actor.MutableBehavior[Message] {

  var count: Int = 0

  override def onMessage(msg: Message) = {
    msg match {
      case Inc(i) => count += i
      case Get(replyTo) => replyTo ! Count(count)
      case IncrementAndGet(i, replyTo) =>
        count += i
        replyTo ! Count(count)
    }

    this
  }
}

val mySystem: ActorSystem[Message] = ActorSystem(new Counter, "mySystem")

def counter: ActorRef[Message] = mySystem

counter ! Inc()
counter ! Inc(5)

import scala.concurrent.ExecutionContext.Implicits.global

val r: Future[Count] = counter ? (IncrementAndGet(1, _))


Await.ready(mySystem.terminate(), 15.seconds)