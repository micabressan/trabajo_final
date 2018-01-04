  def partPathFromTs(path: String, tsStart: Long, tsEnd: Long): String = {
    val startDay = new DateTime(tsStart * 1000, DateTimeZone.UTC)
    val endDay = new DateTime(tsEnd * 1000, DateTimeZone.UTC)

    daysInPeriod(startDay, endDay).map { date =>
      val (year, month, day) = (date.year().get(), date.monthOfYear().get(), date.dayOfMonth().get())
      f"$path/$year/$month%02d/$day%02d"
    }.mkString(",")
  }

  @tailrec def daysInPeriod(from: DateTime, to: DateTime, days: List[DateTime] = Nil): List[DateTime] = {
    if (from.withMillisOfDay(0).isBefore(to))
      daysInPeriod(from.plusDays(1), to, from :: days)
    else
      days
  }