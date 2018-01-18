package semantic

import breeze.linalg._

object SemanticRunner extends App {

  class SemanticsManager(modelPath: String) {

    val model = new Word2Vec() //from https://github.com/trananh/word2vec-scala
    model.load(modelPath)

    def computeSemanticInfo(terms: List[String]): Array[Float] = {
      val vectors: List[DenseVector[Float]] = terms.map(term => DenseVector(model.vector(term)))
      val vectorSum: DenseVector[Float] = vectors.reduce(_ + _)
      val newFeatures: DenseVector[Float] = vectorSum.map(_ / terms.size)

      newFeatures.toArray
    }

  }

  val modelPath = "src/main/scala/semantic/model.bin"
  val terms = List("world", "house", "nature")
  val res = new SemanticsManager(modelPath).computeSemanticInfo(terms)

  println(res.toList)
}