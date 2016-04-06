def updateSession( response: Response.Payload[Registration] ): Future[Option[model.Session]] = {
        response match {
            case Response( 201, registration ) ⇒
                Session().update( lens[model.Session] >> 'registration )( registration.to[model.gcm.Registration] )
            case _ ⇒ {
                val (_, body) = response.asInstanceOf[Response]
                report( "Could not register new Gcm token", UnexpectedApiResponse( response
                    .asInstanceOf[Response], body) )
                Future{ None }
            }
        }
    }