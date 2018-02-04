import Math.{floor,ceil}

case class Column()
case class Edge(u:AnyVal, v:AnyVal)

object Main {

  type Matrix = IndexedSeq[IndexedSeq[Double]]

  def main(args: Array[String]): Unit = {
    var table = parseTableFile("table.txt")
    table = table.map(row => row:+ row.reduce(_+_))
    table = table :+ ( for (j<- 0 until table(0).length-1) yield table.foldLeft(0d)(_+_(j)))

    val gWithCapacity = for (i <- 0 until table.length; j <- 0 until table(0).length
                             if !(i == table.length-1 && j == table.length-1))
      yield {
        (i,j) match{
          case (a,b) if a == table.length-1 =>
            (Edge(b+table(0).length, 't'), (b+table(0).length,'t') -> (floor(table(a)(b)), ceil(table(a)(b))))
          case (a,b) if b == table(0).length-1 =>
            (Edge('s', a), ('s',a) -> (floor(table(a)(b)), ceil(table(a)(b))))
          case (a,b) =>
            (Edge(a, b+table(0).length), (a,b+table(0).length) -> (floor(table(i)(j)),ceil(table(i)(j))))
        }
    }

    val (g,cc) = gWithCapacity.unzip
    val c = cc.toMap


    depthFirst(g,'s', 't').foreach{println(_)}
  }

  def depthFirst(graph:Seq[Edge],s:AnyVal, t:AnyVal) = {

    def depthFirst_rek(s:AnyVal, t:AnyVal, path:Seq[Edge]): Seq[Seq[Edge]] = s match {
      case s if s==t => List(path)
      case _ =>  graph.filter(_.u == s).filter(!path.contains(_)).map(_ match {
        case Edge(a,b) => depthFirst_rek(b,t,path:+ Edge(a,b))
      }).flatten
    }
    depthFirst_rek(s,t,Seq())
  }



  def ford_floyd():Map[(Int,Int), Double] = {
    null
  }

  def parseTableFile(filename:String): Matrix = {
    import scala.io.Source

    val fileIter = Source.fromFile(filename).getLines()
    var m:Matrix = IndexedSeq[IndexedSeq[Double]]();

    for ( (l,i) <- fileIter.zipWithIndex) {
      i match {
        case 0 =>
        case _ => m = m :+ l.split(" ").map(_.toDouble).toIndexedSeq
      }
    }
    m
  }
}