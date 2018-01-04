package contracts.agents

org.springframework.cloud.contract.spec.Contract.make {
    request {
        method 'POST'
        urlPath('/private/agents/'){
            queryParameters {
                parameter 'agentId': equalTo("testAgentId")
            }
        }

        headers {
            contentType(applicationFormUrlencoded())
        }

    }

    response {
        status 200
        body(
                agentId: fromRequest().query("agentId"),
                password: anyUuid(),
                note: null,
                createDate: anyIso8601WithOffset(),
        )

        headers {
            contentType("application/json")
        }
    }

}