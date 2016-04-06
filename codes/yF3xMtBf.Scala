name := """PWO2-java"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := "2.11.6"

libraryDependencies ++= Seq(
  // "org.apache.httpcomponents" % "httpclient" % "4.0.1",
  // "commons-logging" % "commons-logging" % "1.1.1",
  // "org.apache.commons" % "commons-email" % "1.3.3",
  // "javax.activation" % "activation" % "1.1.1",
  "com.typesafe.play" %% "play-mailer" % "3.0.1",
  javaJdbc,
  cache,
  javaWs
)

// Play provides two styles of routers, one expects its actions to be injected, the
// other, legacy style, accesses its actions statically.
routesGenerator := InjectedRoutesGenerator


fork in run := true
javaOptions in run += "-Dhttp.port=7777"