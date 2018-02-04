//execution time 2.301 seconds

package main

func main() {
	var sum int64
	primes := sieve(2000000)
	for i := 0; i < len(primes)-1; i++ {
		sum += int64(primes[i])
	}
	print(sum)
}

func sieve(n int64) (primes []int64) {
	notPrime := make(map[int64]bool)
	for i := int64(2); i <= n; i++ {
		for j := i * i; j < n; j += i {
			notPrime[j] = true
		}
	}
	for i := int64(2); i <= n; i++ {
		if notPrime[i] == false {
			primes = append(primes, int64(i))
		}
	}
	return
}