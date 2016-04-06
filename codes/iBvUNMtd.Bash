aruns weblogic_12_c $ ./configure.sh 
**************************************************
WebLogic Server 12g (12.1.3.0) Zip Configuration

MW_HOME:   /home/aruns/weblogic_12_c
JAVA_HOME: /usr/lib/jvm/java-8-oracle/
**************************************************

Please wait while 1 jars are unpacked ...
...Unpacking done                       


BUILD SUCCESSFUL
Total time: 1 second
CLASSPATH=/usr/lib/jvm/java-8-oracle//lib/tools.jar:/home/aruns/weblogic_12_c/wlserver/server/lib/weblogic_sp.jar:/home/aruns/weblogic_12_c/wlserver/server/lib/weblogic.jar:/home/aruns/weblogic_12_c/oracle_common/modules/net.sf.antcontrib_1.1.0.0_1-0b3/lib/ant-contrib.jar:/home/aruns/weblogic_12_c/wlserver/modules/features/oracle.wls.common.nodemanager_2.0.0.0.jar::/usr/lib/jvm/java-8-oracle/bin

PATH=/home/aruns/weblogic_12_c/wlserver/server/bin:/home/aruns/weblogic_12_c/oracle_common/modules/org.apache.ant_1.9.2/bin:/usr/lib/jvm/java-8-oracle//jre/bin:/usr/lib/jvm/java-8-oracle//bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games::/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:/usr/lib/jvm/java-8-oracle/:/home/aruns/weblogic_12_c/oracle_common/modules/org.apache.maven_3.0.5/bin

Your environment has been set.
Configuring WLS...

BUILD SUCCESSFUL
Total time: 1 second
 
Do you want to configure a new domain?  [y/n]? y
Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=256m; support was removed in 8.0
<16 Aug, 2015 5:24:11 PM IST> <Info> <Security> <BEA-090905> <Disabling the CryptoJ JCE Provider self-integrity check for better startup performance. To enable this check, specify -Dweblogic.security.allowCryptoJDefaultJCEVerification=true.> 
<16 Aug, 2015 5:24:11 PM IST> <Info> <Security> <BEA-090906> <Changing the default Random Number Generator in RSA CryptoJ from ECDRBG128 to FIPS186PRNG. To disable this change, specify -Dweblogic.security.allowCryptoJDefaultPRNG=true.> 
<16 Aug, 2015 5:24:16 PM IST> <Info> <WebLogicServer> <BEA-000377> <Starting WebLogic Server with Java HotSpot(TM) 64-Bit Server VM Version 25.51-b03 from Oracle Corporation.> 
<16 Aug, 2015 5:24:21 PM IST> <Info> <Management> <BEA-140013> </home/aruns/weblogic_12_c/user_projects/domains/mydomain/config not found> 
<16 Aug, 2015 5:24:22 PM IST> <Info> <Security> <BEA-090065> <Getting boot identity from user.> 
Enter username to boot WebLogic server:aruns
Enter password to boot WebLogic server:
For confirmation, please re-enter password required to boot WebLogic server:
<16 Aug, 2015 5:24:33 PM IST> <Info> <Management> <BEA-141254> <Generating new domain directory in /home/aruns/weblogic_12_c/user_projects/domains/mydomain.> 
<16 Aug, 2015 5:24:36 PM IST> <Critical> <WebLogicServer> <BEA-000362> <Server failed. Reason: 

There are 1 nested errors:

weblogic.management.ManagementException: Failure during domain creation
	at weblogic.management.internal.DomainGenerator.generateDefaultDomain(DomainGenerator.java:119)
	at weblogic.management.internal.DomainDirectoryService.start(DomainDirectoryService.java:108)
	at weblogic.server.AbstractServerService.postConstruct(AbstractServerService.java:78)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at org.glassfish.hk2.utilities.reflection.ReflectionHelper.invoke(ReflectionHelper.java:1017)
	at org.jvnet.hk2.internal.ClazzCreator.postConstructMe(ClazzCreator.java:388)
	at org.jvnet.hk2.internal.ClazzCreator.create(ClazzCreator.java:430)
	at org.jvnet.hk2.internal.SystemDescriptor.create(SystemDescriptor.java:456)
	at org.glassfish.hk2.runlevel.internal.AsyncRunLevelContext.findOrCreate(AsyncRunLevelContext.java:225)
	at org.glassfish.hk2.runlevel.RunLevelContext.findOrCreate(RunLevelContext.java:82)
	at org.jvnet.hk2.internal.Utilities.createService(Utilities.java:2488)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:98)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:87)
	at org.glassfish.hk2.runlevel.internal.CurrentTaskFuture$QueueRunner.oneJob(CurrentTaskFuture.java:1162)
	at org.glassfish.hk2.runlevel.internal.CurrentTaskFuture$QueueRunner.run(CurrentTaskFuture.java:1147)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)
Caused by: com.oracle.cie.domain.security.InvalidPasswordException: 60455: Invalid password.
60455: The password must be at least 8 alphanumeric characters with at least one number or special character.
60455: Correct the password.
	at com.oracle.cie.domain.DomainInfoHelper.createDefaultDomain(DomainInfoHelper.java:761)
	at com.oracle.cie.domain.DomainInfoHelper.createDefaultDomain(DomainInfoHelper.java:705)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:497)
	at weblogic.management.internal.CIEDomainGenerator.generateDefaultDomain(CIEDomainGenerator.java:62)
	at weblogic.management.internal.DomainGenerator.generateDefaultDomain(DomainGenerator.java:114)
	... 20 more

> 
<16 Aug, 2015 5:24:36 PM IST> <Notice> <WebLogicServer> <BEA-000365> <Server state changed to FAILED.> 
<16 Aug, 2015 5:24:36 PM IST> <Error> <WebLogicServer> <BEA-000383> <A critical service failed. The server will shut itself down.> 
<16 Aug, 2015 5:24:36 PM IST> <Notice> <WebLogicServer> <BEA-000365> <Server state changed to FORCE_SHUTTING_DOWN.> 
<16 Aug, 2015 5:24:36 PM IST> <Info> <WebLogicServer> <BEA-000238> <Shutdown has completed.> 
aruns weblogic_12_c $