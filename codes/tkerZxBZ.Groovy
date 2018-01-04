 try{
   stage('Testing Code') {
       parallel (
           
           cucumber: {
               sh "'${grdHome}/bin/gradle' cucumber"
           },
           jacoco: {
               sh "'${grdHome}/bin/gradle' jacocoTestReport"
           },
           unit: {
               sh "'${grdHome}/bin/gradle' test"
           }
       )
   } } catch (Exception err){
       sh """curl -X POST -H 'Content-type: application/json' --data '{"text":"Pipeline FAILED at Testing Code step"}' https://hooks.slack.com/services/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"""
   }