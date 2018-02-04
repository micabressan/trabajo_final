buildscript {
    repositories {
        maven { url 'http://repo.spring.io/plugins-release' }
    }

    dependencies {
        classpath "io.codearte.gradle.nexus:gradle-nexus-staging-plugin:0.11.0"
        classpath 'com.bmuschko:gradle-nexus-plugin:2.3.1'
        classpath "org.springframework.boot:spring-boot-gradle-plugin:1.5.9.RELEASE"
        classpath 'com.bmuschko:gradle-cargo-plugin:2.2.3'
    }
}

ext {
    modelMapperVersion           = '1.1.1'
    lombokVersion                = '1.16.18'
    springBootVersion            = '1.5.9.RELEASE'
    springBootAdminVersion       = '1.5.6'
    springBootLog4JVersion       = '1.3.8.RELEASE'
    springDataOracleVersion      = '1.2.1.RELEASE'
    oracleJdbcVersion            = '12.1.0.2'
    hikariCPVersion              = '2.7.4'
    junitVersion                 = '4.12'
    swaggerUIVersion             = '2.7.0'
    jacksonVersion               = '2.8.10'
    hibernateValidatorVersion    = '5.3.6.Final'
}

ext {
    nexusUrl = "http://nexus.tascombank.ua"
    nexusUsername = 'builder'
    nexusPassword = 'Fc98F=sWLl,M'
}

allprojects { p ->
    group = "ua.com.tascombank"

    apply plugin: 'idea'
    apply plugin: 'java'

    compileJava {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        options.encoding = 'UTF-8'
    }

    compileTestJava {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        options.encoding = 'UTF-8'
        options.compilerArgs += "-parameters"
    }

    repositories {
        maven {
            url "${nexusUrl}/repository/maven-public/"
        }
    }

    dependencies {
        compileOnly group: 'org.projectlombok', name: 'lombok', version: "${lombokVersion}"
    }

    test {
        enabled = false
    }
}

project(":core-api") {
    version = "1.0.0-SNAPSHOT"

//    apply plugin: 'maven'
//    apply plugin: 'com.bmuschko.nexus'
    apply plugin: 'maven-publish'

    dependencies {
        compileOnly group: 'com.fasterxml.jackson.core', name: 'jackson-databind', version: "${jacksonVersion}"
        compileOnly group: 'org.hibernate', name: 'hibernate-validator', version: "${hibernateValidatorVersion}"
    }

    task fatJar(type: Jar) {
        manifest {
            attributes 'Implementation-Title': 'Gradle Jar File Example',
                    'Implementation-Version': version
//                    'Main-Class': 'com.mkyong.DateUtils'
        }
        classifier = 'jar-all'
        from { configurations.compile.collect { it.isDirectory() ? it : zipTree(it) } }
        with jar
    }

    publishing {
        publications {
            maven(MavenPublication) {
                artifactId 'ekb-api'

//                from components.java
                artifact fatJar
//                artifacts = [sourcesJar]
//                artifact javadocJar
            }
        }

        repositories {
            maven {
                credentials {
                    username nexusUsername
                    password nexusPassword
                }
                if (!project.version.endsWith('-SNAPSHOT')) {
                    url "${nexusUrl}/repository/maven-releases"
                } else {
                    url "${nexusUrl}/repository/maven-snapshots"
                }
            }
        }
    }

    javadoc {
        source = sourceSets.main.allJava
        classpath = configurations.compileClasspath

        options {
            setMemberLevel JavadocMemberLevel.PUBLIC
            setAuthor true

            links "https://docs.oracle.com/javase/8/docs/api/"
        }
    }

    task sourcesJar(type: Jar) {
        classifier = 'sources'
        from sourceSets.main.allJava
    }

//    task javadocJar(type: Jar) {
//        from javadoc
//        classifier = 'javadoc'
//    }

//    artifacts {
//        archives fatJar
//        archives javadocJar
//        archives sourcesJar
//    }
}

