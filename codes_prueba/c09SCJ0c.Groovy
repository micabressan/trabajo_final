import java.time.Duration
import java.time.LocalDate
import java.time.Period
import java.time.temporal.ChronoUnit
import java.time.temporal.TemporalUnit

class Magic {

    def daysBetween(LocalDate from, LocalDate to) {
        def daysBetween = ChronoUnit.DAYS.between(from, to)
        (0..daysBetween).collect { days -> from.plusDays(days) }
    }
}

from = LocalDate.of(2017, 10, 1)
to = LocalDate.of(2017, 10, 31)

new Magic().daysBetween(from, to).collect { "path/year/$it.year/month/$it.monthValue/day/$it.dayOfMonth" }