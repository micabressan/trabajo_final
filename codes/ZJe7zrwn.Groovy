apply plugin: 'com.android.application'    
    apply plugin: 'kotlin-android'
    apply plugin: 'kotlin-android-extensions'
    
    def keystorePropertiesFile = rootProject.file("./signing.properties");
    def keystoreProperties = new Properties()
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    
    android {
        compileSdkVersion rootProject.ext.compileSdkVersion
        buildToolsVersion rootProject.ext.buildToolsVersion
    
        defaultConfig {
            applicationId "com.jm.joinmamas"
            minSdkVersion rootProject.ext.minSdkVersion
            targetSdkVersion rootProject.ext.targetSdkVersion
            versionCode rootProject.ext.versionCode
            versionName rootProject.ext.versionName
            buildConfigField "long", "API_VERSION", "1"
        }
        signingConfigs {
            releaseCI {
                storeFile file(keystoreProperties['RELEASE_STORE_FILE'])
                storePassword keystoreProperties['RELEASE_STORE_PASSWORD']
                keyAlias keystoreProperties['RELEASE_KEY_ALIAS']
                keyPassword keystoreProperties['RELEASE_KEY_PASSWORD']
            }
            release {
                storeFile file(keystoreProperties['RELEASE_STORE_FILE'])
                storePassword keystoreProperties['RELEASE_STORE_PASSWORD']
                keyAlias keystoreProperties['RELEASE_KEY_ALIAS']
                keyPassword keystoreProperties['RELEASE_KEY_PASSWORD']
            }
            debug {
                storeFile file('./../debug.keystore')
            }
        }
    
        def isGitLabCI = System.getenv().containsKey('CI')
    
        buildTypes {
            release {
                debuggable false
                minifyEnabled true
                shrinkResources true
                proguardFiles getDefaultProguardFile('proguard-android.txt')
                proguardFile 'proguard-libs.pro'
                proguardFile 'proguard-android.pro'
                proguardFile 'proguard-common.pro'
                proguardFile 'proguard-rules-release.pro'
                signingConfig signingConfigs.release
                if (isGitLabCI) {
                    signingConfig signingConfigs.releaseCI
                }
            }
            debug {
                debuggable true
                minifyEnabled true
                shrinkResources true
                proguardFiles getDefaultProguardFile('proguard-android.txt')
                proguardFile 'proguard-libs.pro'
                proguardFile 'proguard-android.pro'
                proguardFile 'proguard-common.pro'
                proguardFile 'proguard-jm.pro'
                proguardFile 'proguard-rules-debug.pro'
            }
        }
    
        productFlavors {
            prod {
                applicationId = "com.jm.joinmamas"
            }
            dev {
                applicationId = "com.jm.joinmamas.dev"
            }
        }
    
        flavorDimensions "default"
    
        compileOptions {
            sourceCompatibility JavaVersion.VERSION_1_8
            targetCompatibility JavaVersion.VERSION_1_8
        }
    
        lintOptions {
            checkReleaseBuilds false
            abortOnError false
            disable 'InvalidPackage', 'SpUsage'
        }
    
        defaultConfig {
            resConfigs "en", "de", "ru"
        }
    
        kapt {
            generateStubs = true
        }
    }
    
    dependencies {
        implementation fileTree(dir: 'libs', include: ['*.jar'])
    
        // RxMvp
        implementation project(':rxmvp-core')
        implementation project(':dialog-lib')
        implementation project(':rxmvp-api')
        kapt project(':rxmvp-processor')
    
        // Support
        implementation "com.android.support:appcompat-v7:$support"
        implementation "com.android.support:design:$support"
        implementation "com.android.support:support-v4:$support"
        implementation "com.android.support:support-annotations:$support"
        implementation "com.android.support:percent:$support"
        implementation "com.android.support:cardview-v7:$support"
        implementation "com.android.support:customtabs:$support"
    
        // Location
        implementation "com.google.android.gms:play-services-maps:$googleServices"
        implementation "com.google.android.gms:play-services-location:$googleServices"
        implementation "com.google.maps.android:android-maps-utils:$mapUtils"
    
        // Analytics
        implementation "com.google.firebase:firebase-messaging:$googleServices"
        implementation "com.google.android.gms:play-services-analytics:$googleServices"
    
        // Auth
        implementation "com.facebook.android:facebook-android-sdk:$facebook"
        implementation "com.vk:androidsdk:$vk"
    
        // Stream API
        implementation "com.annimon:stream:$streamApi"
    
        // Retrofit
        implementation "com.squareup.retrofit2:retrofit:$retrofit"
        implementation "com.squareup.retrofit2:converter-gson:$retrofit"
        implementation "com.squareup.retrofit2:adapter-rxjava:$retrofit"
        implementation "com.squareup.okhttp3:logging-interceptor:3.8.1"
    
        // Rx
        implementation "io.reactivex:rxandroid:$rxAndroid"
        implementation "io.reactivex:rxjava:$rxJava"
        implementation "com.jakewharton.rxbinding:rxbinding:$rxBinding"
        implementation "com.github.VictorAlbertos:RxActivityResult:0.3.4"
    
        // Permissions
        implementation "com.tbruyelle.rxpermissions:rxpermissions:0.9.1@aar"
    
        // Dagger 2
        implementation "com.google.dagger:dagger:$dagger"
        kapt "com.google.dagger:dagger-compiler:$dagger"
        compileOnly "org.glassfish:javax.annotation:10.0-b28"
    
        // Butterknife
        implementation "com.google.code.gson:gson:$gson"
        implementation "com.jakewharton:butterknife:$butterKnife"
        kapt "com.jakewharton:butterknife-compiler:$butterKnife"
    
        // Ui stuff
        implementation "com.jakewharton.picasso:picasso2-okhttp3-downloader:$picasso"
        implementation "com.google.android:flexbox:$flexbox"
        implementation "com.roughike:bottom-bar:2.0.2"
        implementation "com.commit451:PhotoView:1.2.5"
        implementation "uk.co.chrisje
    
        // Testing
        testImplementation('org.powermock:powermock-api-mockito2:1.6.5') {
            exclude module: 'hamcrest-core'
            exclude module: 'objenesis'
        }
        testImplementation('org.powermock:powermock-module-junit4:1.6.5') {
            exclude module: 'hamcrest-core'
            exclude module: 'objenesis'
        }
        testImplementation 'org.mockito:mockito-core:2.0.42-beta' // 2.2.7
        testImplementation "junit:junit:4.12"
    
        // todo devImplementation only
        implementation "com.facebook.stetho:stetho:$stethoVersion"
        implementation "com.facebook.stetho:stetho-okhttp3:$stethoVersion"
    
        // Kotlin
        implementation "org.jetbrains.kotlin:kotlin-stdlib:$kotlin_version"
    }
    
    // For Firebase
    apply plugin: 'com.google.gms.google-services'