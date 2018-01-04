class Magic {
    def filesInBetween(long from, long to) {
        def fromDate = epochTimeToDate(from)
        def toDate = epochTimeToDate(to)
        daysBetween(fromDate, toDate).collect(this.&formatDate)
    }

    def daysBetween(LocalDate from, LocalDate to) {
        def daysBetween = ChronoUnit.DAYS.between(from, to)
        (0..daysBetween).collect { days -> from.plusDays(days) }
    }

    def epochTimeToDate(long unixTime) {
        Instant
            .ofEpochMilli(unixTime)
            .atZone(ZoneId.of("UTC"))
            .toLocalDate()
    }

    def formatDate(LocalDate date) {
        String.format("/path/year/%2d/month/%2d/day/%2d", date.year, date.monthValue, date.dayOfMonth)
    }
}