object ForLoop { //Run with:  JAVA_OPTS="-Xmx2g" scala ForLoop.scala

  def main(args: Array[String]) {

    val a = Array.fill(50000000)(1)
    
    for ( i <- 0 to 20){

        time {          
          var i = 0
          var sum = 0
          val s = a.size
          while (i < s) {
            sum += a(i)
            i = i + 1
          }
          println(sum)
        }

        time {
          var sum = 0
          val l = a.length
          for (x <- 0 until l)
            sum += a(x)
          println(sum)
        }

        time {
          var sum = 0
          for (x <- a)
            sum += x
          println(sum)
        }

        time {
          var sum = 0
          val l = a.length
          0 until l foreach {
            sum += a(_)
          }
          println(sum)
        }

        time {
          println(a reduce (_+_))
        }        
        println("_"*40)
    }

  }

  def time(body: => Unit) {
    val t = System.currentTimeMillis
    body
    println("Time in ms.: "+(System.currentTimeMillis - t))
  }

}