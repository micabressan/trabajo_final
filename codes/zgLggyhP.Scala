object SwitchableDataProject extends Plugin {
  val DataProject = config("data-project") extend (Runtime)

  val dataProject = SettingKey[Option[ModuleID]]("data-project", "Current data project.")

  def switch = Command.single("switch") { (state, proj) =>
    val extracted: Extracted = Project.extract(state)
    import extracted._
    val resolvedProject = structure.units(currentRef.build).defined(proj)
    val projectRef = ProjectRef(resolvedProject.base, resolvedProject.id)
    val moduleID = (projectID in resolvedProject.id).get(structure.data)

    def f(s: sbt.Setting[_]): sbt.Setting[_] = s.key.key match {
      case dataProject.key => {
        s.asInstanceOf[sbt.Setting[Option[ModuleID]]].mapInit( (_,_) => moduleID)
      }
      case _ => s
    }
    val transformed = session.mergeSettings map(f)

    val newStructure = Load.reapply(transformed, structure)
    val newState = Project.setProject(session, newStructure, state)

    newState
  }

  val distSettings = Seq(
    commands ++= Seq(switch),
    dataProject := None,
    projectDependencies <<= (projectDependencies, dataProject) map { (deps, dp) =>
      dp match {
        case Some(mID) => deps ++ Seq(mID)
        case _ => deps
      }
    }
  )
}