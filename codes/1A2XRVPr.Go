    go func(svc *NetChannelService) {
        /* FIXME -- find a way of closing this thread once CloseService() is invoked */
        http.HandleFunc(server.PathGate, handleClientRequest)

        if (svc.Flags & FLAG_DEBUG) > 1 {
            util.DebugOut("[+] Handling request for path :" + svc.PathGate)
        }
        if err := http.ListenAndServe(":" + util.IntToString(int(server.Port)),nil); err != nil {
            util.ThrowN("panic: Failure in loading httpd")
        }
    } (server)