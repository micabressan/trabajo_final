case class InstanceIDListener()
        extends InstanceIDListenerService
        with Service {
    /**
     * Implementing onBind(intent: Intent) to make this service testable
     */
    val binder = LocalBinder()

    override def onBind( intent: Intent ): IBinder = binder

    case class LocalBinder()
            extends Binder {

        def getService(): InstanceIDListener = InstanceIDListener.this
    }

    [...]
}