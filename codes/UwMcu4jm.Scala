import collection.mutable
import java.util.Date
import scala.concurrent.duration.Duration

trait AirportScheduler {
  def book(d: Date): Boolean
  def free(d: Date): Boolean
  def isValid(d: Date): Boolean
}

class AirportSchedulerImpl extends AirportScheduler {

  private[this] val bookedTimes = mutable.TreeSet.empty[Date]
  // Hours worth of milliseconds
  private[this] val Duration = 60 * 60 * 1000

  def book(d: Date): Boolean = {
    if (isValid(d)) bookedTimes.add(d)
    else false
  }

  def isValid(d: Date): Boolean = {
    val dt = d.getTime()

    bookedTimes.filter { r =>
      val rt = r.getTime()

      // find any nodes that our reserved start time may fall between
      dt >= rt && dt <= rt + Duration
    }.isEmpty
  }

  def free(d: Date): Boolean = {
    bookedTimes.remove(d)
  }
}