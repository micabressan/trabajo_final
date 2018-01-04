def filterPar[A: ClassTag](array: Array[A], pred: A => Boolean): Array[A] = {
    import scala.collection.mutable.ArrayBuffer
    val N = array.length
    val P: Int = par.getParallelism
    val tmp = new Array[ArrayBuffer[A]](N)
    val nofTasks = N min P * 16
    val starts = (0 to nofTasks).map(i => (N * i) / nofTasks)
    val intervals = (starts zip starts.tail).map({case(s,e) => (s,e)})
    var idx = 0
    val filterTasks = intervals.map({
      case (start, end) => par.task {
        var i = start
        var count = 0
        val buf = new ArrayBuffer[A]()
        while (i < end) {
          if (pred(array(i))) {
            count += 1
            buf += array(i)
          }
          i += 1
        }
        tmp(idx) = buf
        idx += 1
        count
      }
    })
    val elems = filterTasks.map(t => t.join())
    val count = elems.sum
    val ans = new Array[A](count)
    val tmpflat = tmp.flatten
      (0 until count).foreach{ (i: Int) =>
        ans(i) = tmpflat(i)
      }
    ans
  }