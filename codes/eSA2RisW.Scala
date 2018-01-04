/**
  * Benchmark WeightedQuickUnionUF vs QuickUnionUF 
  * with Warmer config from Scalameter see below. WQUF can scale (linear) not QUF (exponential)
  * -------------------------------------------------------------------------------------							
  * double n			Time in ms				
  * (n,t)			     (50, 50)	(100, 50)	(200, 50)	(400, 50)	Trend line
  * QuickUnionUF		      50		914		    12082		179841		y=3.6 exp(2.7x)
  * WeightedQuickUnionUF	  6         22		    90		    395		    y= 124x – 181
  * --------------------------------------------------------------------------------------
  *	double t			Time in ms				
  * (n,t)			     (50, 10)	(50, 20) 	(50, 40) 	(50, 80) 	Trend line
  * QuickUnionUF		      10		19      	41			83			y=4.5 exp(0.7x)
  * WeightedQuickUnionUF	  1         2		    4		    9		    y= 3.9x  -5
  */

import edu.princeton.cs.algs4.StdStats
import org.scalameter._
import scala.util.Random
import scala.io.StdIn._


class PercoStats(n: Int, times: Int) {

  val CONFIDENCE_95 = 1.96

  // we build an immutable collection of percolation thresholds
  // a List[Double]
  val thresholds: List[Double] = (
    for (_ <- 1 until times)
      yield monteCarlo(n)
    ).toList


  // call of the Princeton API with Scala List to Java Array conversion
  val mean = StdStats.mean(thresholds.toArray)
  val stddev = StdStats.stddev(thresholds.toArray)
  val confidenceLo = mean - ((CONFIDENCE_95 * stddev) / Math.sqrt(times))
  val confidenceHi = mean + ((CONFIDENCE_95 * stddev) / Math.sqrt(times))


  def monteCarlo(n: Int): Double = {
    val perc: PercoScala = new PercoScala(n)
    var opend = 0.0
    while (!perc.percolates) {
      val p = math.abs(Random.nextInt(n)) + 1
      val q = math.abs(Random.nextInt(n)) + 1
      if (!perc.isOpen(p, q)) {
        perc.open(p, q)
        opend += 1
      }
    }
    opend / (n * n)
  }
}

// we use scalameter to test MonteCarlo method using WQUF vs. QUF implementations
object PercoStats extends Bench.LocalTime {

  override def main(args: Array[String]) = {
    val Array(n, t) = readLine.split(" ").map(_.toInt)

    /* configuration */
    val stdConfig = config(
      Key.exec.minWarmupRuns -> 50,
      Key.exec.maxWarmupRuns -> 100,
      Key.verbose -> true,
      Key.exec.independentSamples -> 16,
      Key.exec.warmupCovThreshold -> 0.0001
    ) withWarmer (new Warmer.Default) withMeasurer (new Measurer.IgnoringGC)


    /* tests */
    val time: Quantity[Double] = stdConfig measure {
      val stats: PercoStats = new PercoStats(n, t)
      /*println("mean:                   = " + stats.mean)
      println("stddev                  = " + stats.stddev)
      println("95% confidence interval = [" + stats.confidenceLo
        + ", " + stats.confidenceHi + " ]")*/
    }

    println(s"With WeightedQuickUnionUF through Percolation.java implementation" +
      s" elapsed time of MonteCarlo(n, T)= ($n,  $t): $time"
    )
  }
}