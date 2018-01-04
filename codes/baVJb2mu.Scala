package dieTest

import akka.actor.{Supervisor, Actor}
import akka.actor.Actor._
import akka.config.Supervision._
import akka.util.duration._

object Main {
  private val dieWindow = 10.minutes.toMillis.toInt
  private val sleepTime = 1.second.toMillis

  private def sleep() {
    Thread.sleep(sleepTime)
  }

  def main(args: Array[String]) {
    val configPermanent: SupervisorConfig = SupervisorConfig(
      AllForOneStrategy(List(classOf[Exception]), 10, dieWindow),
      List(
        Supervise(actorOf[AlwaysDies], Permanent)
      )
    )

    val configTemporary: SupervisorConfig = SupervisorConfig(
      AllForOneStrategy(List(classOf[Exception]), 10, dieWindow),
      List(
        Supervise(actorOf[AlwaysDies], Temporary)
      )
    )


    def testFor(testType: String) {
      println(
        """|####################
           |# Running the test #
           |####################
           |
           |  Test type: %s
           |
           |""".stripMargin.format(testType))
    }


    testFor("Permanent")
    runTest(configPermanent)

    println("\n\n")

    testFor("Temporary")
    runTest(configTemporary)

    registry.shutdownAll()
  }


  def runTest(conf: SupervisorConfig) {
    println("Pre-start")

    sleep()

    println("Starting")
    val supervisor = Supervisor(conf).start
    println("Started")

    sleep()

    println("Sending msg")
    registry.actorFor[AlwaysDies] ! true
    println("Sent")

    sleep()

    println("Re-sending")
    try {
      registry.actorFor[AlwaysDies] ! true
    } catch {
      case _ ⇒ println("Nope didn't restart")
    }

    sleep()

    println("Shut'er down")
    supervisor.shutdown()
  }
}


class AlwaysDies extends Actor {
  def receive = {
    case _ ⇒ throw new RuntimeException("Actor going down!")
  }

  override def preStart() {
    println("Actor starting up")
    println("    My fault handler is: " + self.faultHandler)
  }

  override def preRestart(reason: Throwable) {
    println("    Actor is restarting now")
  }
}