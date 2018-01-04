// does NOT conflict
final bool trace ()
final void trace (const(char[]) fmt, ...)

// conflicts :( but why?
final bool trace ()
final void trace (const(char)[] format, S...)(S arguments)