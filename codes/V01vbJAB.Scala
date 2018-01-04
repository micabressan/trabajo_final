        // trovo la prima colonna in base alla trasposta
        val finalMatrixTrasposta = getTrasposta(finalMatrix)
        val listOfMax = for (i <- 0 until m) yield finalMatrixTrasposta(i).max
//        println(listOfMax)
        val firstColumn = listOfMax.indexOf(listOfMax.min)
//        println("\n" + firstColumn)

        // trovo le altre a partire dalla prima
        val sequenceArray = Array.ofDim[Int](m)
        sequenceArray(0) = firstColumn
        for (i <- 1 until m) {
            // per la colonna attuale, prendo il massimo della riga corrispondente alla colonna precedente
            sequenceArray(i) = finalMatrix(sequenceArray(i-1)).indexOf(finalMatrix(sequenceArray(i-1)).max)
        }