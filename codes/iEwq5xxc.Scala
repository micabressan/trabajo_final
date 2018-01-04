  @tailrec def daysInPeriod(currentDay: DateTime, endDay: DateTime, days: List[DateTime] = Nil): List[DateTime] = {
    if (currentDay.withMillisOfDay(0).isBefore(endDay))
      daysInPeriod(currentDay.plusDays(1), endDay, currentDay :: days)
    else
      days
  }