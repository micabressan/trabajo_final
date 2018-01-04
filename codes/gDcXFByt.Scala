  def graphGroupSize(input: String): Int = {

    val line = raw"([0-9]+) <-> (.*)".r

    val valueEdgeMap: Map[Int, Array[Int]] = input.split("\n").map( _ match {
      case line(node, edges) => (node.toInt, edges.split(", ").map(_.toInt))
    }).toMap

    def traverseRec(current: Int, visited: Set[Int]): Set[Int] = {
      val setWithThisNodeVisited = visited + current
      valueEdgeMap(current).foldLeft(setWithThisNodeVisited)((visitedSet, edge) => {
        if (visitedSet.contains(edge)) {
          visitedSet
        } else {
          visitedSet ++ traverseRec(edge, visitedSet)
        }
      })
    }

    valueEdgeMap.keys.foldLeft(Set(): Set[Set[Int]]) ( (groupSet,key) => {
      if (groupSet.exists(group => group.contains(key))) {
        groupSet
      } else {
        groupSet + traverseRec(key, Set())
      }
    }).size
  }