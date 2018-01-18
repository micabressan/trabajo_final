import akka.actor.{ActorSystem, Props}
import akka.event.Logging
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import spray.can.Http
import spray.http.{HttpRequest, HttpResponse, StatusCodes}
import spray.routing._
import spray.routing.directives.{DebuggingDirectives, LogEntry}

import scala.concurrent.duration._

//noinspection ScalaStyle
object hello extends App {
  implicit val system = ActorSystem("my-system")
  implicit val timeout: Timeout = Timeout(20.seconds)

  def requestMethodAndResponseStatusAsInfo(req: HttpRequest): Any => Option[LogEntry] = {
    case res: HttpResponse =>
      Some(LogEntry(req.method + ":" + res.message.status, Logging.InfoLevel))
    case _ =>
      None // other kind of responses
  }

  var wrapper = DebuggingDirectives.logRequestResponse(requestMethodAndResponseStatusAsInfo _)

  IO(Http)(system) ask Http.Bind(
    listener = system.actorOf(
      Props(
        new MyService()
      ),
      "root"
    ),
    interface = "0.0.0.0",
    port = 8080
  )

  class MyService extends HttpServiceActor {

    implicit val specificExceptionHandler = ExceptionHandler {
      case e: NoSuchElementException =>
        ctx => ctx.complete(StatusCodes.NotFound)
      case e: IllegalArgumentException =>
        ctx => ctx.complete(StatusCodes.BadRequest)
      case e: UnsupportedOperationException =>
        ctx => ctx.complete(StatusCodes.NotImplemented)
      case other =>
        ctx => {
          println("count 500")
          ctx.complete(StatusCodes.InternalServerError)
        }
    }

    implicit val rs: RoutingSettings = RoutingSettings.default(system)

    def receive = runRoute {
      wrapper {
        path("hello") {
          get {
            complete {
              throw new IllegalStateException("hello ")
            }
          }
        }
      }
    }
  }
}