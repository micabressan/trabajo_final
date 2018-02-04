apply plugin: 'com.android.application'

android {
    compileSdkVersion 27


    defaultConfig {
        applicationId "italiaken.myapplication"
        minSdkVersion 24
        targetSdkVersion 27

        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"

        externalNativeBuild {
            cmake{
                cppFlags "-no-canonical-prefixes",
                        "-fPIC",
                        "-ffunction-sections",
                        "-fdata-sections",
                        "-Wall",
                        "-Os",
                        "-pipe",
                        "-g3",
                        "-fno-stack-protector",
                        "-fPIC",
                        "-fPIE",
                        "-funwind-tables",
                        "-fno-exceptions",
                        "-fno-rtti"
                cFlags "-no-canonical-prefixes",
                        "-fPIC",
                        "-ffunction-sections",
                        "-fdata-sections",
                        "-Wall",
                        "-Os",
                        "-pipe",
                        "-g3",
                        "-fno-stack-protector",
                        "-fPIC",
                        "-fPIE",
                        "-funwind-tables",
                        "-fno-exceptions",
                        "-fno-rtti"

            }
        }
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
    externalNativeBuild {
        cmake {
            path "CMakeLists.txt"
        }
    }
}

dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.1'
}