package AirportScheduler

import collection.mutable
import java.util.Date
import scala.concurrent.duration.Duration

trait AirportScheduler {
  def reserveTime(d: Date): Boolean
  def freeSlot(d: Date): Boolean
  def isValid(d: Date): Boolean
}

class AirportScheduler extends AirportScheduler {

  private[this] val bookedTimes = mutable.TreeSet.empty[Date]
  // Hours worth of milliseconds
  private[this] val Duration = (60 * 60 * 1000)

  def reserveTime(d: Date): Boolean = {
    if (isValid(d)) bookedTimes.add(d)
    else false
  }

  def isValid(d: Date): Boolean = {
    val dt = d.getTime()

    bookedTimes.filter { r =>
      val rt = r.getTime()
      // our reserved time doesn't fall into any of the ranges
      !(dt > rt && dt < rt + Duration)
    }.isEmpty
  }

  def freeSlot(d: Date): Boolean = {
    bookedTimes.remove(d)
  }
}