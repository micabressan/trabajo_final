func delayedFunction() {
	// Some code
}

func somethingElse() {
	delayFuncTimer = time.AfterFunc(delayTimerPeriod, delayedFunction())
}