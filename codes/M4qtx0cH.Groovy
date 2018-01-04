group 'dev.bleser'
version '1.0-SNAPSHOT'

apply plugin: 'java'
apply plugin: 'war'

sourceCompatibility = 1.8

repositories {
    mavenCentral()
}

dependencies {

    /* Spring dependency */
    compile 'org.springframework.data:spring-data-jpa:2.0.1.RELEASE'
    compile 'org.springframework.security:spring-security-web:4.2.3.RELEASE'
    compile 'org.springframework.security:spring-security-config:4.2.3.RELEASE'
    compile 'org.springframework:spring-websocket:5.0.1.RELEASE'
    compile 'org.springframework:spring-webmvc:5.0.1.RELEASE'

    /* Database dependency */
    compile 'org.postgresql:postgresql:42.1.4'
    compile 'org.hibernate.javax.persistence:hibernate-jpa-2.1-api:1.0.0.Final'
    compile 'org.hibernate:hibernate-entitymanager:5.2.9.Final'
    compile 'org.apache.tomcat:tomcat-dbcp:9.0.1'

    /* JSON */
    compile 'com.fasterxml.jackson.core:jackson-core:2.9.2'
    compile 'com.fasterxml.jackson.core:jackson-databind:2.9.2'

    /* Servlet API */
    providedCompile 'javax.servlet:javax.servlet-api:4.0.0'
    
    /* Test dependency */
    testCompile group: 'junit', name: 'junit', version: '4.12'
}