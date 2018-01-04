buildscript {
    repositories {
        maven { url 'https://repo.spring.io/libs-milestone' }
    }

    dependencies {
        classpath 'org.springframework.boot:spring-boot-gradle-plugin:2.0.0.M7'
    }
}

apply plugin: 'org.springframework.boot'
apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'io.spring.dependency-management'


jar {
    baseName = 'multimon'
    version =  '0.1.0'
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencyManagement {
    imports {
        mavenBom 'com.vaadin:vaadin-webjars-bom:1.0.0.alpha11'
    }
}

repositories {
    mavenLocal()
    mavenCentral()
    maven { url "http://repo.spring.io/libs-milestone" }
    maven { url "https://maven.vaadin.com/vaadin-prereleases" }
    jcenter()
}

dependencies {
    compile("org.springframework.boot:spring-boot-starter-web")
        {
        exclude module: "spring-boot-starter-tomcat"
    }
    compile("com.vaadin:flow-spring-addon:1.0.0.alpha12")
}

task wrapper(type: Wrapper) {
    gradleVersion = '4.3.1'
}