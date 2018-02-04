import japgolly.scalajs.react.ScalaComponent
import japgolly.scalajs.react.vdom.html_<^._

object AppContainer {

  case class AppState(
    numberOfVisits: Int
  )

  private val AppContainer =
    ScalaComponent
      .builder[Unit]("AppContainer")
      .initialState[AppState](AppState(0))
      .renderS { (backend, state) =>
        <.div(
          HelloNameComponent("Martin"),
          CounterComponent(state.numberOfVisits),
          IncrementButton {
            IncrementButton.Props(_ =>
              backend.modState(state => state.copy(numberOfVisits = state.numberOfVisits + 1))
            )
          },
          ^.classSet("AppContainer" -> true)
        )
      }
      .build

  def apply() = AppContainer()
}

import japgolly.scalajs.react.ScalaComponent
import japgolly.scalajs.react.component.Scala.Unmounted
import japgolly.scalajs.react.vdom.html_<^._

object CounterComponent {
  private val welcomeTextComponent = {
    ScalaComponent
      .builder[Int]("WelcomeTextComponent")
      .render_P { number =>
        <.div(
          s"Currently $number visits"
        )
      }
      .build
  }

  def apply(number: Int): Unmounted[Int, Unit, Unit] = welcomeTextComponent(number)
}

import japgolly.scalajs.react.ScalaComponent
import japgolly.scalajs.react.component.Scala.Unmounted
import japgolly.scalajs.react.vdom.html_<^._

object HelloNameComponent {
  private val HelloNameComponent =
    ScalaComponent
      .builder[String]("HelloNameComponent")
      .render_P { name =>
        <.div(
          s"Hello there $name, ",
          "you are most certainly welcome",
          ^.classSet("HelloName" -> true, "HelloName1" -> false)
        )
      }
      .build

  def apply(name: String): Unmounted[String, Unit, Unit] = HelloNameComponent(name)
}


import japgolly.scalajs.react.{Callback, ReactEvent, ScalaComponent}
import japgolly.scalajs.react.vdom.html_<^._

object IncrementButton {

  case class Props(
    onClick: ReactEvent => Callback
  )

  private val IncrementButton =
    ScalaComponent
      .builder[Props]("IncrementButton")
      .render_P { props =>
        <.button(
          "Click to increment",
          ^.onClick ==> props.onClick
        )
      }
      .build

  def apply(onClick: Props) = IncrementButton(onClick)
}


import org.scalajs.dom.document

object TutorialApp {
  def main(args: Array[String]): Unit = {
    println("Hello world!")
    AppContainer().renderIntoDOM(document.body)
  }
}


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<script type="text/javascript" src="./target/scala-2.12/the-first-example-jsdeps.js"></script>
<script type="text/javascript" src="./target/scala-2.12/the-first-example-fastopt.js"></script>

</body>
</html>