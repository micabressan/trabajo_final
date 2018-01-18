
import com.cra.figaro.language._
import com.cra.figaro.library.compound._
import com.cra.figaro.library.atomic._
import com.cra.figaro.library.collection._
import com.cra.figaro.algorithm.factored.VariableElimination
import com.cra.figaro.algorithm.sampling._
import com.cra.figaro.library.atomic.continuous._
import com.cra.figaro.algorithm.factored._
import com.cra.figaro.algorithm.factored.beliefpropagation._
import com.cra.figaro.library.atomic.discrete._
import com.cra.figaro.algorithm._

object Main {

abstract class State {
	val confident: Element[Boolean]
	def possession: Element[Boolean] =
	If(confident, Flip(0.7), Flip(0.3))
	}

class InitialState() extends State {
	val confident = Flip(0.4)
}
class NextState(current: State) extends State {
	val confident =
	If(current.confident, Flip(0.6), Flip(0.3))
}
// produce a state sequence in reverse order of the given length
	def stateSequence(n: Int): List[State] = {
		if (n == 0) List(new InitialState())
		else {
		val last :: rest = stateSequence(n - 1)
		new NextState(last) :: last :: rest
		}
	}

	def timing(obsSeq: List[Boolean]): Double = {
		//Universe.createNew() // ensures that each experiment is separate
		val stateSeq = stateSequence(obsSeq.length)
		for { i <- 0 until obsSeq.length } {
			stateSeq(i).possession.observe(obsSeq(obsSeq.length - 1 - i))
		}
		val alg = VariableElimination(stateSeq(0).confident)
		val time0 = System.currentTimeMillis()
		
		alg.start()
		val time1 = System.currentTimeMillis()
		(time1 - time0) / 1000.0 // inference time in seconds
	}

	def run(algorithm: OneTimeMPE, obsSeq: List[Boolean]) {
		//Universe.createNew() // ensures that each experiment is separate
		val stateSeq = stateSequence(obsSeq.length)
		for { i <- 0 until obsSeq.length } {
			stateSeq(i).possession.observe(obsSeq(obsSeq.length - 1 - i))
		}

		algorithm.start()
		for { i <- 0 until stateSeq.length - 1} {
				print(algorithm.mostLikelyValue(stateSeq(i).confident))
				print("\t")
				print(obsSeq(obsSeq.length - 1 - i))
				println()
		}
		println()
		algorithm.kill()
	}

	def main(args: Array[String]) {

		val steps = 30
		val obsSeq = List.fill(steps)(scala.util.Random.nextBoolean())
		// println(steps + ": " + timing(obsSeq))

		println("MPE variable elimination")
		run(MPEVariableElimination(), obsSeq)
		println("MPE belief propagation")
		//MPEBeliefPropagation takes the
		run(MPEBeliefPropagation(10), obsSeq)
		//number of BP iterations as argument.
		println("Simulated annealing")
		run(MetropolisHastingsAnnealer(100000, ProposalScheme.default,Schedule.default(1.0)), obsSeq)

	}
}