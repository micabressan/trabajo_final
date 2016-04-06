// GuiProgramOne.scala

object GuiProgramOne {
  def main(args: Array[String]) {
    val ui = new UI
    ui.visible = true
    println("End of main function")
  }
}

// UI.scala
import scala.swing._

class UI extends MainFrame {
  title = "GUI Program #1"
  preferredSize = new Dimension(320, 240)
  contents = new Label("Here is the contents!")
}

// scala-swing-2.9.2-rc2.jar in Classpath

// Error messages:

/*
1. illegal inheritance;  self-type UI does not conform to scala.swing.MainFrame's selftype scala.swing.MainFrame
2. missing or invalid dependency detected while loading class file 'Component.class'. Could not access type ScalaObject in package scala, because it (or its dependencies) are missing. Check your build definition for missing or conflicting dependencies. (Re-run with `-Ylog-classpath` to see the problematic classpath.) A full rebuild may help if 'Component.class' was compiled against an incompatible version of scala.
3. missing or invalid dependency detected while loading class file 'Container.class'. Could not access type ScalaObject in package scala, because it (or its dependencies) are missing. Check your build definition for missing or conflicting dependencies. (Re-run with `-Ylog-classpath` to see the problematic classpath.) A full rebuild may help if 'Container.class' was compiled against an incompatible version of scala.
...
...
15. ScalaGUI's tests not built due to errors in dependent scope(s) main
16. type mismatch;  found   : scala.swing.Label  required: scala.swing.Component

*