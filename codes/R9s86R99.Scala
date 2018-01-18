  val cmds = Map[String, (Array[String]) => String](
    "c" -> (args => createTree(args(1).toInt)),
    "e" -> (args => if (tree.has[Int](args(1).toInt)) "1" else "0"),
    "s" -> (args => {
        tree += new Record[Int, Float](args(1).toInt, args(2).toFloat)
        ""
      }),
    "r" -> (args => tree.find[Int](args(1).toInt).map(_.data.toString).getOrElse("")),
    "d" -> (args => {
      tree.remove[Int](args(1).toInt)
      ""
    }),
    "xs" -> (args => tree.size.toString),
    "xa" -> (args => tree.mkString(" "))
  )