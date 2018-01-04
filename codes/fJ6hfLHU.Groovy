> Task :app:dependencies

------------------------------------------------------------
Project :app
------------------------------------------------------------

compile - Compile dependencies for 'main' sources (deprecated: use 'implementation' instead).
+--- project :materialintro FAILED
+--- project :materialslide FAILED
+--- com.android.support:appcompat-v7:27.0.2
|    +--- com.android.support:support-annotations:27.0.2
|    +--- com.android.support:support-core-utils:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    \--- com.android.support:support-compat:27.0.2
|    |         +--- com.android.support:support-annotations:27.0.2
|    |         \--- android.arch.lifecycle:runtime:1.0.3
|    |              +--- android.arch.lifecycle:common:1.0.3
|    |              \--- android.arch.core:common:1.0.0
|    +--- com.android.support:support-fragment:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-ui:27.0.2
|    |    |    +--- com.android.support:support-annotations:27.0.2
|    |    |    \--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-utils:27.0.2 (*)
|    |    \--- com.android.support:support-annotations:27.0.2
|    +--- com.android.support:support-vector-drawable:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    \--- com.android.support:support-compat:27.0.2 (*)
|    \--- com.android.support:animated-vector-drawable:27.0.2
|         +--- com.android.support:support-vector-drawable:27.0.2 (*)
|         \--- com.android.support:support-core-ui:27.0.2 (*)
+--- com.android.support:design:27.0.2
|    +--- com.android.support:support-v4:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-media-compat:27.0.2
|    |    |    +--- com.android.support:support-annotations:27.0.2
|    |    |    \--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-utils:27.0.2 (*)
|    |    +--- com.android.support:support-core-ui:27.0.2 (*)
|    |    \--- com.android.support:support-fragment:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    \--- com.android.support:support-core-ui:27.0.2 (*)
|    \--- com.android.support:transition:27.0.2
|         +--- com.android.support:support-annotations:27.0.2
|         \--- com.android.support:support-compat:27.0.2 (*)
+--- com.android.support:support-v4:27.0.2 (*)
+--- com.android.support:cardview-v7:27.0.2
|    \--- com.android.support:support-annotations:27.0.2
+--- com.android.support:recyclerview-v7:27.0.2 (*)
+--- com.android.support:preference-v7:27.0.2
|    +--- com.android.support:support-v4:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    \--- com.android.support:recyclerview-v7:27.0.2 (*)
+--- com.android.support:preference-v14:27.0.2
|    +--- com.android.support:support-v4:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:27.0.2 (*)
|    \--- com.android.support:preference-v7:27.0.2 (*)
+--- com.anjlab.android.iab.v3:library:1.0.43
+--- com.crashlytics.sdk.android:crashlytics:2.6.8
|    +--- com.crashlytics.sdk.android:beta:1.2.5
|    |    \--- io.fabric.sdk.android:fabric:1.3.17
|    +--- io.fabric.sdk.android:fabric:1.3.17
|    +--- com.crashlytics.sdk.android:crashlytics-core:2.3.17
|    |    +--- io.fabric.sdk.android:fabric:1.3.17
|    |    \--- com.crashlytics.sdk.android:answers:1.3.13
|    |         \--- io.fabric.sdk.android:fabric:1.3.17
|    \--- com.crashlytics.sdk.android:answers:1.3.13 (*)
+--- com.mikepenz:iconics-core:2.9.1
+--- com.mikepenz:material-design-iconic-typeface:2.2.0.2
+--- com.google.android.gms:play-services-analytics:11.6.2
|    +--- com.google.android.gms:play-services-analytics-impl:11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2
|    |    |    +--- com.google.android.gms:play-services-basement:11.6.2
|    |    |    |    +--- com.android.support:support-v4:25.2.0 -> 27.0.2 (*)
|    |    |    |    \--- com.google.android.gms:play-services-basement-license:11.6.2
|    |    |    +--- com.google.android.gms:play-services-tasks:11.6.2
|    |    |    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    |    |    \--- com.google.android.gms:play-services-tasks-license:11.6.2
|    |    |    \--- com.google.android.gms:play-services-base-license:11.6.2
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-analytics-impl-license:11.6.2
|    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    +--- com.google.android.gms:play-services-tagmanager-v4-impl:11.6.2
|    |    +--- com.google.android.gms:play-services-analytics-impl:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-tagmanager-v4-impl-license:11.6.2
|    \--- com.google.android.gms:play-services-analytics-license:11.6.2
+--- com.google.code.gson:gson:2.8.0
+--- com.squareup.retrofit2:retrofit:2.1.0
|    \--- com.squareup.okhttp3:okhttp:3.3.0
|         \--- com.squareup.okio:okio:1.8.0
+--- com.squareup.retrofit2:converter-gson:2.1.0
|    +--- com.squareup.retrofit2:retrofit:2.1.0 (*)
|    \--- com.google.code.gson:gson:2.7 -> 2.8.0
+--- com.squareup.retrofit2:adapter-rxjava:2.1.0
|    +--- com.squareup.retrofit2:retrofit:2.1.0 (*)
|    \--- io.reactivex:rxjava:1.1.5 -> 1.1.6
+--- org.jetbrains.kotlin:kotlin-stdlib:1.2.10
|    \--- org.jetbrains:annotations:13.0
+--- org.jetbrains.anko:anko-common:0.9.1
+--- io.reactivex:rxandroid:1.2.1
|    \--- io.reactivex:rxjava:1.1.6
+--- com.onesignal:OneSignal:3.7.1
|    +--- com.google.android.gms:play-services-gcm:[10.2.1, 11.7.0) -> 11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-iid:11.6.2
|    |    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    |    \--- com.google.android.gms:play-services-iid-license:11.6.2
|    |    \--- com.google.android.gms:play-services-gcm-license:11.6.2
|    +--- com.google.android.gms:play-services-location:[10.2.1, 11.7.0) -> 11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-tasks:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-location-license:11.6.2
|    +--- com.android.support:support-v4:[26.0.0, 27.1.0) -> 27.0.2 (*)
|    \--- com.android.support:customtabs:[26.0.0, 27.1.0) -> 27.0.2
|         +--- com.android.support:support-compat:27.0.2 (*)
|         \--- com.android.support:support-annotations:27.0.2
+--- net.danlew:android.joda:2.9.9
|    \--- joda-time:joda-time:2.9.9
+--- com.github.hotchemi:android-rate:1.0.1
+--- com.github.CymChad:BaseRecyclerViewAdapterHelper:2.9.31
+--- com.github.iammert:ExpandableLayout:1.4.1
|    \--- com.android.support:support-annotations:25.2.0 -> 27.0.2
+--- com.github.dimorinny:floating-text-button:0.0.2
|    +--- com.android.support:appcompat-v7:25.1.0 -> 27.0.2 (*)
|    \--- com.android.support:cardview-v7:25.1.0 -> 27.0.2 (*)
+--- com.hlab.fabrevealmenu:fab-reveal-menu:1.0.2
|    +--- com.android.support:appcompat-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.android.support:cardview-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.nineoldandroids:library:2.4.0
|    +--- com.github.asyl.animation:arcanimator:1.0.0
|    |    \--- com.nineoldandroids:library:2.4.0
|    \--- com.github.ozodrukh:CircularReveal:1.3.1
\--- com.android.support:multidex:1.0.1

