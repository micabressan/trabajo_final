def daysBetween(LocalDate from, LocalDate to) {
	def daysBetween = ChronoUnit.DAYS.between(from, to)
	(0..daysBetween).collect { days -> from.plusDays(days) }
}