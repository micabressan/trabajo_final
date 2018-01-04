  def factorial(n:Int):Int = if (n==0) 1 else n * factorial(n-1)
  
  def perm(digits: List[Int], want: Int): List[Int] = {
    if (digits.size == 1) digits
    else {
      val combs = factorial(digits.size - 1)
      val firstDigit = digits(want / combs)
      firstDigit :: perm(digits - firstDigit, want % combs)
    }
  }

  val solution = perm((0 to 9).toList, 1000000)
  println(solution.mkString)