	public HashMap<Integer, Integer> getPrimeDecomp(float nbre) {
		HashMap<Integer, Integer> primes = new HashMap<Integer, Integer>();

		for (int actualDivisor = 2; actualDivisor <= nbre; ++actualDivisor) {
			if (isPrime(actualDivisor) || actualDivisor != 2) {
				while (nbre % actualDivisor == 0) {
					primes.put(
							actualDivisor,
							primes.containsKey(actualDivisor) ? primes
									.get(actualDivisor) + 1 : 1);
					nbre /= actualDivisor;
				}
			}
		}

		return primes;
	}