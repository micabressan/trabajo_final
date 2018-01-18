package ru.yandex.vertis.statistics.datamart

import akka.actor.{ActorSystem, Props}
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import ru.yandex.common.monitoring.graphite.GraphiteReporterEnabler
import ru.yandex.util.spray.monitoring.{MonitoringDirectives, StatusMonitoring}
import ru.yandex.vertis.statistics.app.AppDependencies.metricsRegistry
import ru.yandex.vertis.statistics.app.Environment
import ru.yandex.vertis.statistics.datamart.api.monitoring.Monitor
import spray.can.Http
import spray.http.StatusCodes
import spray.routing._

import scala.concurrent.duration._

//noinspection ScalaStyle
object hello extends App {


  implicit val system = ActorSystem("my-system")
  implicit val timeout: Timeout = Timeout(20.seconds)
  GraphiteReporterEnabler.enable(
    metricsRegistry,
    "dev2",
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
          ctx.complete(StatusCodes.InternalServerError)
        }
    }


    implicit val rs: RoutingSettings = RoutingSettings.default(system)

    def receive = runRoute {
      Monitor.countResponseCodesAndRequestTime("hello") {
        path("hello") {
          get {
            complete {
              throw new IllegalStateException("hello ")
            }
          }
        }
      } ~
        Monitor.countResponseCodesAndRequestTime("hi") {
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