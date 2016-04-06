  it should "not place blocs outside boundries" in {
    val world = createWorld
    world.foreach(t => println(t.width + " : " + t.height + "   " + t.hashCode()))
    println("======")
    for (thing <- world) {
      println("----" + thing.width + " : " + thing.height + "   " + thing.hashCode())
      thing.isInBoundary()should be(true)
    }
  }

  def createWorld = {
    GdxMock.graphics
    new MagicPot() create(new mutable.MutableList[Thing])
  }