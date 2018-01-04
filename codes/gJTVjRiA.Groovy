node {
    def mvnHome = tool 'maven'
    def scannerHome = tool 'sonar-scanner'
    def jdkHome = tool 'jdk'
    def ld_library = env.LD_LIBRARY_PATH
    String projectName= 'ES_LoginSignature_v2'
    String pipelineName= projectName +'-pipeline'
    String projectDir = env.baseDir + pipelineName
    String projectSource = env.baseDir + pipelineName + '/' + projectName
   
   stage('Static Analysis'){
        def exists = fileExists "${projectName}"
        if(!exists){
            sh "mkdir -m 777 '${projectName}'"
        }
        
        ws("${projectSource}") {
            git branch: 'master', credentialsId: 'cd1add22-bb5e-4a10-88e8-c1670abfc14e', url: 'https://sebastianacevedoc@bitbucket.org/sebastianacevedoc/es_loginsignature_v2.git'
        }
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
        sh "'${mvnHome}/bin/mvn' -f ${projectSource}/pom.xml clean -DoracleHome=/Oracle_Home"
        sh "'${mvnHome}/bin/mvn' -f ${projectSource}/pom.xml compile -DoracleHome=/Oracle_Home"
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
               sh 'ls -a; cd test; rm -f **.txt TEST**.xml'
               TEST_EXEC = sh (
                    script: "'${env.testRunnerHome}/bin/testrunner.sh' -a -j '${projectDir}/test/CacheManager_HTTP-soapui-project.xml' -f'${projectDir}/test'",
                    returnStatus: true
                ) == 0
                
                if(!TEST_EXEC){
                    sh "exit 1"
                }
               
            }finally{
                archiveArtifacts "sql/**.log"
                if(statusSQL && fileSearch){
                    archiveArtifacts "test/**.txt"
                    if(TEST_EXEC){
                        junit 'test/**.xml'
                    }
                }
            }
    }
    
    stage('Deploy') {
        sh "'${mvnHome}/bin/mvn' -f ${projectSource}/pom.xml deploy -DoracleServerUrl=http://129.158.72.76:7001 -DoracleUsername=weblogic -DoraclePassword=Entel123# -DprojectName='${projectName}' -Dmaven.test.skip=true -DoracleHome=/Oracle_Home -X"
    }
    
    stage('Test') {
            try{
                TEST_EXEC = sh (
                    script: "'${env.testRunnerHome}/bin/testrunner.sh' -a -j '${projectDir}/test/ES_LoginSignature_v2-soapui-project.xml' -f'${projectDir}/test'",
                    returnStatus: true
                ) == 0
                
                if(!TEST_EXEC){
                    sh "exit 1"
                }
                
            }finally{
                archiveArtifacts "test/**.txt"
                if(TEST_EXEC){
                    archiveArtifacts "${projectName}/.data/maven/**.sbar"
                    junit 'test/**.xml'
                }
            }
    }
}