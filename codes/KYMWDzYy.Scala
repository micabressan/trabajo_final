import java.lang.management.ManagementFactory
import java.util.concurrent.atomic.AtomicInteger

import akka.actor.ActorSystem
import akka.stream.scaladsl.{Sink, Source}
import akka.stream.{ActorMaterializer, ThrottleMode}

import scala.concurrent.duration._
//noinspection ScalaStyle
object kek extends App {

  implicit val system: ActorSystem = ActorSystem("hello")
  implicit val mat: ActorMaterializer = ActorMaterializer()

  println(ManagementFactory.getRuntimeMXBean.getName)
  Thread.sleep(20000)
  val int = new AtomicInteger(0)

  for (i <- 1 to 100000) {
    val ref = Source.actorRef[String](Int.MaxValue, akka.stream.OverflowStrategy.fail)
      .throttle(1, 1.second, 0, ThrottleMode.Shaping)
      .to(Sink foreach {
        st =>
          if (int.incrementAndGet() % 10000 == 0)
            println(st)
      })
      .run()
    ref ! s"hello $i"
    ref ! s"world $i"
    Thread.sleep(10)
  }
}