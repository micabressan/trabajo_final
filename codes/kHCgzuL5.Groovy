apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-kapt'
apply plugin: 'kotlin-android-extensions'

kapt {
    generateStubs = true
}

android {
    packagingOptions {
        exclude 'META-INF/LICENSE'
        exclude 'META-INF/NOTICE'
    }
    compileSdkVersion 27
    buildToolsVersion '27.0.1'
    defaultConfig {
        flavorDimensions "default"
        multiDexEnabled true
        minSdkVersion 17
        targetSdkVersion 27
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
        vectorDrawables.useSupportLibrary = true

        javaCompileOptions {
            annotationProcessorOptions {
                includeCompileClasspath = true
            }
        }
    }

    productFlavors {
        dev {
            minSdkVersion 17
            dimension "default"
        }

        prod {
            minSdkVersion 17
            dimension "default"
        }
    }
    buildTypes {
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            proguardFiles fileTree('proguard').asList().toArray()
            signingConfig signingConfigs.release
            zipAlignEnabled true
            compileOptions {
                sourceCompatibility JavaVersion.VERSION_1_8
                targetCompatibility JavaVersion.VERSION_1_8
                incremental false
            }
        }
        debug {
            minifyEnabled false
            zipAlignEnabled true
            debuggable true
            jniDebuggable true
            renderscriptDebuggable true
            compileOptions {
                sourceCompatibility JavaVersion.VERSION_1_8
                targetCompatibility JavaVersion.VERSION_1_8
                incremental false
            }
        }
    }
    dataBinding {
        enabled = true
    }

    sourceSets.main {
        jniLibs.srcDirs = ['libsNative']
    }
}

configurations { natives }

dependencies {
    compile fileTree(include: ['*.jar'], dir: 'libs')
    compile "org.jetbrains.kotlin:kotlin-stdlib-jre7:$kotlin_version"
    //    compile "org.jetbrains.kotlinx:kotlinx-coroutines-android:+"
    kapt('com.google.dagger:dagger-compiler:+', "com.android.databinding:compiler:+", "android.arch.persistence.room:compiler:1.0.0-alpha9")
    compile('com.facebook.android:facebook-android-sdk:[4,5)') {
        exclude module: 'support-v4'
        exclude module: 'cardview-v7'
        exclude module: 'customtabs'
    }
    natives "com.badlogicgames.gdx:gdx-platform:1.9.6:natives-armeabi"
    natives "com.badlogicgames.gdx:gdx-platform:1.9.6:natives-armeabi-v7a"
    natives "com.badlogicgames.gdx:gdx-platform:1.9.6:natives-arm64-v8a"
    natives "com.badlogicgames.gdx:gdx-platform:1.9.6:natives-x86"
    natives "com.badlogicgames.gdx:gdx-platform:1.9.6:natives-x86_64"
    compile('com.jakewharton.picasso:picasso2-okhttp3-downloader:1.1.0') {
        exclude module: 'timber'
    }
    compile 'com.android.support:appcompat-v7:+'
    compile 'com.android.support.constraint:constraint-layout:+'
    compile 'com.squareup.retrofit2:retrofit:+'
    compile 'com.squareup.retrofit2:converter-gson:+'
    compile 'com.squareup.retrofit2:converter-scalars:+'
    compile 'com.android.support:recyclerview-v7:+'
    compile 'com.android.support:design:+'
    compile 'com.android.support:support-vector-drawable:+'
    compile 'org.jetbrains.anko:anko-sdk25:+'
    compile 'org.jetbrains.anko:anko-appcompat-v7:+'
    compile 'com.github.dmytrodanylyk.shadow-layout:library:1.0.3'
    compile 'com.android.support:support-annotations:+'
    compile 'org.androidannotations:androidannotations:+'
    compile 'io.reactivex.rxjava2:rxandroid:2.0.1'
    compile 'io.reactivex.rxjava2:rxjava:2.1.0'
    compile 'com.squareup.retrofit2:adapter-rxjava2:+'
    compile 'com.github.matecode:Snacky:1.0.2'
    compile 'com.squareup.okhttp3:logging-interceptor:3.8.0'
    compile 'com.github.mrmike:Ok2Curl:master-SNAPSHOT'
    compile 'com.squareup.picasso:picasso:+'
    compile 'com.badlogicgames.gdx:gdx-backend-android:dev_custom'
    compile 'com.badlogicgames.gdx:gdx:dev_custom'
    compile 'com.badlogicgames.gdx:gdx-freetype:+'
    compile 'com.daimajia.slider:library:1.1.5@aar'
    compile 'com.android.support:cardview-v7:+'
    compile 'com.android.support:customtabs:+'
    compile 'android.arch.persistence.room:runtime:1.0.0-alpha9'
    compile 'nl.komponents.kovenant:kovenant-core:3.3.0'
    compile 'nl.komponents.kovenant:kovenant-android:3.3.0'
    compile 'nl.komponents.kovenant:kovenant-combine:3.3.0'
    compile 'nl.komponents.kovenant:kovenant-jvm:3.3.0'
    compile 'nl.komponents.kovenant:kovenant-functional:3.3.0'
    compile 'org.afinal.simplecache:a-simple-cache:1.0'
    compile 'com.github.chrisbanes:PhotoView:+'
    compile 'com.google.dagger:dagger:+'
    compile 'com.github.johnkil.android-robototextview:robototextview:4.0.0'
    compile 'com.google.android.gms:play-services:11.0.4'
    compile 'com.google.firebase:firebase-core:11.0.4'
    compile 'com.android.support:multidex:1.0.2'
    androidTestCompile 'com.android.support:multidex:1.0.2'
    androidTestCompile 'com.android.support:multidex-instrumentation:1.0.2'
    compile 'com.optimus:editTextField:0.2.0'
    testCompile 'junit:junit:+'
}


repositories {
    jcenter()
    mavenCentral()
    maven { url "https://jitpack.io" }
    maven { url 'https://maven.google.com' }
    maven { url 'https://dl.bintray.com/kishanvaghela/maven/' }
    maven { url "https://oss.sonatype.org/content/repositories/releases/" }
    flatDir {
        dirs 'libsJar'
    }
}

apply plugin: 'com.google.gms.google-services'