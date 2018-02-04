import java.time.Instant

import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import akka.http.scaladsl.model.{ContentTypes, HttpEntity, HttpMethods, HttpRequest}
import akka.http.scaladsl.server.Route
import akka.http.scaladsl.testkit.ScalatestRouteTest
import org.scalatest.{Matchers, WordSpec}
import spray.json.DefaultJsonProtocol._
import spray.json.RootJsonFormat

import scala.concurrent.ExecutionContextExecutor

class SimpleSchedulerTests extends WordSpec with Matchers with ScalatestRouteTest {

  implicit val scheduleDtoFormat: RootJsonFormat[ScheduleDto] = jsonFormat4(ScheduleDto)
  implicit val scheduleCreateDtoFormat: RootJsonFormat[ScheduleCreateDto] = jsonFormat3(ScheduleCreateDto)

  implicit val executionContext: ExecutionContextExecutor = system.dispatcher

  val schedules = new ScheduleContainer
  val defaultSchedule: ScheduleDto = schedules.saveSchedule(ScheduleCreateDto("* * * ? * * *", Instant.now.toString, Instant.now.plusSeconds(12).toString))
  val route: Route = new ScheduleRoute(schedules).endpoint

  "The service" should {
    "return list of schedules for GET requests to the /schedules path" in {
      Get("/schedules") ~> route ~> check {
        responseAs[List[ScheduleDto]] shouldEqual schedules.fetchSchedules
      }
    }
  }

  "The service" should {
    "return one requested schedule for GET requests to the /schedules/{scheduleId} path" in {
      Get("/schedules/%s".format(defaultSchedule.scheduleId)) ~> route ~> check {
        responseAs[ScheduleDto] shouldEqual defaultSchedule
      }
    }
  }

  "The service" should {
    "create one schedule for POST requests to the /schedules path" in {
      val requestBody = ScheduleCreateDto("0 0 * ? * *", Instant.now.plusSeconds(10).toString, Instant.now.plusSeconds(20).toString);
      val httpEntity = HttpEntity(ContentTypes.`application/json`, scheduleCreateDtoFormat.write(requestBody).compactPrint)
      Post("/schedules", httpEntity) ~> route ~> check {
        val response = responseAs[ScheduleDto]
        response.cron shouldEqual requestBody.cron
        response.start shouldEqual requestBody.start
        response.finish shouldEqual requestBody.finish
        schedules.fetchScheduleById(response.scheduleId).isEmpty shouldEqual false
      }
    }
  }

  "The service" should {
    "delete one schedule for DELETE request to the /schedules/{scheduleId} path" in {
      Delete("/schedules/%s".format(defaultSchedule.scheduleId)) ~> route ~> check {
        val response = responseAs[ScheduleDto]
        response shouldEqual defaultSchedule
        schedules.fetchScheduleById(defaultSchedule.scheduleId).isEmpty shouldEqual true
      }
    }
  }
}