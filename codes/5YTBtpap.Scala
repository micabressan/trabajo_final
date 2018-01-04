
  private def createUserFromSpotify(c: CreateFromSpotify): Unit = {
    val password = scala.util.Random.alphanumeric.take(10).mkString //todo extract to config
    //todo Implement password sending service
    //Todo - try to remove nasty awaits

    val futRes = passwordSendingService.sendEmailWithPassword(email, password)
    val res = Try(Await.result(futRes, 7 seconds))

    futRes
    res match {
      case Success(_) =>
        persist(
          UserEvent.CreatedFromSpotifyEvent(c.email,
            c.refreshToken,
            c.accessToken,
            BCrypt.hashpw(password, BCrypt.gensalt()),
            TimeProvider.now)
        )(handleEvent)
        deferAsync(None) { _ =>
          sender() ! Done
        }

      case Failure(ex) => sender() ! Status.Failure(ex)
    }
  }