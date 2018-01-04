2017-12-28 20:19:07,163 [http-bio-8080-exec-48] ERROR [com.cvicse.hrzcyp.valuation.listener.ValuationInfoPrepareListener] - 数据copy异常:com.cvicse.jr.commons.object.ObjectPersistentException: SQL操作失败
2017-12-28 20:19:07,163 [http-bio-8080-exec-48] ERROR [com.cvicse.workflow.core.event.WorkflowListenerSurport] - null
java.lang.reflect.InvocationTargetException
	at sun.reflect.GeneratedMethodAccessor623.invoke(Unknown Source) ~[?:?]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_131]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_131]
	at com.cvicse.workflow.core.event.WorkflowListenerSurport.fire(WorkflowListenerSurport.java:67) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.event.BasicWorkflowEventBroker.fireWorkItem(BasicWorkflowEventBroker.java:245) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.event.BasicWorkflowEventBroker.fireWorkItemRunner(BasicWorkflowEventBroker.java:240) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.WorkItemRunner.multiGroupAccept(WorkItemRunner.java:626) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.CoreEngine.acceptWorkItem(CoreEngine.java:583) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.CoreEngineAdapter.acceptWorkItem(CoreEngineAdapter.java:99) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.WorkflowEngine.acceptWorkItem(WorkflowEngine.java:386) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.core.DefaultWAPIDecorator.acceptWorkItem(DefaultWAPIDecorator.java:84) [inforflow-8.2.8.jar:?]
	at sun.reflect.GeneratedMethodAccessor554.invoke(Unknown Source) ~[?:?]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_131]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_131]
	at com.cvicse.workflow.api.client.local.LocalClient.invoke(LocalClient.java:92) [inforflow-8.2.8.jar:?]
	at com.cvicse.workflow.api.client.WfClientImpl.acceptWorkItem(WfClientImpl.java:109) [inforflow-8.2.8.jar:?]
	at com.cvicse.taskguide.inforflow.BaseClient.acceptWorkItem(BaseClient.java:636) [xcom-taskguide.jar:?]
	at com.cvicse.taskguide.mai.base.WorkItemMAIImp.accept(WorkItemMAIImp.java:153) [xcom-taskguide.jar:?]
	at com.cvicse.taskguide.base.WorkItemWrapper.accept(WorkItemWrapper.java:54) [xcom-taskguide.jar:?]
	at org.apache.jsp.xcom.taskguide.workspaceCmis_jsp._jspService(workspaceCmis_jsp.java:151) [hrzcyp/:?]
	at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:70) [jasper.jar:7.0.82]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:731) [servlet-api.jar:?]
	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:439) [jasper.jar:7.0.82]
	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:395) [jasper.jar:7.0.82]
	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:339) [jasper.jar:7.0.82]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:731) [servlet-api.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:303) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52) [tomcat7-websocket.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at com.cvicse.taskguide.web.AbstractTaskGuideFilter.doFilter(AbstractTaskGuideFilter.java:55) [xcom-taskguide.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at com.cvicse.filters.AccessMonitorFilter.doFilter(AccessMonitorFilter.java:99) [xcom-commons-spring.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at com.cvicse.rbac.web.AccessControlFilter.doFilter(AccessControlFilter.java:125) [xcom-rbac.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at com.cvicse.filters.ResourcesReleaseFilter.doFilter(ResourcesReleaseFilter.java:44) [xcom-commons-spring.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at com.planetj.servlet.filter.compression.CompressingFilter.doFilter(CompressingFilter.java:217) [pjl-comp-filter-1.6.4.jar:?]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88) [spring-web-3.2.16.RELEASE.jar:3.2.16.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:106) [spring-web-3.2.16.RELEASE.jar:3.2.16.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241) [catalina.jar:7.0.82]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208) [catalina.jar:7.0.82]
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:219) [catalina.jar:7.0.82]
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:110) [catalina.jar:7.0.82]
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:506) [catalina.jar:7.0.82]
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:169) [catalina.jar:7.0.82]
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:103) [catalina.jar:7.0.82]
	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:962) [catalina.jar:7.0.82]
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116) [catalina.jar:7.0.82]
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:445) [catalina.jar:7.0.82]
	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1115) [tomcat-coyote.jar:7.0.82]
	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:637) [tomcat-coyote.jar:7.0.82]
	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:318) [tomcat-coyote.jar:7.0.82]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142) [?:1.8.0_131]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617) [?:1.8.0_131]
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-coyote.jar:7.0.82]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_131]
Caused by: com.cvicse.workflow.api.exception.WfListenerException: ERROR:25 SQL操作失败
	at com.cvicse.hrzcyp.valuation.listener.ValuationInfoPrepareListener.afterWorkItemAccept(ValuationInfoPrepareListener.java:65) ~[classes/:?]
	... 65 more
