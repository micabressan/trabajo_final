@Singleton

public class PoolExecutorEJB {

       private ExecutorService threadPoolExecutor = null;

       int  corePoolSize  =    5;

       int  maxPoolSize   =   10;

       long keepAliveTime = 5000;

       @Resource(name = "DefaultManagedThreadFactory")
       ManagedThreadFactory factory;

       public ExecutorService getThreadPoolExecutor() {

             return threadPoolExecutor;

       }

       @PostConstruct
       public void init() {             

             threadPoolExecutor =  new ThreadPoolExecutor(corePoolSize, maxPoolSize,     

                                  keepAliveTime, TimeUnit.SECONDS,

                                  new ArrayBlockingQueue<Runnable>(10), factory);      

       }

       @PreDestroy
       public void releaseResources() {

             threadPoolExecutor.shutdown();   

       }

}