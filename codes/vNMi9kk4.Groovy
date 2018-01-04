ext.scalaFullVersion = '2.10.3'

buildscript {
    repositories {
        mavenCentral()
        maven {
            url "https://plugins.gradle.org/m2/"
        }
        maven {
            url 'http://dl.bintray.com/jetbrains/intellij-plugin-service'
        }

    }
    dependencies {
        classpath "gradle.plugin.org.jetbrains:gradle-intellij-plugin:0.1.10"

        // https://mvnrepository.com/artifact/org.apache.spark/spark-repl_2.10
        compile group: 'org.apache.spark', name: 'spark-repl_2.10', version: '2.2.0'

    }
}

apply plugin: 'org.jetbrains.intellij'
apply plugin: 'scala'
apply plugin: 'java'

group 'pl.elka'
version '1.0-SNAPSHOT'