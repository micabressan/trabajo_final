import java.time.Instant

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.server.Route
import akka.stream.ActorMaterializer
import spray.json.DefaultJsonProtocol._
import spray.json.RootJsonFormat

import scala.concurrent.{ExecutionContextExecutor, Future}

object SimpleScheduler {

  final case class Schedule(id: Long, cron: String, start: Instant, finish: Instant)

  final case class ScheduleDto(scheduleId: Long, cron: String, start: String, finish: String)

  final case class ScheduleCreateDto(cron: String, start: String, finish: String)

  object ScheduleIdentifier {
    private var idCounter = 0L

    def next(): Long = {
      idCounter += 1
      idCounter
    }
  }

  implicit val system: ActorSystem = ActorSystem("simple-scheduler")
  implicit val materializer: ActorMaterializer = ActorMaterializer()
  implicit val executionContext: ExecutionContextExecutor = system.dispatcher
  implicit val scheduleDtoFormat: RootJsonFormat[ScheduleDto] = jsonFormat4(ScheduleDto)
  implicit val scheduleCreateDtoFormat: RootJsonFormat[ScheduleCreateDto] = jsonFormat3(ScheduleCreateDto)

  var schedules: List[Schedule] = Nil

  def fetchScheduleById(scheduleId: Long): Future[Option[ScheduleDto]] = Future {
    schedules
      .find(p => p.id == scheduleId)
      .map(s => ScheduleDto(s.id, s.cron, s.start.toString, s.finish.toString))
  }

  def fetchSchedules(): List[ScheduleDto] = {
    schedules.map(s => ScheduleDto(s.id, s.cron, s.start.toString, s.finish.toString))
  }

  def saveSchedule(create: ScheduleCreateDto): Future[ScheduleDto] = Future {
    val schedule = Schedule(ScheduleIdentifier.next(), create.cron, Instant.parse(create.start), Instant.parse(create.finish))
    schedules = schedules ::: List(schedule)
    ScheduleDto(schedule.id, schedule.cron, schedule.start.toString, schedule.finish.toString)
  }

  def main(args: Array[String]): Unit = {
    schedules = schedules ::: List(
      Schedule(ScheduleIdentifier.next(), "0 0 10 ? * * *", Instant.now(), Instant.now()),
      Schedule(ScheduleIdentifier.next(), "0 60 * ? * * *", Instant.now(), Instant.now()))

    Http().bindAndHandle(route, "127.0.0.1", 8080)
    println("Akka HTTP server online at http://127.0.0.1:8080/")
  }


  def getAllSchedulesRoute: Route = get {
    path("schedules") {
      complete(fetchSchedules())
    }
  }

  def getOneScheduleByIdRoute: Route = get {
    path("schedules" / LongNumber) { id => {
      val maybeSchedule: Future[Option[ScheduleDto]] = fetchScheduleById(id)
      onSuccess(maybeSchedule) {
        case Some(schedule) => complete(schedule)
        case None => complete(StatusCodes.NotFound)
      }
    }
    }
  }

  def postOneScheduleRoute: Route = post {
    path("schedules") {
      entity(as[ScheduleCreateDto]) {
        schedule => {
          complete(saveSchedule(schedule))
        }
      }
    }
  }

  def route: Route =
    getAllSchedulesRoute ~
      getOneScheduleByIdRoute ~
      postOneScheduleRoute

}