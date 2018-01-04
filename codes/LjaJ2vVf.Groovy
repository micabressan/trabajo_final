def connectionString
def uccode
def lockParams

def versionText
def versionValue

def scannerHome
def configurationText
def configurationVersion

pipeline {
    agent {
        label 'bdd'
    }

    environment {
        Storage = credentials('Storage_Trade_CiBot')
    }

    stages {
        stage('Статический анализ') {
            steps {
                timestamps {
                    script{
                        if (env.BUILD_NUMBER.endsWith("0")) {
                            build job: 'cyclo', wait: false
                            build job: 'cpd', wait: false
                        }
                        scannerHome = tool 'sonar-scanner'
                        configurationText = readFile encoding: 'UTF-8', file: 'src/cf/Configuration.xml'
                        configurationVersion = (configurationText =~ /<Version>(.*)<\/Version>/)[0][1]
                    }
                    withSonarQubeEnv('SonarQube') {
                        cmd("${scannerHome}/bin/sonar-scanner -Dsonar.projectVersion=${configurationVersion} -X")
                    }
                }
            }
        }

        stage('Обновление тестового контура') {
            steps {
                timestamps {
                    script {
                        connectionString = "\"/S${env.Server1C}\\${env.DataBase1C}\""
                        uccode = "\"123\""
                        lockParams = "-lockmessage \"test сообщения\" -lockuccode ${uccode}"

                        versionText = readFile encoding: 'UTF-8', file: 'src/cf/VERSION'
                        versionValue = (versionText =~ /<VERSION>(.*)<\/VERSION>/)[0][1]
                    }
                    cmd("deployka session lock -ras ${env.Server1C} -db ${env.DataBase1C} -v8version ${env.v8version} ${lockParams}")
                    cmd("deployka session kill -ras ${env.Server1C} -db ${env.DataBase1C} -v8version ${env.v8version} ${lockParams}")
                    cmd("deployka loadrepo ${connectionString} \"${env.StoragePath}\" -storage-user ${env.Storage_Usr} -storage-pwd ${env.Storage_Psw} -v8version ${env.v8version} -uccode ${uccode} -storage-ver ${versionValue}")
                    cmd("deployka dbupdate ${connectionString} -v8version ${env.v8version} -allow-warnings -uccode ${uccode}")
                    cmd("deployka session unlock -ras ${env.Server1C} -db ${env.DataBase1C} -v8version ${env.v8version}")
                }
                
            }
        }

        stage('Проверка поведения') {
            steps {
                timestamps {
                    cmd("vrunner vanessa --pathvanessa ./tools/vanessa-behavior/vanessa-behavior.epf --vanessasettings ./tools/VBParams.json --workspace . --ibconnection ${connectionString} --v8version ${env.v8version}")
                }
            }
        }

        stage('Дымовое тестирование') {
            steps {
                timestamps {
                    cmd("vrunner xunit ./tools/xUnitFor1C/Tests/Smoke --pathxunit ./tools/xUnitFor1C/xddTestRunner.epf --reportsxunit \"ГенераторОтчетаJUnitXML{out/junit.xml}\" --xddExitCodePath ./out/junitstatus.log --ibconnection ${connectionString} --v8version ${env.v8version} --xddConfig ./tools/xUnitParams.json")
                }
            }
        }

        stage('Публикация результатов') {
            steps {
                junit allowEmptyResults: true, testResults: 'out/junit.xml'

                allure includeProperties: false,
                    jdk: '',
                    results: [[path: 'out/allure']]

                cucumber fileIncludePattern: '*.json',
                    jsonReportDirectory: 'out/cucumber',
                    sortingMethod: 'ALPHABETICAL'

                cmd("pickles -f features -o out/pickles -l ru --df dhtml --sn \"Trade\"")
            }
        }


        stage('Подготовка дистрибутива') {
            steps {
                timestamps {
                    cmd("packman load-storage \"${env.StoragePath}\" -use-tool1cd -storage-v ${versionValue}")
                    cmd("packman make-cf")
                    cmd("packman make-dist ./tools/package.edf -setup")
                    cmd(" packman zip-dist -name-prefix trade -out out")
                    
                    archiveArtifacts artifacts: 'out/trade*.zip', onlyIfSuccessful: true
                    
                }
            }
        }
    }
}

def cmd(command) {
    if (isUnix()) {
        sh "${command}"
    } else {
        bat "chcp 65001\n${command}"
    }
}