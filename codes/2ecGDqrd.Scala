package week5

/**
  * Created by henry on 2.12.2017.
  */


class AnagramSolver(words: Set[String], minLength: Int) {

  type Word = String

  type Sentence = List[Word]

  type Occurrences = List[(Char, Int)]

  def sentenceAnagrams(input: String): Unit = {
    val sentenceOccurrences = getSentenceOccurrences(input.split(" ").toList)
    val combs = combinations(sentenceOccurrences)
    for (comb <- combs) {
      val remainingCombinations = subtract(sentenceOccurrences, comb)
      val words = wordAnagrams(comb)
      if (words.nonEmpty)
        println(words)
    }
  }

  def wordOccurrences(word: Word): Occurrences = word.groupBy(elem => elem).map(entry => (entry._1, entry._2.size)).toList.sorted

  def getSentenceOccurrences(sentence: Sentence): Occurrences = wordOccurrences(sentence.mkString)

  lazy val dictionaryByOccurrences: Map[Occurrences, List[Word]] = words.groupBy(elem => wordOccurrences(elem)).map(entry => (entry._1, entry._2.toList))

  def wordAnagrams(occurrences: Occurrences): List[Word] = {
    if (dictionaryByOccurrences.contains(occurrences)) {
      dictionaryByOccurrences(occurrences)
    } else {
      Nil
    }
  }

  def combinations(occurrences: Occurrences): List[Occurrences] = {

    def helper(list: Occurrences, tagastus: Occurrences): List[Occurrences] = list match {
      case Nil => List(tagastus)
      case x :: saba => {
        for (nr <- 0 to x._2) yield {if (nr == 0) helper(saba, tagastus) else helper(saba, (x._1, nr) :: tagastus)}
      }.flatten.toList
    }
    helper(occurrences, List.empty[(Char, Int)]).map(_.sorted)
  }

  def subtract(x: Occurrences, y: Occurrences): Occurrences = {
    for (
      xEl <- x;
      yEl <- y
    ) yield {
      if (xEl._1 == yEl._1) (xEl._1, xEl._2 - yEl._2)
      else xEl
    }
  }

}


object AnagramSolver {

  def dictionary(len: Int): Set[String] =
    io.Source.fromFile("lemmad2013.txt").getLines().filter(_.length >= len).toSet

  def main(args: Array[String]): Unit = {
    val minLength = 4
    val solver = new AnagramSolver(dictionary(minLength), minLength)
    //solver.sentenceAnagrams("janar saks")
    val l1 = List(('a',2), ('b', 3), ('c', 5))
    val l2 = List(('b', 2))
    print(solver.subtract(l1, l2))
    //print(solver.dictionaryByOccurrences(List(('e',1), ('i',1), ('k',1), ('r',1))))
    //println(solver.combinations(List(('a', 2), ('b', 2))).toSet)
  }

}