import com.typesafe.config._
import com.typesafe.sbt.packager.archetypes.ServerLoader.{SystemV, Upstart}

val conf = ConfigFactory.parseFile(new File("conf/application.conf")).resolve()

name := conf.getString("app.name")

scalaVersion := "2.11.7"

version := conf.getString("app.version")

// Improved incremental compilation (sbt 0.13.2+)
incOptions := incOptions.value.withNameHashing(true)

javaOptions in test += "-Dconfig.file=conf/test.conf"

javacOptions ++= Seq("-s", "app")

scalacOptions ++= Seq(
  "-deprecation", // Emit warning for usages of deprecated APIs
  "-encoding", "UTF-8", // Specify character encoding used by source files
  "-feature", // Emit warning for usages of features that should be imported explicitly
  "-target:jvm-1.8", // Target platform for object files
  "-unchecked", // Enable additional warnings where generated code depends on assumptions

  "-Xfuture", // Turn on future language features
  "-Xlint:_", // Enable or disable specific warnings

  "-Yno-adapted-args", // Do not adapt an argument list to match the receiver
  "-Ywarn-dead-code", // Warn when dead code is identified
  "-Ywarn-value-discard" // Warn when non-Unit expression results are unused

  // Disable temporary as deprecation causes compilation to fail
//  "-Xfatal-warnings" // Fail the compilation if there are any warnings

  // Causing problems with routes
//  "-Yno-imports" // Compile without importing scala.*, java.lang.*, or Predef
//  "-Yno-predef" // Compile without importing Predef

  // Problems with the scala-styled templates
//  "-Ywarn-unused-import" // Warn when local and private vals, vars, defs, and types are unused
)

testOptions in Test += Tests.Argument("html")

updateOptions := updateOptions.value.withCachedResolution(true)

libraryDependencies ++= Seq(
  cache,
  javaCore,
  javaJdbc,
  javaJpa.exclude("org.hibernate.javax.persistence", "hibernate-jpa-2.0-api"), // Potential fix to support Hibernate 4.3+
  javaWs,
  ws,
//  "be.objectify" %% "deadbolt-java" % "2.4.0",
  "be.objectify" %% "deadbolt-java" % "2.4.0.1-SNAPSHOT",
  "com.newrelic.agent.java" % "newrelic-api" % "3.19.0",
  "com.typesafe" %% "jse" % "1.1.2",
  "com.typesafe.play.modules" %% "play-modules-redis" % "2.4.1",
//  "com.zaxxer" % "HikariCP" % "2.4.0", // Needing better logging in HikariCP, not working
  "commons-io" % "commons-io" % "2.4",
//  "joda-time" % "joda-time-hibernate" % "1.3",
  "mysql" % "mysql-connector-java" % "5.1.36",
  "net.logstash.logback" % "logstash-logback-encoder" % "4.4",
  "org.apache.commons" % "commons-csv" % "1.1",
  "org.apache.commons" % "commons-email" % "1.4",
  "org.hibernate" % "hibernate-entitymanager" % "4.3.10.Final",
//  "org.hibernate" % "hibernate-entitymanager" % "5.0.0.CR3",
//  ,"org.hibernate" % "hibernate-jpamodelgen" % "4.3.10.Final" // When active it will generate a JPA metamodel on compile
  "org.jadira.usertype" % "usertype.core" % "3.2.0.GA",
//  "org.jadira.usertype" % "usertype.core" % "4.0.0.GA",
  "org.javatuples" % "javatuples" % "1.2",
  "org.webjars" % "webjars-locator" % "0.27",
  "org.webjars" % "webjars-locator-core" % "0.27",

  // Test
  "org.seleniumhq.selenium" % "selenium-java" % "2.47.1" % "test",
  "org.specs2" %% "specs2-core" % "3.6.4" % "test",
  "org.specs2" % "specs2-junit_2.11" % "3.6.4" % "test",
  "org.specs2" % "specs2-html_2.11" % "3.6.4" % "test",
  "org.specs2" % "specs2-markdown_2.11" % "3.6.4" % "test"
)

// WebJars
libraryDependencies ++= Seq(
  "org.webjars" %% "webjars-play" % "2.4.0",
  "org.webjars" % "requirejs" % "2.1.19",
//  "org.webjars" % "requirejs" % "2.1.11-1",

  // Test
//  "org.webjars" % "rjs" % "2.1.11-1-trireme" % "test",
  "org.webjars" % "rjs" % "2.1.19" % "test",
  "org.webjars" % "squirejs" % "0.1.0" % "test"
)

resolvers ++= Seq(
  "google-sedis-fix" at "http://pk11-scratch.googlecode.com/svn/trunk",
  "scalaz-bintray" at "https://dl.bintray.com/scalaz/releases"

)

resolvers += Resolver.url("Edulify Repository", url("http://edulify.github.io/modules/releases/"))(Resolver.ivyStylePatterns)

resolvers += "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots"

routesGenerator := InjectedRoutesGenerator

//resolvers += Resolver.sonatypeRepo("snapshots")

MochaKeys.requires += "SetupMocha.js"

lazy val root = (project in file (".")).enablePlugins(PlayJava, DebianPlugin)
//lazy val root = (project in file (".")).enablePlugins(JDebPackaging, PlayJava) // Enable in SBT-Native packager 1.0.0
//
//JsEngineKeys.engineType := JsEngineKeys.EngineType.Node

// -- Pipeline

//LessKeys.compress in Assets := true

//includeFilter in (Assets, LessKeys.less) := "*.less"

//excludeFilter in (Assets, LessKeys.less) := "_*.less"

//pipelineStages := Seq(rjs, uglify, digest, gzip)
pipelineStages := Seq(rjs, digest, gzip)

// -- Packaging

serverLoading in Debian := Upstart
//serverLoading in Debian := SystemV

daemonUser in Linux := "mawuser"          // user which will execute the application

daemonGroup in Linux := "mawusers"        // group which will execute the application

debianPackageDependencies in Debian ++= Seq("maw-mediaconverter")

maintainer in Linux := "Johan Dahlberg <johan.dahlberg@mobitec.eu>"

packageDescription := "Mobitec Access Web"

packageSummary in Debian := "MAW Debian Package"

packageSummary in Linux := "MAW Linux Package"

//rpmChangelogFile := Some("changelog.txt")

//rpmLicense := Some("Apache v2")

rpmRelease := conf.getString("app.version")

rpmVendor := "Mobitec"

rpmUrl := Some("http://www.mobitec.eu")

//fork in run := true

// -- Performance

sources in (Compile, doc) := Seq.empty

publishArtifact in (Compile, packageDoc) := false