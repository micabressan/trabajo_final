  it should "cannot extract polygons out of identical points" in {

    case class SomeData(name: String, value: Double)
    implicit val someDataFormat = jsonFormat2(SomeData)

    val point1 = Point(5,5)
    val line1 = Line(point1, point1, point1, point1, point1)
    val poly1: Polygon = Polygon(line1)

    val pointfeature1 = PointFeature(point1, SomeData("Bob", 32.2))
    val linefeature2 = LineFeature(line1, SomeData("Alice", 31.2))
    val polygonfeature = PolygonFeature(poly1, SomeData("Rob", 31.2))

    println(pointfeature1.toGeoJson)
    println(linefeature2.toGeoJson)
    println(polygonfeature.toGeoJson)

    val jsonFeatCol2 = Seq(polygonfeature, linefeature2, pointfeature1).toGeoJson

    jsonFeatCol2.extractGeometries[Point] should be (Seq(point1))
    jsonFeatCol2.extractGeometries[Line] should be (Seq(line1))
    jsonFeatCol2.extractGeometries[Polygon] should be (Seq(poly1))
  }