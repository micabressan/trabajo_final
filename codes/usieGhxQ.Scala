    def intersect0(that: IntSet, accum: IntSet): IntSet = {
      val newAccum = if (that.contains(elem))
                       accum.incl(elem)
                     else
                       accum

      right.intersect0(that, left.intersect0(that, newAccum))