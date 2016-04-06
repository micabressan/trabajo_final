// zakaj tole dela?

    @Path("/")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public void get(
            @Context final HttpServletRequest req,
            @Suspended final AsyncResponse ar
            ) throws Exception {

        final Timer tm = new Timer();
        ar.setTimeout(5_000, TimeUnit.MILLISECONDS);

        // final ServletContext ctx = req.getServletContext();
        ServletEnvironmentInfo sei = new ServletEnvironmentInfo(req, req.getServletContext());
        ar.resume(sei);
    }

// tole pa vrze exception, da resteasy ne more iz konteksta injectati podatkov?

    @Path("/")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public void get(
            @Context final HttpServletRequest req,
            @Suspended final AsyncResponse ar
            ) throws Exception {

        final Timer tm = new Timer();
        ar.setTimeout(5_000, TimeUnit.MILLISECONDS);

        // final ServletContext ctx = req.getServletContext();
        // ServletEnvironmentInfo sei = new ServletEnvironmentInfo(req, req.getServletContext());
        // ar.resume(sei);

        ServiceUtils.getExecutor().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    ServletEnvironmentInfo sei = new ServletEnvironmentInfo(req, req.getServletContext());
                    ar.resume(sei);
                } catch (Exception e) {
                    log.error("error: {}", e.getMessage());
                    ar.resume(e);
                } finally {
                    log.info("got info in {}", tm);
                }
            }
        });
    }

/**
[2015/08/24 15:07:08.533] pushng-executor-2 ERROR [c.o.p.r.AppInfo]: error: Unable to find contextual data of type: javax.servlet.http.HttpServletRequest
[2015/08/24 15:07:08.537] pushng-executor-2 ERROR [c.o.r.GenericExceptionMapper]: HTTP 500 exception: Unable to find contextual data of type: javax.servlet.http.HttpServletRequest
org.jboss.resteasy.spi.LoggableFailure: Unable to find contextual data of type: javax.servlet.http.HttpServletRequest
        at org.jboss.resteasy.core.ContextParameterInjector$GenericDelegatingProxy.invoke(ContextParameterInjector.java:53) ~[resteasy-jaxrs-3.0.9.Final.jar:na]
        at com.sun.proxy.$Proxy40.getServletContext(Unknown Source) ~[na:na]
        at com.outfit7.pushng.rest.AppInfo$1.run(AppInfo.java:44) ~[classes/:na]
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145) [na:1.7.0_80]
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615) [na:1.7.0_80]
        at com.outfit7.pushng.ServiceUtils$1$1.run(ServiceUtils.java:254) [pushng-core-0.8.5-SNAPSHOT.jar:na]
[2015/08/24 15:07:08.567] pushng-executor-2 INFO  [c.o.p.r.AppInfo]: got info in 35.77 msec (27.96/sec)
*/