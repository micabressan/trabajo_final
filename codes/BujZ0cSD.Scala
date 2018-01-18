import akka.actor._
import akka.pattern.ask
import akka.pattern.pipe
import akka.util.Timeout

import scala.concurrent.{Await, Future}
import scala.concurrent.duration._

def main(): Unit = {
  implicit val system = ActorSystem("system")

  import system.dispatcher

  object Counter {
    sealed trait Message
    case class Inc(i: Int = 1) extends Message
    case object Get extends Message
  }

  import Counter._

  class Counter extends Actor {
    var cnt = 0

    override def receive: Receive = {
      case Inc(i) => cnt += i
      case Get => sender() ! cnt
    }
  }
  implicit val timeout = Timeout(5.seconds)

  class Worker(counter: ActorRef) extends Actor {
    def receive: Receive = {
      case "send" =>
        counter ! Inc()
        context.system.scheduler.scheduleOnce(100.millis)(self ! "send")
      case "get" =>
        val cnt = counter ? Get
        cnt.mapTo[Int].pipeTo(sender())
    }
  }

  val counter: ActorRef = system.actorOf(Props(new Counter))
  val worker: ActorRef = system.actorOf(Props(new Worker(counter)))


  worker ! "send"

  Thread.sleep(1000)

  val cnt: Future[Any] = worker ? "get"
  cnt.mapTo[Int].foreach(i => println(s"count: $i"))

  Await.result(cnt, 5.seconds)

  Await.ready(system.terminate(), 5.seconds)
}

main()