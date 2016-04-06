// class that encapsulates the complex number's
// state and implements behaviour

class Complex(val real : Double, val img : Double) {
  
  def +(that : Complex) = 
    new Complex(this.real + that.real, this.img + that.img)
  
  def unary_- = 
    new Complex(this.real * -1, this.img * -1)
  
  def unary_~ = 
    new Complex(this.real, this.img * -1)
  
  def -(that : Complex) = 
    this + -that
  
  def *(that : Complex) = {
    val realPart = this.real * that.real + -(this.img * that.img)
    val imgPart = this.real * that.img + this.img * that.real
    new Complex(realPart, imgPart)
  }
  
  def /(that : Complex) = {
    val numer = this * ~that
    val denom = that * ~that
    val divisor = denom.real
    new Complex(numer.real / divisor, denom.real / divisor)
  }
    
  override def toString = 
    this.real  + " + " + this.img + "i"
}


// Companion object
object Complex {
  def apply(real : Double, img : Double) = 
    new Complex(real, img)
}