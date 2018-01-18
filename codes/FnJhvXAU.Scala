package ru.yandex.vertis.statistics.datamart

import akka.actor.{ActorSystem, Props}
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import com.codahale.metrics.MetricRegistry
import ru.yandex.common.monitoring.graphite.GraphiteReporterEnabler
import ru.yandex.util.spray.monitoring.MonitoringDirectives
import ru.yandex.vertis.statistics.app.AppDependencies.metricsRegistry
import ru.yandex.vertis.statistics.app.control.Metered
import ru.yandex.vertis.statistics.app.{AppDependencies, Environment}
import spray.can.Http
import spray.http.{HttpRequest, HttpResponse, StatusCodes}
import spray.routing._
import spray.routing.directives.LogEntry

import scala.concurrent.ExecutionContext
import scala.concurrent.duration._

//noinspection ScalaStyle
object hello extends App with Metered with MonitoringDirectives{

  override def marker: String = "hello"

  override def metricRegistry: MetricRegistry = AppDependencies.metricsRegistry

  override def serviceName: String = "hello"

  override implicit val ec: ExecutionContext = AppDependencies.auxiliaryExecutor
  implicit val system = ActorSystem("my-system")
  implicit val timeout: Timeout = Timeout(20.seconds)

  def requestMethodAndResponseStatusAsInfo(req: HttpRequest): Any => Option[LogEntry] = {
    case res: HttpResponse =>
      res.message.status.intValue match {
        case so if so % 100 == 2 => response2xxCounter.mark()
        case so if so % 100 == 4 => response4xxCounter.mark()
        case so if so % 100 == 5 => response5xxCounter.mark()
        case _ =>
      }
      println(res.message.status.intValue)
      None
    case e =>
      println(e.getClass.getCanonicalName)
      println("other")
      None // other kind of responses
  }

  var wrapper = monitorRoute(requestMethodAndResponseStatusAsInfo _)

  val response5xxCounter = meter("received 5xx")
  val response2xxCounter = meter("received 2xx")
  val response4xxCounter = meter("received 4xx")

  GraphiteReporterEnabler.enable(
    metricsRegistry,
    "hello_from_my_dev",
    Environment.hostName)


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
          println("hadled")
          response5xxCounter.mark()
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
        } ~
          path("hi") {
            get {
              complete {
                "hello"
              }
            }
          }
      }
    }
  }

}