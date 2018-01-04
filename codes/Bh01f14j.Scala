object AppS2 {
    def main(args: Array[String]) {
        val quantity = Integer.parseInt(args(0))
        var arrSize = ""
        1 to quantity foreach {_ => arrSize += "1"}
        val numberDec = Integer.parseInt(arrSize, 2)
        println(numberDec)
        var sum0, sum1 = 0
        val arr = Array.fill(quantity){scala.util.Random.nextInt(10)}
        val res = new Array[Int](numberDec)
        arr.foreach({a => print(a + " ")})

        for (n_dec <- 1 to numberDec) {
          for (n_bin <- 0 until arr.length) {
                if (getBit(n_dec, n_bin) == 0) {
                    sum0 += arr(n_bin)
                } else if (getBit(n_dec, n_bin) == 1) {
                    sum1 += arr(n_bin)
                }
            }
            res(n_dec-1) = Math.abs(sum1 - sum0)
            sum0 = 0; sum1 = 0
        }
        println("\n" + res.reduce(_ min _))
    }
    def getBit (nDec: Int, nBin: Int) =  {
        val x = (nDec >> nBin) & 1
        x
    }
}