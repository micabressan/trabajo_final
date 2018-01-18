package net.verdagon.vcompiler.carpenter

object TetrisTableGeneratorTests {
  def generateRandomNums(numRandoms: Int): Set[Int] = {
    var result: Set[Int] = Set();
    while (result.size < numRandoms) {
      result = result + (Math.random() * 2000000000).toInt;
    }
    result
  }

  def main(args: Array[String]): Unit = {
    (1 until 100).map(_ * 1000).foreach(i => {
      val numTrials = 1000;
      val results =
        (0 until numTrials).map(j => {
          val map = generateRandomNums(i).map(i => i -> i).toMap;
          val table = new TetrisTableGenerator[Int, Int]().generateTetrisTable(map, key => key);
          val space = table.topLevel.length + table.combinedBuckets.length
          val fillRatio = (table.topLevel.count(_.nonEmpty) + table.combinedBuckets.count(_.nonEmpty)) * 1.0 / space;
          (space, fillRatio)
        });
      val worstSpace = results.map(_._1).max * 1.0;
      val averageSpace = results.map(_._1).sum * 1.0 / numTrials;
      val worstFillRatio = results.map(_._2).min * 1.0;
      val averageFillRatio = results.map(_._2).sum * 1.0 / numTrials;
      println("For " + i + " elements, space " + averageSpace + " fill ratio " + averageFillRatio + " worst fill ratio " + worstFillRatio + " space cost " + averageSpace / i + " worst space cost " + worstSpace / i)
    })
  }
}