Caused by: com.cvicse.jr.commons.object.ObjectPersistentException: SQL操作失败
	at com.cvicse.hrzcyp.valuation.jdbc.JDBCWorthtransactionProcDAO.copyProcToProc(JDBCWorthtransactionProcDAO.java:138) ~[classes/:?]
	at com.cvicse.hrzcyp.valuation.service.impl.ValuationProcessInfoService.copyValuationDataProc(ValuationProcessInfoService.java:78) ~[classes/:?]
	at com.cvicse.hrzcyp.valuation.listener.ValuationInfoPrepareListener.afterWorkItemAccept(ValuationInfoPrepareListener.java:59) ~[classes/:?]
	... 65 more
Caused by: java.sql.SQLRecoverableException: 关闭的语句
	at oracle.jdbc.driver.OracleClosedStatement.setString(OracleClosedStatement.java:734) ~[ojdbc6.jar:11.2.0.3.0]
	at oracle.jdbc.driver.OraclePreparedStatementWrapper.setString(OraclePreparedStatementWrapper.java:280) ~[ojdbc6.jar:11.2.0.3.0]
	at org.apache.commons.dbcp.DelegatingPreparedStatement.setString(DelegatingPreparedStatement.java:131) ~[commons-dbcp-1.2.1.jar:1.2.1]
	at com.cvicse.hrzcyp.valuation.jdbc.JDBCWorthtransactionProcDAO.copyProcToProc(JDBCWorthtransactionProcDAO.java:127) ~[classes/:?]
	at com.cvicse.hrzcyp.valuation.service.impl.ValuationProcessInfoService.copyValuationDataProc(ValuationProcessInfoService.java:78) ~[classes/:?]
	at com.cvicse.hrzcyp.valuation.listener.ValuationInfoPrepareListener.afterWorkItemAccept(ValuationInfoPrepareListener.java:59) ~[classes/:?]
	... 65 more
2017-12-28 20:19:07,166 [http-bio-8080-exec-48] ERROR [com.cvicse.workflow.api.client.local.LocalClient] - com.cvicse.workflow.api.exception.WfListenerException: ERROR:25 null
Caused by: java.lang.reflect.InvocationTargetException
2017-12-28 20:19:07,168 [http-bio-8080-exec-48] INFO  [com.cvicse.workflow.core.WorkflowEngine] - 客户端断开与工作流引擎的连接，用户号[00000000001];
org.apache.jasper.JasperException: An exception occurred processing JSP page /xcom/taskguide/workspaceCmis.jsp at line 40

37: 			workItem.accept();
38: 			TransactionManager.commitTransaction();
39: 		}catch(Exception e){
40: 			TransactionManager.rollbackTransaction();
41: 			e.printStackTrace();
42: 		}
43: 


Stacktrace:
	at org.apache.jasper.servlet.JspServletWrapper.handleJspException(JspServletWrapper.java:580)
	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:477)
	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:395)
	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:339)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:731)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:303)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.cvicse.taskguide.web.AbstractTaskGuideFilter.doFilter(AbstractTaskGuideFilter.java:55)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.cvicse.filters.AccessMonitorFilter.doFilter(AccessMonitorFilter.java:99)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.cvicse.rbac.web.AccessControlFilter.doFilter(AccessControlFilter.java:125)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.cvicse.filters.ResourcesReleaseFilter.doFilter(ResourcesReleaseFilter.java:44)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.planetj.servlet.filter.compression.CompressingFilter.doFilter(CompressingFilter.java:217)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:106)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:219)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:110)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:506)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:169)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:103)
	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:962)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:445)
	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1115)
	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:637)
	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:318)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	at java.lang.Thread.run(Thread.java:748)
Caused by: org.springframework.transaction.TransactionSystemException: Could not roll back JDBC transaction; nested exception is java.sql.SQLRecoverableException: 关闭的连接
	at org.springframework.jdbc.datasource.DataSourceTransactionManager.doRollback(DataSourceTransactionManager.java:288)
	at org.springframework.transaction.support.AbstractPlatformTransactionManager.processRollback(AbstractPlatformTransactionManager.java:846)
	at org.springframework.transaction.support.AbstractPlatformTransactionManager.rollback(AbstractPlatformTransactionManager.java:823)
	at com.cvicse.commons.datasource.jdbc.JDBCDataSource.doRollbackTransaction(JDBCDataSource.java:449)
	at com.cvicse.commons.datasource.TransactionDataSource.rollbackTransaction(TransactionDataSource.java:106)
	at com.cvicse.commons.datasource.TransactionManager.rollbackTransaction(TransactionManager.java:191)
	at org.apache.jsp.xcom.taskguide.workspaceCmis_jsp._jspService(workspaceCmis_jsp.java:154)
	at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:70)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:731)
	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:439)
	... 42 more
Caused by: java.sql.SQLRecoverableException: 关闭的连接
	at oracle.jdbc.driver.PhysicalConnection.rollback(PhysicalConnection.java:3921)
	at org.apache.commons.dbcp.DelegatingConnection.rollback(DelegatingConnection.java:265)
	at org.apache.commons.dbcp.PoolingDataSource$PoolGuardConnectionWrapper.rollback(PoolingDataSource.java:288)
	at org.springframework.jdbc.datasource.DataSourceTransactionManager.doRollback(DataSourceTransactionManager.java:285)
	... 51 more