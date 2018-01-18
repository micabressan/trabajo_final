import scala.collection.mutable.ArrayBuffer

def collatz(n:Int) = collatz_rek(n, ArrayBuffer[Int]()).toArray

def collatz_rec(n:Int, arr:ArrayBuffer[Int]):ArrayBuffer[Int] = {
	n match {
		case 1			=> arr += 1
		case n if n % 2 == 0 	=> collatz_rec(n / 2, arr += n)
		case _			=> collatz_rec(3 * n + 1, arr += n)
	}
}