(*) - dependencies omitted (listed previously)


BUILD SUCCESSFUL in 1s
1 actionable task: 1 executed
F:\Android\AndroidProject\smsvizitka_kotlin>gradle app:dependencies --configuration compile

> Configure project :materialintro
Configuration 'compile' in project ':materialintro' is deprecated. Use 'implementation' instead.
Configuration 'testCompile' in project ':materialintro' is deprecated. Use 'testImplementation' instead.

> Configure project :materialslide
Configuration 'compile' in project ':materialslide' is deprecated. Use 'implementation' instead.
Configuration 'androidTestCompile' in project ':materialslide' is deprecated. Use 'androidTestImplementation' instead.

> Configure project :app
Configuration 'compile' in project ':app' is deprecated. Use 'implementation' instead.
registerResGeneratingTask is deprecated, use registerGeneratedFolders(FileCollection)
registerResGeneratingTask is deprecated, use registerGeneratedFolders(FileCollection)
registerResGeneratingTask is deprecated, use registerGeneratedFolders(FileCollection)
registerResGeneratingTask is deprecated, use registerGeneratedFolders(FileCollection)

> Task :app:dependencies

------------------------------------------------------------
Project :app
------------------------------------------------------------

compile - Compile dependencies for 'main' sources (deprecated: use 'implementation' instead).
+--- project :materialintro FAILED
+--- project :materialslide FAILED
+--- com.android.support:appcompat-v7:27.0.2
|    +--- com.android.support:support-annotations:27.0.2
|    +--- com.android.support:support-core-utils:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    \--- com.android.support:support-compat:27.0.2
|    |         +--- com.android.support:support-annotations:27.0.2
|    |         \--- android.arch.lifecycle:runtime:1.0.3
|    |              +--- android.arch.lifecycle:common:1.0.3
|    |              \--- android.arch.core:common:1.0.0
|    +--- com.android.support:support-fragment:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-ui:27.0.2
|    |    |    +--- com.android.support:support-annotations:27.0.2
|    |    |    \--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-utils:27.0.2 (*)
|    |    \--- com.android.support:support-annotations:27.0.2
|    +--- com.android.support:support-vector-drawable:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    \--- com.android.support:support-compat:27.0.2 (*)
|    \--- com.android.support:animated-vector-drawable:27.0.2
|         +--- com.android.support:support-vector-drawable:27.0.2 (*)
|         \--- com.android.support:support-core-ui:27.0.2 (*)
+--- com.android.support:design:27.0.2
|    +--- com.android.support:support-v4:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-media-compat:27.0.2
|    |    |    +--- com.android.support:support-annotations:27.0.2
|    |    |    \--- com.android.support:support-compat:27.0.2 (*)
|    |    +--- com.android.support:support-core-utils:27.0.2 (*)
|    |    +--- com.android.support:support-core-ui:27.0.2 (*)
|    |    \--- com.android.support:support-fragment:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:27.0.2
|    |    +--- com.android.support:support-annotations:27.0.2
|    |    +--- com.android.support:support-compat:27.0.2 (*)
|    |    \--- com.android.support:support-core-ui:27.0.2 (*)
|    \--- com.android.support:transition:27.0.2
|         +--- com.android.support:support-annotations:27.0.2
|         \--- com.android.support:support-compat:27.0.2 (*)
+--- com.android.support:support-v4:27.0.2 (*)
+--- com.android.support:cardview-v7:27.0.2
|    \--- com.android.support:support-annotations:27.0.2
+--- com.android.support:recyclerview-v7:27.0.2 (*)
+--- com.android.support:preference-v7:27.0.2
|    +--- com.android.support:support-v4:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    \--- com.android.support:recyclerview-v7:27.0.2 (*)
+--- com.android.support:preference-v14:27.0.2
|    +--- com.android.support:support-v4:27.0.2 (*)
|    +--- com.android.support:appcompat-v7:27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:27.0.2 (*)
|    \--- com.android.support:preference-v7:27.0.2 (*)
+--- com.anjlab.android.iab.v3:library:1.0.43
+--- com.crashlytics.sdk.android:crashlytics:2.6.8
|    +--- com.crashlytics.sdk.android:beta:1.2.5
|    |    \--- io.fabric.sdk.android:fabric:1.3.17
|    +--- io.fabric.sdk.android:fabric:1.3.17
|    +--- com.crashlytics.sdk.android:crashlytics-core:2.3.17
|    |    +--- io.fabric.sdk.android:fabric:1.3.17
|    |    \--- com.crashlytics.sdk.android:answers:1.3.13
|    |         \--- io.fabric.sdk.android:fabric:1.3.17
|    \--- com.crashlytics.sdk.android:answers:1.3.13 (*)
+--- com.mikepenz:iconics-core:2.9.1
+--- com.mikepenz:material-design-iconic-typeface:2.2.0.2
+--- com.google.android.gms:play-services-analytics:11.6.2
|    +--- com.google.android.gms:play-services-analytics-impl:11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2
|    |    |    +--- com.google.android.gms:play-services-basement:11.6.2
|    |    |    |    +--- com.android.support:support-v4:25.2.0 -> 27.0.2 (*)
|    |    |    |    \--- com.google.android.gms:play-services-basement-license:11.6.2
|    |    |    +--- com.google.android.gms:play-services-tasks:11.6.2
|    |    |    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    |    |    \--- com.google.android.gms:play-services-tasks-license:11.6.2
|    |    |    \--- com.google.android.gms:play-services-base-license:11.6.2
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-analytics-impl-license:11.6.2
|    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    +--- com.google.android.gms:play-services-tagmanager-v4-impl:11.6.2
|    |    +--- com.google.android.gms:play-services-analytics-impl:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-tagmanager-v4-impl-license:11.6.2
|    \--- com.google.android.gms:play-services-analytics-license:11.6.2
+--- com.google.code.gson:gson:2.8.0
+--- com.squareup.retrofit2:retrofit:2.1.0
|    \--- com.squareup.okhttp3:okhttp:3.3.0
|         \--- com.squareup.okio:okio:1.8.0
+--- com.squareup.retrofit2:converter-gson:2.1.0
|    +--- com.squareup.retrofit2:retrofit:2.1.0 (*)
|    \--- com.google.code.gson:gson:2.7 -> 2.8.0
+--- com.squareup.retrofit2:adapter-rxjava:2.1.0
|    +--- com.squareup.retrofit2:retrofit:2.1.0 (*)
|    \--- io.reactivex:rxjava:1.1.5 -> 1.1.6
+--- org.jetbrains.kotlin:kotlin-stdlib:1.2.10
|    \--- org.jetbrains:annotations:13.0
+--- org.jetbrains.anko:anko-common:0.9.1
+--- io.reactivex:rxandroid:1.2.1
|    \--- io.reactivex:rxjava:1.1.6
+--- com.onesignal:OneSignal:3.7.1
|    +--- com.google.android.gms:play-services-gcm:[10.2.1, 11.7.0) -> 11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-iid:11.6.2
|    |    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    |    \--- com.google.android.gms:play-services-iid-license:11.6.2
|    |    \--- com.google.android.gms:play-services-gcm-license:11.6.2
|    +--- com.google.android.gms:play-services-location:[10.2.1, 11.7.0) -> 11.6.2
|    |    +--- com.google.android.gms:play-services-base:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-basement:11.6.2 (*)
|    |    +--- com.google.android.gms:play-services-tasks:11.6.2 (*)
|    |    \--- com.google.android.gms:play-services-location-license:11.6.2
|    +--- com.android.support:support-v4:[26.0.0, 27.1.0) -> 27.0.2 (*)
|    \--- com.android.support:customtabs:[26.0.0, 27.1.0) -> 27.0.2
|         +--- com.android.support:support-compat:27.0.2 (*)
|         \--- com.android.support:support-annotations:27.0.2
+--- net.danlew:android.joda:2.9.9
|    \--- joda-time:joda-time:2.9.9
+--- com.github.hotchemi:android-rate:1.0.1
+--- com.github.CymChad:BaseRecyclerViewAdapterHelper:2.9.31
+--- com.github.iammert:ExpandableLayout:1.4.1
|    \--- com.android.support:support-annotations:25.2.0 -> 27.0.2
+--- com.github.dimorinny:floating-text-button:0.0.2
|    +--- com.android.support:appcompat-v7:25.1.0 -> 27.0.2 (*)
|    \--- com.android.support:cardview-v7:25.1.0 -> 27.0.2 (*)
+--- com.hlab.fabrevealmenu:fab-reveal-menu:1.0.2
|    +--- com.android.support:appcompat-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.android.support:cardview-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.android.support:recyclerview-v7:25.2.0 -> 27.0.2 (*)
|    +--- com.nineoldandroids:library:2.4.0
|    +--- com.github.asyl.animation:arcanimator:1.0.0
|    |    \--- com.nineoldandroids:library:2.4.0
|    \--- com.github.ozodrukh:CircularReveal:1.3.1
\--- com.android.support:multidex:1.0.1

(*) - dependencies omitted (listed previously)