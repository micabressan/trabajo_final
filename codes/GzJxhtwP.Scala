  def pad(data: Array[Array[Color]], border: Int):  Array[Array[Color]] = {
    var top = Array[Array[Color]]()
    var bottom = Array[Array[Color]]()
    
    for (i <- 0 until border) {
    	top = top :+ data(0)
    	bottom = bottom :+ data(data.length-1)
    }
    
    val a = Array.concat(top, data, bottom)

    a.map(a => {
    	val front = Array.fill(border)(a(0))
    	val back = Array.fill(border)(a(a.length-1))
    	Array.concat(front, a, back)
    })
  }