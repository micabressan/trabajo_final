apply plugin: 'com.android.application'

apply plugin: 'kotlin-android'

apply plugin: 'kotlin-android-extensions'

android {
    compileSdkVersion 26
    defaultConfig {
        applicationId "melzarei.com.MrMeseeksBot"
        minSdkVersion 21
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
}

dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation"org.jetbrains.kotlin:kotlin-stdlib-jre7:$kotlin_version"
    implementation 'com.android.support:appcompat-v7:26.1.0'
    implementation 'com.android.support.constraint:constraint-layout:1.0.2'
    compile 'com.github.stfalcon:chatkit:0.2.2'
    compile 'com.squareup.picasso:picasso:2.5.2'
    compile 'com.instabug.library:instabug:4.3.3'

    compile 'com.bluelinelabs:logansquare:1.3.7' //JSON parsing and serializing library
    compile 'com.github.aurae.retrofit2:converter-logansquare:1.4.1' //Converter for loganSquare JSON serializer for RetroFit.
    compile 'com.squareup.retrofit2:retrofit:2.3.0' //Network library
    compile 'com.squareup.okhttp3:logging-interceptor:3.9.1' //logs HTTP request and response data
    kapt 'com.bluelinelabs:logansquare-compiler:1.3.5'
    compile 'com.github.siyamed:android-shape-imageview:0.9.+@aar'
    compile 'com.android.support:customtabs:26.1.0'

    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.1'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.1'
}

configurations.all {
    resolutionStrategy.eachDependency { DependencyResolveDetails details ->
        def requested = details.requested
        if (requested.group == 'com.android.support') {
            if (!requested.name.startsWith("multidex")) {
                details.useVersion '25.3.1'
            }
        }
    }
}