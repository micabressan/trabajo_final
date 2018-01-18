  val startServiceTask = startService <<= (getPrevious(service), distConfig in Dist) map {
    case (_, conf) => {
      val serviceActor: Actor = (new ServiceActor(conf)).start()
      serviceActor ! Start
      serviceActor
    }
  } keepAs(service)


[error] .sbt/plugins/RunnableProject.scala:57: value map is not a member of (sbt.Project.Initialize[sbt.Task[Option[Option[scala.actors.Actor]]]], sbt.ScopedTask[AkkaKernelPlugin.DistConfig])
[error]   val startServiceTask = startService <<= (getPrevious(service), distConfig in Dist) map {
[error]                                                                                      ^
[error] one error found