confFlags = [
    confirmBranchAction: false,
    confirmMasterBuild: false,
    confirmMasterDeploy: false,
    personWhoConfirm: "SYSTEM"
]

deployOptions = [
    applicationStatus: "running"
]


stage('Deploy to environment'){
            when {
              expression { confFlags['confirmBranchAction'] != true }
              not {
                expression {branch_type ==~ /(pr|bugfix|feauture)/ }
              }
              anyOf {
                expression { confFlags['confirmMasterDeploy'] == true }
                expression { return env.BRANCH_NAME != 'master';}
              }
            }
            steps {
              script {
                def sendToChoices = ['restarted', 'started', 'stopped'].join('\n')
                promoteText = [message: "Please choose service status", description: "Choose service status" ]
                stageNamePipeline = "Deploy"
                try {

                    timeout(time: timeouts.promoteBranchAction, unit: timeouts.unit) { // change to a convenient timeout for you
                        promote = input(
                        id: 'app_status',
                        submitterParameter: 'submitter',
                        message: "${promoteText.message}",
                        parameters: [choice(choices: sendToChoices, description: "${promoteText.description}", name: 'status')]
                        )
                    }
                    println "${promote}"
                    if (! checkInputPermissions("${env.SUBMITTERS}","${promote.submitter}"))
                    {
                      currentBuild.result = 'FAILURE'
                      advancedNotifyInfo = "User `${promote.submitter}` does not have access rights for this action"
                    }
                    else {
                      deployOptions['applicationStatus'] = "${app_status.status.toString()}"
                      confFlags['personWhoConfirm'] = app_status.submitter
                    }


                }
                catch(err) { // timeout reached or input false
                    def user = err.getCauses()[0].getUser()
                    if('SYSTEM' == user.toString()) { // SYSTEM means timeout.
                        deployOptions['applicationStatus'] = "running"
                        confFlags['personWhoConfirm'] = "SYSTEM"
                        echo "Timeout"
                    } else {
                        deployOptions['applicationStatus'] = "running"
                        confFlags['personWhoConfirm'] = "${user.toString()}"
                        echo "Aborted by: [${user.toString()}]"
                    }
                }
              }


              timeout (time: 360, unit: timeouts.unit) {
                script {
                
                      dir('code') {
                        image_version = sh(script: "make get-image-version", returnStdout: true)
                        image_version = image_version.replace("\n", "").replace("\r", "");
                      }
                      dir('code/.ansible') {
                      echo "Deploy to environment"
                      echo "${deployOptions.applicationStatus}"
                    //sshagent(credentials: ['deployConfigs.deploy.cred_id']) {                  
                      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${deployConfigs.deploy.vault_cred_id}",
                              usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                        withEnv(["VAULT_PASSWORD=${PASSWORD}"]) {
                          sh "export VAULT_PASSWORD"
                          echo "app_version=${image_version} deploy_env=${deployConfigs.deploy.env_type}"
                          echo "Deploy service"
                          ansiblePlaybook(
                            playbook: 'deploy.yml',
                            inventory: 'inventory/'+ deployConfigs.deploy.env_type + '/' + deployConfigs.deploy.env_type,
                            credentialsId: deployConfigs.deploy.cred_id,
                            extras: '--extra-vars "rservice_app_version=' + image_version + ' deploy_env=' + deployConfigs.deploy.env_type  + ' service_status=' + deployOptions.applicationStatus + '"' + ' --vault-password-file ./vault.py'
                          )
                        }
                      }               
                    }
                  
                }
              }
            }

            post {

              success {
                   notifyBuild(currentBuild.result, "${stageNamePipeline}", false, "${env.TELGRAM_MAINTAINER_USERNAME}","", null)  
              }
              failure {
                   notifyBuild(currentBuild.result, "${stageNamePipeline}", true, "${env.TELGRAM_MAINTAINER_USERNAME}","", null)  
              }
              unstable {
                    notifyBuild(currentBuild.result, "${stageNamePipeline}", true, "${env.TELGRAM_MAINTAINER_USERNAME}","", null)  
              }
           }

        }