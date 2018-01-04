import akka.actor._
import com.typesafe.config.ConfigFactory

import scala.language.postfixOps

object Test {

  /**
    * Generates message flow to fill B's mailbox
    */
  class A extends Actor {

    private val b = context.actorOf(Props(new B).withDispatcher("actor-b").withMailbox("actor-b-mailbox"), "B")

    override def receive: Receive = {
      case "START" =>
        for(i <- 1 to 100000) b ! "MESSAGE"
        println(s"${context.dispatcher}: Done")
    }
  }

  /**
    * Watching for C
    */
  class B extends Actor {

    private val c = context.actorOf(Props(new C).withDispatcher("actor-c"), "C")
    context.watch(c)

    private var isCAlive = true

    override def receive: Receive = {

      case Terminated(ref) =>
        println(s"${context.dispatcher}: Received death message from $ref")
        isCAlive = false

      case other =>
        if(isCAlive) {
          Thread.sleep(1000)
          c ! other
        }

    }
  }

  /**
    * Are going to die
    */
  class C extends Actor {

    private var counter = 0

    override def receive: Receive = {
      case other =>
        counter += 1
        println(s"${context.dispatcher}: $other #$counter")
        if(counter >= 10) self ! PoisonPill
    }
  }


  def main(args: Array[String]): Unit = {

    val config = ConfigFactory.parseString(
      """
        |actor-b {
        |  type = "PinnedDispatcher"
        |  executor = "thread-pool-executor"
        |}
        |actor-b-mailbox {
        |  mailbox-type = "akka.dispatch.BoundedMailbox"
        |  mailbox-capacity = 10
        |  mailbox-push-timeout-time = -1s
        |}
        |actor-c {
        |  type = "PinnedDispatcher"
        |  executor = "thread-pool-executor"
        |}
      """.stripMargin)

    val system = ActorSystem("TestSystem", config)

    val a = system.actorOf(Props(new A), "A")

    a ! "START"

  }

  /*
  Dispatcher of actor B is blocked:

  "TestSystem-actor-b-6" #18 prio=5 os_prio=0 tid=0x00007fe40c01f000 nid=0x21a waiting on condition [0x00007fe471b2a000]
   java.lang.Thread.State: WAITING (parking)
        at sun.misc.Unsafe.park(Native Method)
        - parking to wait for  <0x0000000771e18178> (a java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject)
        at java.util.concurrent.locks.LockSupport.park(LockSupport.java:175)
        at java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.await(AbstractQueuedSynchronizer.java:2039)
        at java.util.concurrent.LinkedBlockingQueue.put(LinkedBlockingQueue.java:350)
        at akka.dispatch.BoundedQueueBasedMessageQueue$class.enqueue(Mailbox.scala:529)
        at akka.dispatch.BoundedMailbox$MessageQueue.enqueue(Mailbox.scala:672)
        at akka.dispatch.Mailbox.enqueue(Mailbox.scala:85)
        at akka.dispatch.Dispatcher.dispatch(Dispatcher.scala:54)
        at akka.actor.dungeon.Dispatch$class.sendMessage(Dispatch.scala:136)
        at akka.actor.ActorCell.sendMessage(ActorCell.scala:370)
        at akka.actor.Cell$class.sendMessage(ActorCell.scala:291)
        at akka.actor.ActorCell.sendMessage(ActorCell.scala:370)
        at akka.actor.LocalActorRef.$bang(ActorRef.scala:400)
        at akka.actor.ActorRef.tell(ActorRef.scala:124)
        at akka.actor.dungeon.DeathWatch$class.watchedActorTerminated(DeathWatch.scala:76) <-- !!!!!!!! Watch HERE !!!!!!!!!!!
        at akka.actor.ActorCell.watchedActorTerminated(ActorCell.scala:370)
        at akka.actor.ActorCell.invokeAll$1(ActorCell.scala:461)
        at akka.actor.ActorCell.systemInvoke(ActorCell.scala:484)
        at akka.dispatch.Mailbox.processAllSystemMessages(Mailbox.scala:282)
        at akka.dispatch.Mailbox.processMailbox(Mailbox.scala:260)
        at akka.dispatch.Mailbox.run(Mailbox.scala:224)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at java.lang.Thread.run(Thread.java:748)


        DeathWatch.scala:76:
          self.tell(optionalMessage.getOrElse(Terminated(actor)(existenceConfirmed, addressTerminated)), actor) <-- !!!! WTF????

   */


}