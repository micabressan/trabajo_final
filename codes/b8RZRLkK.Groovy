 applicationVariants.all { variant ->
            variant.outputs.all { output ->
                def currentTaskName = "packageMyFlavor1MyFlavor2Release"
                println "${currentTaskName}"
                task ("${currentTaskName}MoveApk"){
                    dependsOn "${currentTaskName}"
                    doLast {
                        println "hello world"
                    }
                }
            }
        }