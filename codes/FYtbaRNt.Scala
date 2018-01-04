sealed trait TreeGraph[+A]
case class Vertex[+A](value: A, nodes: List[TreeGraph[A]]) extends TreeGraph[A]

def checkIfValueRepeated[A](tree: TreeGraph[A]) : Boolean = {
  def walk[A](queue: List[TreeGraph[A]], found: List[A]) : Boolean = {
    queue match {
      case Nil => false
      case Vertex(value, nodes) :: t => if (found.contains(value)) true else walk(t ++ nodes, value :: found)
    }
  }
  
  walk(List(tree), List())
}

def mytree = Vertex(7, List(Vertex(4, List(Vertex(2, List(Vertex(3, List()), Vertex(7, List()))), Vertex(1, List())))))

checkIfValueRepeated(mytree)