class dayInYear(private var m: Int, private var d: Int) extends Exception {

  def month: Int = if(m>12) 12 else if(m<1) 1 else m

  def month_=(newMonth: Int) {
    require(1 <= newMonth && newMonth <= 12)
    m = newMonth
  }

  def day: Int = if(d>30) 30 else if(d<1) 1 else d

  def day_=(newDay: Int) {
    require(1 <= newDay && newDay <= 30)
    m = newDay
  }

  def przesun(liczbaDni: Int) : Unit =
    if (liczbaDni > 0) {
      if (liczbaDni > (360 - (month * 30 + day))) {
        d = (liczbaDni-(360 - (month * 30 + day)))%30
        m = (liczbaDni-(360 - (month * 30 + day)))/30
      }
      else {
        d = (day+liczbaDni)%30
        m = month + ( (day+liczbaDni) / 30)
      }
    }
}

object dayInYear {
  def apply(month: Int, day:Int) = new dayInYear(month,day)
}


var test1 = dayInYear(12,40)
println(test1.month+" "+test1.day)
test1.przesun(20)
println(test1.month+" "+test1.day)