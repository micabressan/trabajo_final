package sMusix.network

import akka.actor.{Actor, ActorSystem, Props}
import akka.http.scaladsl.Http
import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.model.ws.{Message, TextMessage, WebSocketRequest, WebSocketUpgradeResponse}
import akka.stream.ActorMaterializer
import akka.stream.scaladsl.{Flow, Keep, Sink, Source}
import akka.{Done, NotUsed}
import sMusix.{Evaluator, Log}

import scala.concurrent.Future

/**
  * Transmitter provides connection with server
  */
object Transmitter {
	implicit val system: ActorSystem = ActorSystem()
	implicit val materializer: ActorMaterializer = ActorMaterializer()

	import system.dispatcher

	object Rec extends Actor {
		override def receive: Receive = {
			case TextMessage.Strict(msg) =>
				Log.info("Recevied signal " + msg)
				JsonHelper.parseJson(msg) match {
					case None => Log.warn("Could not parse JSON")
					case Some(j) => Evaluator.processOrder(j)
				}
		}
	}

	//	val host = "ws://echo.websocket.org"
	val host = "ws://localhost:6666"

	val sink: Sink[Message, Future[Done]] = Sink.foreachParallel[Message](9)(a => {
		system.actorOf(Props(Rec)) ! a
	})

	val source: Source[Message, NotUsed] = Source(List("{\"command\":\"spammer\"}").map(TextMessage(_)))

	val flow: Flow[Message, Message, Future[WebSocketUpgradeResponse]] =
		Http().webSocketClientFlow(WebSocketRequest(host))

	val (upgradeResponse, closed) =
		source
		.viaMat(flow)(Keep.right) // keep the materialized Future[WebSocketUpgradeResponse]
		.toMat(sink)(Keep.both) // also keep the Future[Done]
		.run()

	val connected: Future[Done.type] = upgradeResponse.flatMap { upgrade =>
		if (upgrade.response.status == StatusCodes.SwitchingProtocols) {
			Future.successful(Done)
		} else {
			throw new RuntimeException(s"Connection failed: ${upgrade.response.status}")
		}
	}

	def recv(): Unit = {
		connected.onComplete(Log.info)
	}

	var i = 0

	def spam(): Unit = {
		//		Log.warn("reult: " + Await.result(send.offer(TextMessage("XD " + i)), 123 seconds))
		i += 1
	}
}