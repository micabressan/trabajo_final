  def pad(data: Array[Array[Color]], border: Int):  Array[Array[Color]] = {
    
    // Temporary variables to store the padding rows on top and below the original image
    var top = Array[Array[Color]]()
    var bottom = Array[Array[Color]]()
    
    // Append data from the first and last rows of the original image to the temporary arrays
    for (i <- 0 until border) {
    	top = top :+ data(0)
    	bottom = bottom :+ data(data.length-1)
    }
    
    // Join temporary rows together with the original data
    val a = Array.concat(top, data, bottom)

    // Create padding to left and right of the image by copying the first and last cells over and then return it all
    a.map(a => {
    	val front = Array.fill(border)(a(0))
    	val back = Array.fill(border)(a(a.length-1))
    	Array.concat(front, a, back)
    })
  }