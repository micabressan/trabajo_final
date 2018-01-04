class DateRage {
    LocalDate from
    LocalDate to

    static DateRage forUnixSeconds(long from, long to) {
        new DateRage(from: epochTimeToDate(from), to: epochTimeToDate(to))
    }

    def getDays() {
        def daysBetween = ChronoUnit.DAYS.between(from, to)
        (0..daysBetween).collect { from.plusDays(it) }
    }

    private static def epochTimeToDate(long unixTime) {
        Instant
            .ofEpochSecond(unixTime)
            .atZone(ZoneId.of("UTC"))
            .toLocalDate()
    }
}

class Magic {
    def filesInBetween(long from, long to) {
        DateRage.forUnixSeconds(from, to).days.collect(this.&format)
    }


    def format(LocalDate date) {
        String.format("/path/year/%02d/month/%02d/day/%02d", date.year, date.monthValue, date.dayOfMonth)
    }
}

new Magic().filesInBetween(1509494400, 1509494400 + 24 * 3600 - 1)