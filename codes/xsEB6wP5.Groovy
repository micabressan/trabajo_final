apply plugin: 'com.android.application'
 
 
 
android {
    compileSdkVersion 24
    buildToolsVersion '25.0.0'
    sourceSets.main {
        jniLibs.srcDir 'libs'
        jni.srcDirs = [] //disable automatic ndk-build call
    }
 
 
 
 
    def versionPropsFile = file('version.properties')
    def versionBuild
 
    /*Setting default value for versionBuild which is the last incremented value stored in the file */
    if (versionPropsFile.canRead()) {
        def Properties versionProps = new Properties()
        versionProps.load(new FileInputStream(versionPropsFile))
        versionBuild = versionProps['VERSION_BUILD'].toInteger()
    } else {
        throw new GradleException("Could not read version.properties!")
    }
 
    /*Wrapping inside a method avoids auto incrementing on every gradle task run. Now it runs only when we build apk*/
    //ext.autoIncrementBuildNumber = {
 
    if (versionPropsFile.canRead()) {
        def Properties versionProps = new Properties()
        versionProps.load(new FileInputStream(versionPropsFile))
        versionBuild = versionProps['VERSION_BUILD'].toInteger() + 1
        versionProps['VERSION_BUILD'] = versionBuild.toString()
        versionProps.store(versionPropsFile.newWriter(), null)
    } else {
        throw new GradleException("Could not read version.properties!")
    }
    //}
 
    defaultConfig {
        applicationId "com.itsoft.lan.irbis"
        minSdkVersion 16
        targetSdkVersion 25
        versionCode 18
        versionName "2.0" + "(${versionBuild})"
        vectorDrawables.useSupportLibrary = true
        multiDexEnabled true
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
 
    /* auto increment build number for Debug build*/
    //assembleDebug << {
    //    autoIncrementBuildNumber()
    //}
 
    /* auto increment build number for Release build*/
    //assembleRelease << {
    //    autoIncrementBuildNumber()
    //}
}
 
 
buildscript {
    repositories {
        mavenCentral()
        jcenter()
 
    }
    dependencies {
        // replace with the current version of the Android plugin
        classpath 'com.android.tools.build:gradle:3.0.0'
        // replace with the current version of the android-apt plugin
        classpath 'com.neenbedankt.gradle.plugins:android-apt:1.8'
    }
}
 
repositories {
    mavenCentral()
    mavenLocal()
}
 
apply plugin: 'com.android.application'
apply plugin: 'android-apt'
def AAVersion = '4.0.0'
 
dependencies {
    apt "org.androidannotations:androidannotations:$AAVersion"
    compile "org.androidannotations:androidannotations-api:$AAVersion"
}
 
apt {
    arguments {
        androidManifestFile variant.outputs[0]?.processResources?.manifestFile
        // if you have multiple outputst (when using splits), you may want to have other index than 0
 
        // you should set your package name here if you are using different application IDs
        // resourcePackageName "your.package.name"
 
        // You can set optional annotation processing options here, like these commented options:
        // logLevel 'INFO'
        // logFile '/var/log/aa.log'
    }
}
 
 
 ext {
    support_library = '27.0.1'
    material-dialogs = '0.8.6.0'
}
 
dependencies {
 
    compile('io.socket:socket.io-client:0.6.3') {
        // excluding org.json which is provided by Android
        exclude group: 'org.json', module: 'json'
    }
    compile('com.mikepenz:materialdrawer:4.6.4@aar') {
        transitive = true
    }
    //MaterialDialogs
    compile "com.afollestad.material-dialogs:core:$material-dialogs"
    compile "com.afollestad.material-dialogs:commons:$material-dialogs"
 
    //Introduce
    compile 'com.github.paolorotolo:appintro:4.1.0'
 
    // настройки
    compile 'com.jenzz:materialpreference:1.3'
    //алфавитный скроллинг списков
    compile 'com.turingtechnologies.materialscrollbar:lib:10.+'
 
 
 
    compile fileTree(dir: 'libs', include: ['*.jar'])
    testCompile 'junit:junit:4.12'
    //compile project(':volley')
    //http - клиент
    compile 'com.squareup.okhttp3:okhttp:3.4.1'
    compile 'com.squareup.okhttp3:logging-interceptor:3.6.0'
    //header для recycleView
    //circle image
    //compile 'com.google.android.gms:play-services:8.4.0'
    compile 'com.mikepenz:iconics-core:2.9.0@aar'
    compile 'com.mikepenz:google-material-typeface:2.2.0.1.original@aar'
    compile 'com.tonicartos:superslim:0.4.13'
    compile 'com.makeramen:roundedimageview:2.2.1'
    compile 'com.github.rey5137:material:1.2.2'
    compile "com.android.support:appcompat-v7:$support_library"
    compile "com.android.support:design:$support_library"
    compile "com.android.support:support-v4:$support_library"
    compile "com.android.support:recyclerview-v7:$support_library"
    compile "com.android.support:support-vector-drawable:$support_library"
 
    //события
    compile 'org.greenrobot:eventbus:3.0.0'
 
    //PushNotifications
    compile 'com.google.firebase:firebase-messaging:10.2.0'
    compile 'com.google.firebase:firebase-core:10.2.0'
 
    //https://github.com/square/picasso
    compile 'com.squareup.picasso:picasso:2.5.2'
 
    //https://github.com/bumptech/glide
    compile 'com.github.bumptech.glide:glide:3.7.0'
    compile 'jp.wasabeef:glide-transformations:2.0.2'
 
    //https://github.com/leolin310148/ShortcutBadger
    compile "me.leolin:ShortcutBadger:1.1.16@aar"
 
    //https://github.com/Tapadoo/Alerter
    compile 'com.tapadoo.android:alerter:1.0.8'
 
    //https://github.com/wdullaer/MaterialDateTimePicker
    compile 'com.wdullaer:materialdatetimepicker:3.2.2'
 
 
    //https://github.com/dm77/barcodescanner
    compile 'me.dm7.barcodescanner:zxing:1.9.3'
 
    //https://github.com/nostra13/Android-Universal-Image-Loader
    // compile 'com.nostra13.universalimageloader:universal-image-loader:1.9.5'
 
    //Stetho
    compile 'com.facebook.stetho:stetho:1.5.0' 
}
 
dependencies {
    compile files('libs/autobanh.jar')
    compile files('libs/libjingle_peerconnection.jar')
} 
 
apply plugin: 'com.google.gms.google-services'