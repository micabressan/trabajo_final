apply plugin: 'com.android.application'
apply plugin: 'kotlin-kapt'
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-android-extensions'

def protoPath = 'src/main/java/mopo/encryptedsms/data/network/proto'
def wireGeneratedPath = 'build/generated/source/wire'

buildscript {
    repositories {
        // Used to fetch wire-compiler
        mavenCentral()
    }

    dependencies {
        classpath 'com.squareup.wire:wire-compiler:2.2.0'
    }
}

android {
    compileSdkVersion 26
    defaultConfig {
        applicationId "mopo.encryptedsms"
        minSdkVersion 23
        targetSdkVersion 26
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
    sourceSets {
        main {
            java {
                // Include the generated wire code so it is accessible/usable by our code
                srcDir wireGeneratedPath
            }
        }
    }
}

dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation "org.jetbrains.kotlin:kotlin-stdlib:$kotlin_version"
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.1'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.1'

    implementation 'com.android.support:design:26.1.0'

    // "Wire": Protobuf encoding/decoding
    implementation 'com.squareup.wire:wire-runtime:2.2.0'
}

// This handles the Protobuf code generation with Wire
task generateWireClasses {
    println("Generating wire classes")
    description = 'Generate Java classes from protocol buffer (.proto) schema files for use with squareup\'s wire library'
    delete(wireGeneratedPath)
    fileTree(dir: protoPath, include: '**/*.proto').each { File file ->
        doLast {
            javaexec {
                main = 'com.squareup.wire.WireCompiler'
                classpath = buildscript.configurations.classpath
                args = ["--proto_path=${protoPath}", "--java_out=${wireGeneratedPath}", "${file}"]
            }
        }
    }
}

// Do the Wire codegen before compiling anything
preBuild.dependsOn generateWireClasses