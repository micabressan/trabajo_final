  def judge2(aStart: Long, bStart: Long): Int = {

    val and16 = ((1<<16) - 1)
    var nextA = aStart
    var nextB = bStart

    def generateA = {
      do
        nextA = (nextA * 16807) % 2147483647
        while(nextA % 4 != 0)
    }

    def generateB = {
      do
        nextB = (nextB * 48271) % 2147483647
      while(nextB % 8 != 0)
    }

    (1 to 5000000).map( _ => {
      generateA
      generateB
      if ((nextA & and16) == (nextB & and16)) 1
      else 0
    }).sum
  }