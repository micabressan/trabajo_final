      import org.apache.spark.sql.functions._
      import spark.implicits._

      object Eqs {
        val m0 = 0.938271

        def p(t: Column, thx: Column, thy: Column): Column =
          -sqrt(t / (pow(thx, 2) + pow(thy, 2)))

        def E(p: Column): Column =
          sqrt(pow(p / m0, 2) + 1) * m0

        def beta(p1: Column, p2: Column, e1: Column, e2: Column): Column =
          (p1 + p2) / (e1 + e2)

        def gamma(beta: Column): Column =
          pow(sqrt(-pow(abs(beta), 2) + 1), -1)

        def p_prime(t: Column, E: Column, beta: Column, gamma: Column): Column =
          t + (gamma - 1) * ((t * beta) / pow(abs(beta), 2)) * beta - gamma * E * beta
      }

      val t1 = $"rec_prot_pair.tl"
      val thx1 = $"rec_prot_pair.thxl"
      val thy1 = $"rec_prot_pair.thyl"
      val p1 = Eqs.p(t1, thx1, thy1)
      val E1 = Eqs.E(p1)

      val t2 = $"rec_prot_pair.tr"
      val thx2 = $"rec_prot_pair.thxr"
      val thy2 = $"rec_prot_pair.thyr"
      val p2 = Eqs.p(t2, thx2, thy2)
      val E2 = Eqs.E(p2)

      val beta = Eqs.beta(p1, p2, E1, E2)
      val gamma = Eqs.gamma(beta)

      val p_prime1 = Eqs.p_prime(t1, E1, beta, gamma)
      val p_prime2 = Eqs.p_prime(t2, E2, beta, gamma)