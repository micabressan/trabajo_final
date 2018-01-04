android {
    buildTypes {
        debug {
            sourceSets {
                main {
                    java {
                        srcDir 'src/test/java'
                    }
                }
                test {
                    java {
                        srcDir 'src/test/java'
                    }
                }
            }
        }
    }
}