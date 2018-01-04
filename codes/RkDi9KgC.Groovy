apply plugin: 'com.android.application'
apply plugin: 'realm-android'

def getDate = new Date().format("ddMMyyyy")

android {
    compileSdkVersion 26
    buildToolsVersion '26.0.2'


    defaultConfig {
        applicationId "com.vrg.gotpair_internship"
        minSdkVersion 16
        targetSdkVersion 26
        versionCode 1
        versionName getDate
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }
    dataBinding {
        enabled = true
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    gradle.projectsEvaluated {
        tasks.withType(JavaCompile) {
            options.compilerArgs << "-Xmaxerrs" << "500"
        }
    }

    resolutionStrategy.eachDependency { DependencyResolveDetails details ->
        def requested = details.requested
        if (requested.group == 'com.android.support') {
            if (!requested.name.startsWith("multidex")) {
                details.useVersion '26.0.2'
            }
        }
    }

}

    dependencies {
        def compileCompatLibraryVersion = '26.1.0'
        compile fileTree(include: ['*.jar'], dir: 'libs')
        androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
            exclude group: 'com.android.support', module: 'support-annotations'
        })
        compile "com.android.support:appcompat-v7:$compileCompatLibraryVersion"
        compile "com.android.support:cardview-v7:$compileCompatLibraryVersion"
        compile "com.android.support:recyclerview-v7:$compileCompatLibraryVersion"
        compile "com.android.support:design:$compileCompatLibraryVersion"
        compile 'com.android.support.constraint:constraint-layout:1.0.2'
        compile 'com.makeramen:roundedimageview:2.3.0'
        compile 'com.squareup.picasso:picasso:2.5.2'
        compile "com.android.support:gridlayout-v7:$compileCompatLibraryVersion"
        compile 'com.github.ittianyu:BottomNavigationViewEx:1.2.3'
        compile 'de.hdodenhof:circleimageview:2.1.0'

        compile "com.daimajia.swipelayout:library:1.2.0@aar"

        compile 'com.github.bumptech.glide:glide:4.3.1'
        annotationProcessor 'com.github.bumptech.glide:compiler:4.3.1'
        compile 'jp.wasabeef:glide-transformations:3.0.1'
        compile 'com.crystal:crystalrangeseekbar:1.1.1'

        compile 'com.google.dagger:dagger:2.13'
        annotationProcessor 'com.google.dagger:dagger-compiler:2.13'
        compile 'com.google.dagger:dagger-android:2.13'
        compile 'com.google.dagger:dagger-android-support:2.13'
        annotationProcessor 'com.google.dagger:dagger-android-processor:2.13'

        compile 'com.squareup.retrofit2:converter-gson:2.3.0'
        compile 'com.squareup.retrofit2:retrofit:2.3.0'
        compile 'com.squareup.retrofit2:adapter-rxjava2:2.3.0'
        compile 'com.squareup.okhttp3:logging-interceptor:3.8.0'

        compile 'io.reactivex.rxjava2:rxandroid:2.0.1'
        compile 'io.reactivex.rxjava2:rxjava:2.1.6'

        compile 'com.facebook.android:facebook-android-sdk:4.28.0'
        compile 'com.facebook.android:facebook-login:4.28.0'

        annotationProcessor 'com.jakewharton:butterknife-compiler:8.8.1'
        compile 'com.jakewharton:butterknife:8.8.1'

        compile 'com.chauthai.swipereveallayout:swipe-reveal-layout:1.4.0'
        compile 'me.relex:circleindicator:1.2.2@aar'
        testCompile 'junit:junit:4.12'
    }