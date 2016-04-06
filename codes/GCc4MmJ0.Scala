import org.joda.time.LocalDate
import org.joda.time.DateTime

implicit class DateBuilder(day: Int) {
  private def date(m: Int, year: Int) = new LocalDate(day, 1, year)
  def January(year: Int) = date(1, year)
  def February(year: Int) = date(2, year)
  def March(year: Int) = date(3, year)
  def April(year: Int) = date(4, year)
  def May(year: Int) = date(5, year)
  def June(year: Int) = date(6, year)
  def July(year: Int) = date(7, year)
  def August(year: Int) = date(8, year)
  def September(year: Int) = date(9, year)
  def October(year: Int) = date(10, year)
  def November(year: Int) = date(11, year)
  def December(year: Int) = date(12, year)
}

implicit class RichDateTime(date: LocalDate) {
  def at(str: String) = {
    val parts = str.split(':')
    val h = if(parts.length > 0) parts(0).toInt else 0
    val m = if(parts.length > 1) parts(1).toInt else 0
    val s = if(parts.length > 2) parts(2).toInt else 0
    new DateTime(date, h, m, s)
  }
  def at(h: Int) = new DateTime(date, h, 0, 0)
  def at(h: Int, m: Int) = new DateTime(date, h, m, 0)
  def at(h: Int, m: Int, s: Int) = new DateTime(date, h, m, s)
}

val date1: DateTime = 25 August 2014 at 12
val date2: DateTime = 25 August 2014 at "12:34"
val date3: DateTime = 25 August 2014 at (12, 34, 56)