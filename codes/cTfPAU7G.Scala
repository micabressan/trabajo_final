val profit: Array[Element[Double]] = Array.fill(length)(Constant(0)) // 0, 1, 2, 3

		val investment: Array[Element[Double]] = Array.fill(length)(Constant(0))

		val capital: Array[Element[Double]] = Array.fill(length)(Constant(0))

		val good_profit: Array[Element[Boolean]] = Array.fill(length)(Constant(false))

		capital(0) = Constant(10)
		investment(0) = Constant(3)
		profit(0) = Constant(0)

		for {i <- 1 until length} {

			profit(i) = Uniform(investment(i - 1) * Constant(1), investment(i - 1) * Constant(0.8), investment(i - 1) * Constant(1.2))
			capital(i) = Apply(capital(i - 1), profit(i), investment(i - 1), add)
			investment(i) = capital(i) * Constant(0.3)
		}