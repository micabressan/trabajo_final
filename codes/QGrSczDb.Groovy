            def responseXml = post( body: postBody )
            
            println "Response Body: ${responseXml.text}"	
		// nothing
            println "Response: ${responseXml}"			
		//Response: 53051001id.successPASSresult.matchID LocatedWhen did .. etc...
		//  this is essentially the XML response, but with no tags
            println "Response.response: ${responseXml.response}"
		// nothing

            assert responseXml instanceof groovy.util.slurpersupport.NodeChild
		// true

            responseXml.response.questions.question.each { println "Question: ${it.prompt}" 
		// nothing.. this is the proper node hierarchy

            def output = new StreamingMarkupBuilder().bind { mkp.yield responseXml }
            println output as String
		// outputs the XML as originally received, with tags

// why can't I parse it???

            println "Response Type: ${responseXml.class.type.name}"
		// nothing
            println "Response Type: ${responseXml.type}"
		// nothing
            println "Response Type: ${responseXml.type.name}"
		// nothing
            println "Response Type: ${responseXml.class.type.name}"
		// nothing
            println "Response Type: ${responseXml.class}"
		// nothing
		// ... for gods sake how do i just get the type?
}