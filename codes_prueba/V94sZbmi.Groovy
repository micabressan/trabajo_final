import java.sql.Timestamp
import java.time.Duration
import java.time.Instant
import java.time.LocalDate
import java.time.Period
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit
import java.time.temporal.TemporalUnit

class Magic {
    def filesInBetween(long from, long to) {
        def fromDate = epochTimeToDate(from)
        def toDate = epochTimeToDate(to)
        println("$fromDate $toDate")
        daysBetween(fromDate, toDate).collect(this.&formatDate)
    }

    def daysBetween(LocalDate from, LocalDate to) {
        def daysBetween = ChronoUnit.DAYS.between(from, to)
        (0..daysBetween).collect { days -> from.plusDays(days) }
    }

    def epochTimeToDate(long unixTime) {
        Instant
            .ofEpochSecond(unixTime)
            .atZone(ZoneId.of("UTC"))
            .toLocalDate()
    }

    def formatDate(LocalDate date) {
        String.format("/path/year/%02d/month/%02d/day/%02d", date.year, date.monthValue, date.dayOfMonth)
    }
}

new Magic().filesInBetween(1509505200, 1509591599)