def slurper = new JsonSlurper()
def json = slurper.parseText(Run.getEnvironment(TaskListener.NULL).get('MY_FIELD'))
println "MY_FIELD=$json"