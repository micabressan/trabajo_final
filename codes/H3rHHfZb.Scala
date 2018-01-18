package com.builtin

import java.io.File

/**
 * User: mbarisa
 * Date: 10/8/11
 */

class Conditions {
  //def ifconfition() {
  //  var filename = "default.txt"
  //  if (!args.isEmpty)
  //    filename = args(0)
  //}
  def dowhile() {
    var line = ""
    do {
      line = readLine()
      println("Read " + line)
    } while (line != "")
  }

  def fileLines(file: File) =
    scala.io.Source.fromFile(file).getLines().toList

  def grep(pattern: String) {
    val filesHere = (new File("/home/mbarisa")).listFiles
    for (file <- filesHere
         if file.getName.endsWith(".scala");
         line <- fileLines(file)
         if line.trim.matches(pattern)
    )println(file + ": " + line.trim)
   }
}

object Conditions extends App {
  //new Conditions().dowhile()
  println(new Conditions().grep(".*object.*"))

}