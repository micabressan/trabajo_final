version '1.0-SNAPSHOT'

apply plugin: 'java'

sourceCompatibility = 1.8

repositories {
    maven { url "https://oss.sonatype.org/content/repositories/snapshots" }
    mavenCentral()
}

dependencies {
    compile group: 'org.deeplearning4j', name: 'deeplearning4j-core', version: '0.9.2-SNAPSHOT'
    compile group: 'org.deeplearning4j', name: 'deeplearning4j-modelimport', version: '0.9.2-SNAPSHOT'
//  also tried:
//  compile group: 'org.nd4j', name: 'nd4j-native', version: '0.9.2-SNAPSHOT'
    compile "org.nd4j:nd4j-native:0.9.2-SNAPSHOT"
    compile "org.nd4j:nd4j-native:0.9.2-SNAPSHOT:macosx-x86_64"
    testCompile group: 'junit', name: 'junit', version: '4.12'

}