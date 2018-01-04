apply plugin: 'java'

group = 'nl.remcov1'
version = '0.5'
description = 'testplugin'

sourceCompatibility = 1.8
targetCompatibility = 1.8


//Build directory
tasks.withType(Jar) {
    destinationDir = file("D:\\Remco\\Documents\\Development\\plugins")
}

repositories {

    mavenCentral()
    maven { url "http://repo.maven.apache.org/maven2" }
    maven { url "https://hub.spigotmc.org/nexus/content/repositories/snapshots" }
    maven { url "https://oss.sonatype.org/content/repositories/snapshots/" }

}

dependencies {
    compileOnly group: 'org.spigotmc', name: 'spigot-api', version: '1.12.2-R0.1-SNAPSHOT'
    compileOnly group: 'org.bukkit', name: 'bukkit', version: '1.12.2-R0.1-SNAPSHOT'
}

sourceSets {
    main {
        resources {
            srcDirs= ["src/resources"]
        }
    }
}

task fatJar(type: Jar) {
    manifest {
        attributes 'Implementation-Title': project.description,
                'Implementation-Version': version
    }
    baseName = project.name + '-all'
    from { configurations.compile.collect { it.isDirectory() ? it : zipTree(it) } }
    with jar
}