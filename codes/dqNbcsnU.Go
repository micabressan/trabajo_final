// Returns the number of characters printed.
// Assume v > 0.
func putint(v int) int {
	if v == 0 {
		putchar('0')
		return 1
	}
	
	var charCount int = 0
	for v > 0 {
		defer putchar('0' + v % 10);
		charCount++
		v /= 10
	}

	return charCount
}