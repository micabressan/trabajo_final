object ArrayMedianApp extends App {

    def isEven(number: Int) = number % 2 == 0
    def isOdd(number: Int) = !isEven(number)

    def medianArithmetic(number_1: Int, number_2: Int): Double = (number_1 + number_2).toDouble/2

    def searchMedian(collection: Seq[Int]): Double = {
        if (collection.isEmpty) {
            throw new IllegalArgumentException("Collection should no be empty")
        }

        val sortedCollection = collection.sorted
        val collectionSize = sortedCollection.size
        val medianIndex = collectionSize/2
        if (isOdd(collectionSize)) {
            sortedCollection(collectionSize/2)
        } else {
            medianArithmetic(sortedCollection(medianIndex - 1), sortedCollection(medianIndex))
        }
    }

    val median2 = searchMedian(Seq(1))
    val median3 = searchMedian(Seq(2, 1))
    val median4 = searchMedian(Seq(2, 1, 14))
    val median5 = searchMedian(Seq(2, 1, 14, 7))

}