project(":core") {
    def serviceName = 'ekb-service'
    version = "1.0.0"

    apply plugin: 'org.springframework.boot'
    apply plugin: 'war'
    apply plugin: 'com.bmuschko.cargo'

    war {
        doFirst {
            manifest {
                attributes("Build-Version": version, "Build-Timestamp": new Date())
            }
        }
        archiveName = "${serviceName}.war"
    }

    bootRun {
        // support passing -Dsystem.property=value to bootRun task
        systemProperties = System.properties as Map<String, ?>
    }

    bootRepackage {
        mainClass = 'ua.com.tascombank.ekb.EkbService'
    }

    configurations {
        all*.exclude module: 'spring-boot-starter-logging'
    }

    dependencies {
//        compile project(":core-api")

        compile group: 'ua.com.tascombank', name: 'logger', version: "1.1.0-SNAPSHOT"
        compile group: 'ua.com.tascombank', name: 'error-lib', version: "1.0.0-RELEASE"
        compile group: 'ua.com.tascombank', name: 'client-lib', version: "1.0.0-RELEASE"
        compile group: 'ua.com.tascombank', name: 'utils-lib', version: "1.0.0-RELEASE"
        compile group: 'ua.com.tascombank', name: 'security', version: "1.8.0-RELEASE"
        compile group: 'ua.com.tascombank', name: 'ekb-api', version: "1.0.0-SNAPSHOT"
        compile group: 'ua.com.tascombank.statistic', name: 'security', version: "1.0-RELEASE"

        compile group: 'org.springframework.boot', name: 'spring-boot-starter-web', version: "${springBootVersion}"
        compile group: 'org.springframework.boot', name: 'spring-boot-starter-data-jpa', version: "${springBootVersion}"
        compile group: 'org.springframework.boot', name: 'spring-boot-starter-data-redis', version: "${springBootVersion}"
        compile group: 'org.springframework.boot', name: 'spring-boot-starter-amqp', version: "${springBootVersion}"

        compile group: 'org.springframework.boot', name: 'spring-boot-starter-log4j', version: "${springBootLog4JVersion}"

        compile group: 'de.codecentric', name: 'spring-boot-admin-starter-client', version: "${springBootAdminVersion}"
        compile group: 'org.springframework.data', name: 'spring-data-oracle', version: "${springDataOracleVersion}"

        compile group: 'io.springfox', name: 'springfox-swagger2', version: "${swaggerUIVersion}"
        compile group: 'io.springfox', name: 'springfox-swagger-ui', version: "${swaggerUIVersion}"
        compile group: 'org.modelmapper', name: 'modelmapper', version: "${modelMapperVersion}"

        compile group: 'com.oracle', name: 'ojdbc7', version: "${oracleJdbcVersion}"
        compile group: 'com.zaxxer', name: 'HikariCP', version: "${hikariCPVersion}"

        testCompile group: 'org.springframework.boot', name: 'spring-boot-starter-test', version: "${springBootVersion}"
        testCompile group: 'junit', name: 'junit', version: "${junitVersion}"
    }

    cargo {
        containerId = 'tomcat8x'
        port = 8089

        deployable {
            file = new File(getProjectDir(), "build/libs/${serviceName}.war")
            context = serviceName
        }

        remote {
            hostname = '172.17.11.115'
            username = 'deploy'
            password = 'et4thu7A'
        }
    }

}

task wrapper(type: Wrapper) {
    description = "Generates gradlew[.bat] scripts"
    gradleVersion = "4.4.1"

    doLast() {
        def gradleOpts = "-XX:MaxMetaspaceSize=1024m -Xmx1024m"
        def gradleBatOpts = "$gradleOpts -XX:MaxHeapSize=256m"
        File wrapperFile = file("gradlew")
        wrapperFile.text = wrapperFile.text.replace("DEFAULT_JVM_OPTS=",
                "GRADLE_OPTS=\"$gradleOpts \$GRADLE_OPTS\"\nDEFAULT_JVM_OPTS=")
        File wrapperBatFile = file("gradlew.bat")
        wrapperBatFile.text = wrapperBatFile.text.replace("set DEFAULT_JVM_OPTS=",
                "set GRADLE_OPTS=$gradleBatOpts %GRADLE_OPTS%\nset DEFAULT_JVM_OPTS=")
    }
}