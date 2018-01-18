import com.tikal.jenkins.plugins.multijob.*
import hudson.*
import hudson.model.*
import hudson.plugins.git.*
import hudson.slaves.*
import hudson.tasks.*

def ln = System.getProperty('line.separator')
println "---------------Groovy Changelog script Started---------------$ln"

def lastSuccesfulBuild = build.previousNotFailedBuild
def failed = build.result != hudson.model.Result.SUCCESS

println "Last Succesful Build: ${lastSuccesfulBuild}"
println "Current Build Result, is failed?: ${failed}"


def currResult = build.result
def prevResult = build.previousBuild?.result ?: null

def consecutiveSuccess = currResult == hudson.model.Result.SUCCESS && prevResult == hudson.model.Result.SUCCESS

def builds = []
def changes = []
def count = 0



if (consecutiveSuccess) {
    builds << build
    def changeItems = build.changeSet.items
    count += changeItems.length
    changes += changeItems as List
} else {
    while (lastSuccesfulBuild) {
        builds << lastSuccesfulBuild
        def changeSet = lastSuccesfulBuild.changeSet
        if (!changeSet.emptySet) {
            def changeItems = lastSuccesfulBuild.changeSet.items
            count += changeItems.length
            changes += changeItems as List
        }
        lastSuccesfulBuild = lastSuccesfulBuild.nextBuild
    }
}

def changesString = ""
if (count ==0){
   changesString += "No changes"
} else {
    changes.each { item ->
    changesString += ("$item.comment by $item.author;".replaceAll("$ln"," "))
    }
}
println "$changesString"

workspace = build.environment.get("WORKSPACE");
if(build.workspace.isRemote()){
channel = build.workspace.channel
}
def props = new hudson.FilePath(channel,"${workspace}/dynamic.properties")
props.write("calculatedchanges=$changesString",null)

println "---------------Groovy Changelog script Finished---------------$ln"