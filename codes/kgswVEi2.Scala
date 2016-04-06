val write = Session().create( "lzUtB_pFvGced4gXgHpkNG9SFJzd-II3F2xJNN1rLdooRexuJthGwPRY8OZtJ5Cr", null, null, false, false, false )

Await.ready( write, Duration.Inf )

Session().get()
    .onComplete {
        case Success( Some( session ) ) ⇒ Log.v( "TEST", "KEYS: " + session.key + " " + session.registration.id )
        case _                    ⇒ Log.v( "TEST", "ERROR" )
    }