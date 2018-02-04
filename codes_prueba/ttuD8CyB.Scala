
val input = "pbga (66)\nxhth (57)\nebii (61)\nhavc (66)\nktlj (57)\nfwft (72) -> ktlj, cntj, xhth\nqoyq (66)\npadx (45) -> pbga, havc, qoyq\ntknk (41) -> ugml, padx, fwft\njptl (61)\nugml (68) -> gyxo, ebii, jptl\ngyxo (61)\ncntj (57)"

def trim(line: String): (Set[String], Set[String]) =
  raw"(\s|[0-9]|\(|\))".r.replaceAllIn(line, "").split("->").toList match {
    case x :: y :: Nil => (Set(x), y.split(",").toSet)
    case x :: Nil => (Set(x), Set())
    case unsupported =>
      throw new IllegalArgumentException(s"Cannot process line: $unsupported")
  }

def parse(input: String): (Set[String], Set[String]) =
  input.split("\n").toList map trim reduce ((x, y) => (x._1 | y._1, x._2 | y._2))

def solve(input: String) = {
  val (parents, children) = parse(input)
  (parents &~ children).toList match {
    case List(x) => x
    case _ => throw new IllegalArgumentException("The input is not a valid tree")
  }
}

solve(input)