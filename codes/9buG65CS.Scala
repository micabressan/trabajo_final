  def pad(data: Array[Array[Color]], border: Int):  Array[Array[Color]] = {
    // Create and copy original to output array
    var output = new Array[Array[Color]](data.length)
    Array.copy(data, 0, output, 0, data.length)
    
    // Append data from the first and last rows of the original image
    for (i <- 0 until border) {
    	output = data(0) +: output :+ data(data.length-1)
    }

    // Create padding to left and right of the image by copying the first and last cells over and then return it all
    output.map(a => {
    	Array.concat(Array.fill(border)(a(0)), a, Array.fill(border)(a(a.length-1)))
    })
  }