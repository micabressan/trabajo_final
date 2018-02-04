import groovy.json.JsonSlurper
 
def ResponseMessage = messageExchange.response.responseContent
def jsonSlurper = new JsonSlurper().parseText(ResponseMessage)
 
def i = 0
def x = 0
def id
def state
 
//as long as there are values in the array
while(jsonSlurper.versions[i]!=null){
 
  id = jsonSlurper.versions[i].id
  state = jsonSlurper.versions[i].state
 
  if (state == "DRAFT") {
       messageExchange.modelItem.testStep.testCase.setPropertyValue( "Property Transfer", id.toString() )
       log.info id.toString()
  }  else  {
   x++
  }
 i++
}