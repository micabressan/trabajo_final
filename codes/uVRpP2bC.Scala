package week4

import org.scalatest.FunSuite
import week5.AnagramSolver
import week5.AnagramSolver.dictionary

class Kodu4Suite extends FunSuite{
  val words1 = Set("aa", "bb")
  val words2 = Set("aa", "bb", "ab", "a")
  val solver = new AnagramSolver(words1, 2)
  val solve2 = new AnagramSolver(words2, 2)

  test("test_equality") {
    val anagrams1 = solver.sentenceAnagrams("baba")
    val anagrams2 = solver.sentenceAnagrams("abab")
    val anagrams3 = solver.sentenceAnagrams("ab ab")
    val anagrams4 = solver.sentenceAnagrams("a b a b")
    val anagrams5 = solver.sentenceAnagrams("b a b a")
    val anagrams6 = solver.sentenceAnagrams("B,:A\"b?A!")
    assert(anagrams1 == anagrams2)
    assert(anagrams2 == anagrams3)
    assert(anagrams3 == anagrams4)
    assert(anagrams4 == anagrams5)
    assert(anagrams5 == anagrams6)
  }

  test("test_values1") {
    val anagrams = solver.sentenceAnagrams("baba")
    assert(anagrams.size == 2)
    assert(anagrams.contains("aa bb"))
    assert(anagrams.contains("bb aa"))
  }

  test("test_values2") {
    val anagrams = solve2.sentenceAnagrams("baba")
    assert(anagrams.size == 3)
    assert(anagrams.contains("aa bb"))
    assert(anagrams.contains("bb aa"))
    assert(anagrams.contains("ab ab"))
  }


  }