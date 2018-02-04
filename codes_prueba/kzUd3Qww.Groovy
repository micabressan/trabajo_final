// unformatted script
String formatFieldAsTimeString(String timeString) {
    OffsetDateTime dateTime = OffsetDateTime.parse(timeString, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
    OffsetDateTime dateTimeAtUTC = dateTime.withOffsetSameInstant(ZoneOffset.UTC);
    LocalTime localTimeAtUTC = dateTimeAtUTC.toLocalTime();
    return DateTimeFormatter.ofPattern("HH:mm:ss").format(localTimeAtUTC);
}
 
ctx._source.evtFiredTime = formatFieldAsTimeString(ctx._source.evtFired);
ctx._source.evtStoppedTime = formatFieldAsTimeString(ctx._source.evtStopped);
 
// minified
String formatFieldAsTimeString(String timeString) { OffsetDateTime dateTime = OffsetDateTime.parse(timeString, DateTimeFormatter.ISO_OFFSET_DATE_TIME); OffsetDateTime dateTimeAtUTC = dateTime.withOffsetSameInstant(ZoneOffset.UTC); LocalTime localTimeAtUTC = dateTimeAtUTC.toLocalTime(); return DateTimeFormatter.ofPattern(\"HH:mm:ss\").format(localTimeAtUTC);}ctx._source.evtFiredTime = formatFieldAsTimeString(ctx._source.evtFired);ctx._source.evtStoppedTime = formatFieldAsTimeString(ctx._source.evtStopped);