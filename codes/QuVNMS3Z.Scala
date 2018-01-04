object Lightness extends AdjustableFilter( "Lightness" ) {
  
  def filter(image:Image) = {
    val original = image.data  
    val filtered = Array.ofDim[Color](image.height, image.width)
    
    for {
      y <- 0 until image.height
      x <- 0 until image.width
    } {
        val pixel = original(y)(x)
        val multiplier = (value+100) / 100.0
        filtered(y)(x) = (Color(pixel.r, pixel.g, pixel.b) * multiplier).clamp
    }
    
    new Image(filtered)
  }
}