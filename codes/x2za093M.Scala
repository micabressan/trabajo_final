def main(args: Array[String]) = {
    println(regions(bitArray("oundnydw")))
  }

  def setSquares(s: String): Int = {
    (0 until 128)
      .map(n => s"$s-$n")
      .map(Day10.denseHash(_))
      .map(bitsInHash(_))
        .sum
  }

  def bitsInHash(hash: String): Int = {
    BigInt(hash, 16).toString(2).toCharArray.count(_ == '1')
  }

  def bitArray(s: String): Array[String] =
    (0 until 128)
    .map(n => s"$s-$n")
    .map(Day10.denseHash(_))
    .map(BigInt(_, 16).toString(2))
      .map(s => (0 until (128 - s.length)).map(_ =>'0').mkString + s)
    .toArray

  case class Coordinate(row: Int, col: Int)
  type RegionSet = Set[Set[Coordinate]]

  def regions(ar: Array[String]): Int = {
    ar.zipWithIndex.flatMap(a => {
      val (binString, row)= a
      binString
        .zipWithIndex
        .filter(_._1 == '1')
          .map(bitWithIndex => Coordinate(row, bitWithIndex._2))
    }).foldLeft(Set(): RegionSet)((regionSet: RegionSet, c: Coordinate) => reduceRegions(regionSet, c)).size
  }

  def reduceRegions(regionSet: RegionSet, c: Coordinate): RegionSet = {
    val above = new Coordinate(c.row - 1, c.col)
    val left  = new Coordinate(c.row, c.col - 1)
    val (connectingRegions, otherRegions) = regionSet.partition(region => region.contains(above) || region.contains(left))
    //combine all the sets connected to this coordinate
    otherRegions + (connectingRegions.flatten + c)
  }