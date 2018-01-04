
object Transmitter {
	implicit val system: ActorSystem = ActorSystem()
	implicit val materializer: ActorMaterializer = ActorMaterializer()

	import system.dispatcher

	object Rec extends Actor {
		override def receive: Receive = {
			case TextMessage.Strict(msg) =>
				Log.info("Recevied signal " + msg)
		}
	}

//		val host = "ws://echo.websocket.org"
	val host = "ws://localhost8137"

	val sink: Sink[Message, NotUsed] = Sink.actorRef[Message](system.actorOf(Props(Rec)), PoisonPill)

	val source: Source[Message, NotUsed] = Source(List("XD", "KEK", "LOL", "ROTFL", "LEL") map (TextMessage(_)))


	val flow = Http().webSocketClientFlow(WebSocketRequest(host))

	val (upgradeResponse, closed) =
		source
		.viaMat(flow)(Keep right) // keep the materialized Future[WebSocketUpgradeResponse]
		.toMat(sink)(Keep both) // also keep the Future[Done]
		.run()

	val connected: Future[Done.type] = upgradeResponse.flatMap { upgrade =>
		if (upgrade.response.status == StatusCodes.SwitchingProtocols) {
			Future.successful(Done)
		} else {
			Log.err(s"Connection failed: ${upgrade.response.status}")
			Future.failed(new Exception)
		}
	}

	def recv(): Unit = {
		connected.onComplete(Log.info)
	}
}