javax.jms.JMSException: Wire format negotiation timeout: peer did not send his wire format.
	at org.apache.activemq.util.JMSExceptionSupport.create(JMSExceptionSupport.java:62)
	at org.apache.activemq.ActiveMQConnection.syncSendPacket(ActiveMQConnection.java:1409)
	at org.apache.activemq.ActiveMQConnection.ensureConnectionInfoSent(ActiveMQConnection.java:1496)
	at org.apache.activemq.ActiveMQConnection.start(ActiveMQConnection.java:524)
	at br.com.vrgerenciadora.positron.thread.ServicePosicao.run(ServicePosicao.java:84)
Caused by: java.io.IOException: Wire format negotiation timeout: peer did not send his wire format.
	at org.apache.activemq.transport.WireFormatNegotiator.oneway(WireFormatNegotiator.java:98)
	at org.apache.activemq.transport.MutexTransport.oneway(MutexTransport.java:68)
	at org.apache.activemq.transport.ResponseCorrelator.asyncRequest(ResponseCorrelator.java:81)
	at org.apache.activemq.transport.ResponseCorrelator.request(ResponseCorrelator.java:86)
	at org.apache.activemq.ActiveMQConnection.syncSendPacket(ActiveMQConnection.java:1380)
	... 3 more

javax.jms.JMSException: Wire format negotiation timeout: peer did not send his wire format.
	at org.apache.activemq.util.JMSExceptionSupport.create(JMSExceptionSupport.java:62)
	at org.apache.activemq.ActiveMQConnection.syncSendPacket(ActiveMQConnection.java:1409)
	at org.apache.activemq.ActiveMQConnection.ensureConnectionInfoSent(ActiveMQConnection.java:1496)
	at org.apache.activemq.ActiveMQConnection.start(ActiveMQConnection.java:524)
	at br.com.vrgerenciadora.positron.thread.ServicePosicao.run(ServicePosicao.java:84)
Caused by: java.io.IOException: Wire format negotiation timeout: peer did not send his wire format.
	at org.apache.activemq.transport.WireFormatNegotiator.oneway(WireFormatNegotiator.java:98)
	at org.apache.activemq.transport.MutexTransport.oneway(MutexTransport.java:68)
	at org.apache.activemq.transport.ResponseCorrelator.asyncRequest(ResponseCorrelator.java:81)
	at org.apache.activemq.transport.ResponseCorrelator.request(ResponseCorrelator.java:86)
	at org.apache.activemq.ActiveMQConnection.syncSendPacket(ActiveMQConnection.java:1380)
	... 3 more