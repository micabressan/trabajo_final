class HttpDeviceMetricsRoutes(val consumerSettings: ConsumerSettings[String, Array[Byte]],
                              implicit val actorSystem: ActorSystem,
                              implicit val actorMaterializer: ActorMaterializer) {

  implicit val timeout = Timeout(15 seconds)

  val latestDeviceMetricActor = actorSystem.actorOf(Props(new LastDeviceMetricActor(consumerSettings, actorMaterializer)))

  val route: Route =
    get {
      path("deviceMetrics" / "disk") {
        parameters("id") { (id) =>
          val future = (latestDeviceMetricActor ? GetLastDeviceMetricRequest(id)).mapTo[GetLastDeviceMetricResponse]

          onComplete(future) {
            case Success(response) => response.metrics.map(m => complete(JsonFormat.toJsonString(m)))
              .getOrElse(complete(HttpResponse(204)))
            case Failure(ex) => complete(ex)
          }
        }
      }
    }
}