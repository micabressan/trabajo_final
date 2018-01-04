@Bean
    IntegrationFlow orderAckFlow() {
        return IntegrationFlows
                .from("orderWorkAckMailings")
                .enrichHeaders({it.messageProcessor({
                    [
                            *:it.headers,
                            "logOrderId": it.payload
                    ]
                })})
                .transform({dataFetcher.fetchOrderData(it as Long, MailingType.ORDER_ACK)} as GenericTransformer)
                .filter("!payload.isEmpty()")
// Вот на этом моменте необходимо из it.payload сформировать два сообщения (один клиенту, другой в планфикс)
                .enrichHeaders({it.messageProcessor({
                    [
                            *:it.headers,
                            "logMailingType": MailingType.ORDER_ACK.toString(),
                            "margoType": config.typeOrderAck,
                            "margoTitle": "Вы заказали работу. Что дальше?",
                            "margoFromAddress": it.payload.managerEmail,
                            "margoToAddress": it.payload.clientEmail
                    ]
                })})
                .transform({
                        templateRenderer.render(
                                "OrderWorkAckTemplate",
                                [
                                        *:it,
                                        managerName: it.managerName.split(" ").take(2).join(" "),
                                        managerNumber: it.managerEmail.split("@")[0]
                                ]
                        )
                    } as GenericTransformer
                )
                .channel("margoMessages")
                .get()
    }