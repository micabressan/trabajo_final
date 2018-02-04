private void respond(String msg)
            throws JMSException, NamingException,
            JMSException, NullPointerException {

        InitialContext context = new InitialContext();
        TopicConnectionFactory factory = (TopicConnectionFactory) 
                context.lookup("jms/ConnectionFactory");
        sendTopic(factory, context, msg);
    }

    private void sendTopic(TopicConnectionFactory factory,
            InitialContext context, String msg)
            throws JMSException, NamingException {

        try (TopicConnection con = factory.createTopicConnection()) {
            con.start();
            TopicSession ses = con.createTopicSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic t = (Topic) context.lookup("jms/MyTopic");
            TopicPublisher pub = ses.createPublisher(t);
            TextMessage message = ses.createTextMessage();
            message.setText(msg);
            pub.publish(message);
        }
    }