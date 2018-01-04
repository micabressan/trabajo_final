		InitialContext ctx = new InitialContext();
         ConnectionFactory connectionFactory
                = (ConnectionFactory) ctx.lookup("jms/ConnectionFactory");
         Topic topic = (Topic) ctx.lookup("jms/MyTopic");
         Connection connection = connectionFactory.createConnection();
            Session session = connection.createSession(false,
                    Session.AUTO_ACKNOWLEDGE);
            TextMessage textMessage = session.createTextMessage();
            textMessage.setText(meg);
            MessageProducer messageProducer = session.createProducer(topic);
            messageProducer.send(textMessage);