apply plugin: 'com.android.application'
apply plugin: 'newrelic'
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-android-extensions'
apply plugin: 'kotlin-kapt'
apply plugin: 'io.fabric'
apply plugin: 'me.tatarka.retrolambda'

android {

    compileSdkVersion 26
    buildToolsVersion '26.0.2'

    defaultConfig {
        minSdkVersion 16
        targetSdkVersion 26
        versionCode 292
        versionName '4.11.6'
        renderscriptTargetApi 18
        renderscriptSupportModeEnabled true
        multiDexEnabled true
        vectorDrawables.useSupportLibrary = true
    }

    lintOptions {
        disable 'MissingTranslation'
    }

    flavorDimensions "server"
    productFlavors {
        prod {
            dimension "server"
            minSdkVersion 21
            applicationId = "com.factory.app"
        }
        dev {
            dimension "server"
            minSdkVersion 21
            applicationId = "com.factory.app"
        }
    }

    buildTypes {
        debug {
            minifyEnabled false
            debuggable true
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-project.txt'
        }
        release {
            minifyEnabled true
            debuggable false
            shrinkResources true
            ext.alwaysUpdateBuildId = false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-project-release.txt'
        }
    }

    lintOptions {
        abortOnError false
    }

    dexOptions {
        javaMaxHeapSize "4g"
    }

    dataBinding {
        enabled = true
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    sourceSets {
        prod.java.srcDir 'src/common/java'
        dev.java.srcDir 'src/common/java'
        main.java.srcDirs += 'src/main/kotlin'
    }

    if (project.hasProperty('devBuild')) {
        splits.abi.enable = false
        splits.density.enable = false
        aaptOptions.cruncherEnabled = false
    }

    packagingOptions {
        exclude 'META-INF/DEPENDENCIES.txt'
        exclude 'META-INF/LICENSE.txt'
        exclude 'META-INF/NOTICE.txt'
        exclude 'META-INF/NOTICE'
        exclude 'META-INF/LICENSE'
        exclude 'META-INF/DEPENDENCIES'
        exclude 'META-INF/notice.txt'
        exclude 'META-INF/license.txt'
        exclude 'META-INF/dependencies.txt'
        exclude 'META-INF/LGPL2.1'
        exclude 'META-INF/INDEX.LIST'
        pickFirst 'android/databinding/DataBindingComponent.java'
        pickFirst 'databinding/DataBindingComponent.java'
        pickFirst 'DataBindingComponent.java'
        pickFirst 'android/databinding/DynamicUtil.java'
        pickFirst 'databinding/DynamicUtil.java'
        pickFirst 'DynamicUtil.java'
    }
}

ext {
    supportVersion = "26.1.0"
    playServicesVersion = "11.6.2"
    retrofitVersion = "2.2.0"
    facebookVersion = "4.25.0"
    okhttpVersion = "3.5.0"
}

configurations.all {
    resolutionStrategy {
        force "com.squareup.okhttp3:okhttp:$okhttpVersion"
        force 'com.squareup.okio:okio:1.11.0'
        force "com.google.android.gms:play-services-auth-api-phone:$playServicesVersion"
        force "com.google.android.gms:play-services-auth-base:$playServicesVersion"
        force "com.google.android.gms:play-services-auth:$playServicesVersion"
        force "com.google.android.gms:play-services-location:$playServicesVersion"
        force "com.android.support:customtabs:$supportVersion"
        force "com.android.support:multidex:1.0.2"
    }
}

dependencies {
    compile fileTree(include: ['*.jar'], dir: 'libs')
    implementation project(':library1')
    implementation project(':library2')
    implementation project(':library3')
    implementation project(':library4')
    implementation project(':library5')
    implementation project(':library6')
    implementation project(':library7')
    implementation project(':library8')
    implementation project(':library9')
    implementation project(':library10')

    compile "com.facebook.android:account-kit-sdk:$facebookVersion"
    compile "com.google.android.gms:play-services-base:$playServicesVersion"
    compile "com.google.android.gms:play-services-location:$playServicesVersion"
    compile "com.google.android.gms:play-services-analytics:$playServicesVersion"
    compile "com.google.android.gms:play-services-maps:$playServicesVersion"
    compile "com.google.android.gms:play-services-places:$playServicesVersion"
    compile "com.google.firebase:firebase-core:$playServicesVersion"
    compile "com.google.firebase:firebase-database:$playServicesVersion"
    compile "com.google.firebase:firebase-messaging:$playServicesVersion"
    compile "com.google.firebase:firebase-storage:$playServicesVersion"
    compile "com.google.firebase:firebase-auth:$playServicesVersion"
    compile(name: 'progress', ext: 'aar')
    compile(name: 'un7zip', ext: 'aar')

    compile "org.jetbrains.kotlin:kotlin-stdlib:$kotlin_version"
    kapt "com.android.databinding:compiler:$gradle_version"

    compile 'io.conekta:conektasdk:2.0'
    compile 'com.android.support:multidex:1.0.2'
    compile 'com.zopim.android:sdk:1.3.3.1'
    compile 'com.jakewharton.picasso:picasso2-okhttp3-downloader:1.0.2'
    compile 'me.tatarka.bindingcollectionadapter2:bindingcollectionadapter:2.2.0'
    compile 'me.tatarka.bindingcollectionadapter2:bindingcollectionadapter-recyclerview:2.2.0'

    compile 'org.hamcrest:java-hamcrest:2.0.0.0'
    compile 'com.android.support.constraint:constraint-layout:1.0.2'

    compile "com.daimajia.swipelayout:library:1.2.0@aar"

    kapt "com.google.dagger:dagger-compiler:$daggerVersion"
    kapt "com.google.dagger:dagger-android-processor:$daggerVersion"

    testCompile 'junit:junit:4.12'
    testCompile "org.mockito:mockito-core:2.8.47"
    testCompile 'org.hamcrest:java-hamcrest:2.0.0.0'
    testCompile 'org.assertj:assertj-core:3.8.0'

    implementation 'com.zendesk:sdk:1.9.1.1'
    implementation 'com.google.android:flexbox:0.3.1'
}

kapt {
    generateStubs = true
}
apply plugin: 'com.google.gms.google-services'