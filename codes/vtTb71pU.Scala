object Program2 {
  def main(args: Array[String]): Unit = {
    //format argumentu dd mm yy
    val day = args(0)
    val month = args(1)
    val year = args(2)

    val flightsRDD = Array("2000,1,28,1647,1647,1906,1859", "2000,1,29,1648,1647,1939,1859", "2000,1,31,1645,1647,1852,1859", "2000,1,1,842,846,1057,1101", "2000,1,2,849,846,1148,1101", "2000,1,2,930,900,1354,1400")
    val flightsSplitData = flightsRDD.filter((line) => line.contains("NA") != true).map(line => line.split(','))
    val flightsForGivenDay = flightsSplitData.filter((data) => {
      data(0) == year && data(1) == month && data(2) == day
    })
    if (flightsForGivenDay.isEmpty) {
      println("No flights occured that day.")
    }
    else {
      val sumOfDelays = flightsForGivenDay.map(data=>{
        calculateDelaysForTakeoffAndLanding(data(3),data(4),data(5),data(6))
      }).reduce((a, b) => a+b)
      println(f"Sum of delays in minutes: $sumOfDelays.")
    }
  }

  def calculateDelaysForTakeoffAndLanding(actualTakeOffTime : String, plannedTakeoffTime : String, actualLandingTime : String, plannedLandingTime : String): Integer ={
    val (actualTakeoffHours, actualTakeoffMinutes) = timeHHMMtoInts(actualTakeOffTime)
    val (plannedTakeoffHours, plannedTakeoffMinutes) = timeHHMMtoInts(plannedTakeoffTime)
    val (actualLandingHours, actualLandingMinutes) = timeHHMMtoInts(actualLandingTime)
    val (plannedLandingHours, plannedLandingMinutes) = timeHHMMtoInts(plannedLandingTime)
    timeDiffInMinutes(actualTakeoffHours, actualTakeoffMinutes, plannedTakeoffHours, plannedTakeoffMinutes) + timeDiffInMinutes(actualLandingHours, actualLandingMinutes, plannedLandingHours, plannedLandingMinutes)
  }

  def timeHHMMtoInts(timeString : String): (Integer, Integer) ={
    if (timeString.length == 3){ //moze byc HMM
      (timeString.substring(0,1).toInt, timeString.substring(1,3).toInt)
    }
    else {
      (timeString.substring(0,2).toInt, timeString.substring(2,4).toInt)
    }
  }

  def timeDiffInMinutes(timeFirstHours : Integer, timeFirstMinutes : Integer, timeSecondHours : Integer, timeSecondMinutes : Integer): Integer ={
    math.abs(timeFirstHours* 60 + timeFirstMinutes - timeSecondHours * 60 - timeSecondMinutes)
  }
}