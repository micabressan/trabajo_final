import  scala.collection.mutable.ArrayBuffer

def mySort(ar: Array[Int]) = {
  var res = ArrayBuffer[Int]()
  var in = ar.toBuffer

  while (ar.length > res.length) {
    in.transform(_ - 1)
    res ++= (for (i <- 0 until in.length if in(i) == 0) yield ar(i))

    // Variant
    println(in.sum + ar.sum)
    // Invariant
    for (i <- 0 until res.length - 1) assert(res(i) <= res(i + 1))
  }
  res
}