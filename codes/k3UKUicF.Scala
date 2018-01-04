//================ Code 1 ================\\

trait Root {
	def foo(): Unit = println("Root")
}

trait Middle extends Root {
	override def foo(): Unit
}

class Final extends Middle {
}

//================ Code 2 ================\\

trait Root {
	def foo(): Unit = println("Root")
}

abstract class Middle extends Root {
	override def foo(): Unit
}

class Final extends Middle {
}