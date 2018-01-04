import scala.io.Source

case class IntermediaryScore(score: Int = 0, garbageScore: Int = 0, level: Int = 0, ignoreNext: Boolean = false, garbage: Boolean = false) {
  def ignore: Boolean = ignoreNext || garbage
}

def tallyScore(input: String): IntermediaryScore =
  input.foldLeft(IntermediaryScore())((is: IntermediaryScore, char) => char match {
    case '{' if !is.ignore => is.copy(level = is.level + 1)
    case '}' if !is.ignore && is.level > 0 => is.copy(score = is.score + is.level, level = is.level - 1)
    case '<' if !is.ignore => is.copy(garbage = true)
    case '>' if is.garbage && !is.ignoreNext => is.copy(garbage = false)
    case '!' if !is.ignoreNext => is.copy(ignoreNext = true)
    case _ if is.ignoreNext => is.copy(ignoreNext = false)
    case _ if is.garbage => is.copy(garbageScore = is.garbageScore + 1)
    case _ => is
  })

val input = Source.fromFile("/Users/ryan.alspaugh/Documents/projects/advent-of-code/inputs/day-9.txt").getLines.mkString

tallyScore(input).score
tallyScore(input).garbageScore