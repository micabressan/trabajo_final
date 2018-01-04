node {
    def mvnHome = tool 'maven'
    def scannerHome = tool 'sonar-scanner'
    def jdkHome = tool 'jdk'
    def ld_library = env.LD_LIBRARY_PATH
    String projectName= '/ES_LoginSignature_v2'
    String projectDir = env.baseDir + projectName
   
   stage('Static Analysis'){
        git branch: 'master', credentialsId: 'cd1add22-bb5e-4a10-88e8-c1670abfc14e', url: 'https://sebastianacevedoc@bitbucket.org/sebastianacevedoc/es_loginsignature_v2.git'
        withSonarQubeEnv('sonarqube') {
            sh "'${scannerHome}/bin/sonar-scanner' -Dsonar.projectBaseDir=${projectDir} -X"
        }
        sh 'sleep 10'
        timeout(time: 10, unit: 'SECONDS') {
            def qg = waitForQualityGate()
            if (qg.status != 'OK') {
                echo "Pipeline Abortado ya que el quality gate fallo: ${qg.status}"
                sh "exit 1"
            }
        }
      
    }

    stage('Build') {
        sh "'${mvnHome}/bin/mvn' -f ${projectDir}/pom.xml clean -DoracleHome=/Oracle_Home"
        sh "'${mvnHome}/bin/mvn' -f ${projectDir}/pom.xml compile -DoracleHome=/Oracle_Home"
    }
    
    stage('Scripts'){
        boolean statusSQL=true
        boolean fileSearch=false
            try{
               def files = findFiles(glob: 'sql/**.sql')
               if(files.length == 0){
                   sh "echo 'NO EXISTEN SCRIPTS SQL PARA EJECUTAR' > sql/sql.log"
                   statusSQL=false
                   sh "exit 1"
               }
               sh 'ls -a; cd sql; rm -f **.log'
               files.each {
                    sh "'${env.sqlHome}/bin/sqlplus' -L TDEESDATA01/TDEESDATA01@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=129.158.66.207)(PORT=1521))(CONNECT_DATA=(SID=orafrw)(SERVER=dedicated)))' @${projectDir}/sql/${it.name} > ${projectDir}/sql/${it.name}.log"
                    fileSearch = sh (
                        script: "grep 'PL/SQL procedure successfully completed' sql/${it.name}.log",
                        returnStatus: true
                        ) == 0
                    if(!fileSearch){
                       statusSQL=false
                       sh "exit 1"
                    }
               }
   
               def exists = fileExists 'report'
               if(exists){
                   sh 'ls -a; cd report; rm -f *'
               }else{
                   sh 'mkdir -m 777 report'
               }
               sh "'${env.testRunnerHome}/bin/testrunner.sh' -a -j '${projectDir}/test/CacheManager_HTTP-soapui-project.xml' -f'${projectDir}/report'"   
            }finally{
                archiveArtifacts "sql/**.log"
                if(statusSQL && fileSearch){
                    archiveArtifacts "report/**.txt"
                    junit 'report/**.xml'
                }
            }
    }
   
   
    stage('Deploy') {
        sh "'${mvnHome}/bin/mvn' -f ${projectDir}/pom.xml deploy -DoracleServerUrl=http://129.158.72.76:7001 -DoracleUsername=weblogic -DoraclePassword=Entel123# -DprojectName=ES_LoginSignature_v2 -Dmaven.test.skip=true -DoracleHome=/Oracle_Home -X"
    }
    
    stage('Test') {
            try{
                TEST_EXEC = sh (
                    script: "'${env.testRunnerHome}/bin/testrunner.sh' -a -j '${projectDir}/test/ES_LoginSignature_v2-soapui-project.xml' -f'${projectDir}/report'",
                    returnStatus: true
                ) == 0
                
                if(!TEST_EXEC){
                    sh "exit 1"
                }
                
            }finally{
                archiveArtifacts "report/**.txt"
                if(TEST_EXEC){
                    archiveArtifacts ".data/maven/**.sbar"
                    junit 'report/**.xml'
                }
                
            }
    }
}