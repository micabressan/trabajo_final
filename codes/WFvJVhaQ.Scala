  def pathSteps(s: String): Int = {
    case class  Coordinate(lat: Float, longi: Int)
    case class ReduceResult(coord: Coordinate, maxDistance: Int)

    def coordDist(c: Coordinate): Int = {

      def longiSteps = Math.abs(c.longi);
      def latiDist = longiSteps.toFloat * .5
      def extraLatSteps = Math.max(Math.abs(c.lat) - latiDist, 0)

      longiSteps + extraLatSteps.toInt
    }

    s.split(',')
      .foldLeft(ReduceResult(Coordinate(0,0), 0))( (rr, dir) => {
        val coord = rr.coord
        val newPosition = dir match {
          case "nw" => Coordinate(coord.lat + .5f, coord.longi - 1)
          case "n" =>  Coordinate(coord.lat + 1, coord.longi)
          case "ne" => Coordinate(coord.lat + .5f, coord.longi + 1)
          case "sw" => Coordinate(coord.lat - .5f, coord.longi - 1)
          case "s" =>  Coordinate(coord.lat - 1, coord.longi)
          case "se" => Coordinate(coord.lat - .5f, coord.longi + 1)
        }
        val newPositionDist = coordDist(newPosition)
        ReduceResult(newPosition, Math.max(newPositionDist, rr.maxDistance))
      }).maxDistance
  }