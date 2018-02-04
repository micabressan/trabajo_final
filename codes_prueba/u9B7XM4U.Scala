  def rollback(): Unit = {
    BankApplication.console("Please enter the date to rollback to in the following format:")
    BankApplication.console("<year> <month> <date> <hour> <minute>")
    BankApplication.console("If the hour and minute does not matter the following format can be used:")
    BankApplication.console("<year> <month> <date>")
    val input = scala.io.StdIn.readLine()
    val xs = input.split(' ')
    var year = 0
    var month = 0
    var ddate = 0
    var hour = 23
    var minute = 59
    var date: Date = null
    try {
      if(xs.length == 5) {
        year = xs(0).toInt
        month = xs(1).toInt
        ddate = xs(2).toInt
        hour = xs(3).toInt
        minute = xs (4).toInt
      } else if (xs.length == 3) {
        year = xs(0).toInt
        month = xs(1).toInt
        ddate = xs(2).toInt
      } else {
        throw new NullPointerException
      }
      
      date = Date(year, month, ddate, hour, minute)
      var historyCopy = BankApplication.getCurrentBank().history().map(a => a)
      BankApplication.resetBank()
      for(historyEntry <- historyCopy) {
        if(historyEntry.date.compare(date) < 0) {
          BankApplication.getCurrentBank().doEvent(historyEntry.event)
        } else {
          historyCopy = Vector.empty[HistoryEntry]
        }
      }
    } catch {
      case _: DateTimeException => BankApplication.console("Invalid format of date!")
      case _: NullPointerException => {
        BankApplication.console("Correct format:")
        BankApplication.console("<year> <month> <date> (<hour> <minute>)")
      }
      case e: Exception => throw e
    }
  }