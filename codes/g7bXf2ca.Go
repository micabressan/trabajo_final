package main

func main() {
	var sum int
	for i := 2; i < 2000000; i++ {
		if isPrime(i) {
			sum += i
		}
	}
	print(sum)
}

func isPrime(n int) bool {
	if n < 2 {
		return false
	}
	for q := 2; q < n; q++ {
		if n%q == 0 {
			return false
		}
	}
	return true
}