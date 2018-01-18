import Math.{floor,ceil}

case class Column()
case class Edge(u:AnyVal, v:AnyVal)

/*
Wir haben es leider nicht geschaft die Aufgabe fertigzustellen.
Was funktioniert ist:
* parsing der Datei zu Tabelle
* Graph erstellen aus der Tabelle
* Ermittlung eines Wegs von s nach t durch Tiefensuche
* Ford Folkerson fehlerhaft
 */

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
            (Edge(b+table(0).length, 't'), Edge(b+table(0).length,'t') -> (floor(table(a)(b)), ceil(table(a)(b))))
          case (a,b) if b == table(0).length-1 =>
            (Edge('s', a), Edge('s',a) -> (floor(table(a)(b)), ceil(table(a)(b))))
          case (a,b) =>
            (Edge(a, b+table(0).length), Edge(a,b+table(0).length) -> (floor(table(i)(j)),ceil(table(i)(j))))
        }
    }

    val (g,cc) = gWithCapacity.unzip
    println("Erstellter Graph")
    g.foreach(println(_))
    val c:Map[Edge,(Double,Double)] = cc.toMap
    val c_max = c.map{ case (a,b) => (a,b._2) }

    //ford_folkerson(g,c_max)
  }

  def depthFirst(graph:Seq[Edge],s:AnyVal, t:AnyVal, c:Edge=>Double) = {
    def depthFirst_rek(s:AnyVal, t:AnyVal, path:Seq[Edge]): Seq[Seq[Edge]] = s match {
      case s if s==t => List(path)
      case _ =>  graph.filter(_.u == s).filter(!path.contains(_)).filter(e=> c(e) > 0).map(_ match {
        case Edge(a,b) => depthFirst_rek(b,t,path:+ Edge(a,b))
      }).flatten
    }
    depthFirst_rek(s,t,Seq())
  }

  /*
  def ford_folkerson(g:Seq[Edge], c:Map[Edge, Double]):Map[Edge, Double] = {
    var flow:Map[Edge, Double] = Map()
    val c_r = (edge: Edge)=> c(edge) - flow(edge)
    var path:Seq[Edge]= depthFirst(g,'s','t', c_r).head
    do{
     path = depthFirst(g,'s','t', c_r).head
      val min_capcity = c_r(path.min(Ordering.by(e => c_r(e))))
      for (edge<- path){
        case Edge(u,v) => {
          flow += (edge -> (flow(edge) + min_capcity))
          flow += (Edge(v,u) -> (flow(Edge(v,u)) - min_capcity))
        }
        case _ =>
      }
    }while(path.nonEmpty)
    flow
  }
  */

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