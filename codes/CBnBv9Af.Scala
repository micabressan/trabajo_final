// import org.anduril.core.readers.networkParser._

    val tooLongRecord=MY_VERY_LONG_RECORD_OF_INSTANCES
    type recordDataType=CSV
    val outputPort="out"
    
    val splitTo=(tooLongRecord.size.toDouble/99).toInt+1
    if (splitTo > 20 ) {// note, max 20. 
        severe("Record has more than 20*99 elements, joining not simple")
        throw new java.lang.IllegalArgumentException("Record too long")
    }
    val outer=Record[Record[recordDataType]]("outer")
    for (i <- 1 to splitTo) {
        outer(i)=Record[recordDataType]("inner")
    }
    for ( (j,i) <- tooLongRecord.values.zipWithIndex ) {
        outer(i%splitTo+1)(i+1)=j(outputPort).asInstanceOf[recordDataType]
    }
    val joiner=Record[recordDataType]("joiner")
    val jArgs = scala.collection.mutable.Map[String,Any]()
    for (i <- 1 to splitTo) {
        joiner(i)=rec2Array(outer(i))
        jArgs("array"+(i)) = joiner(i)
    }
    val comb=Tools.invokeComponentByName("anduril.builtin.ArrayCombiner", jArgs)
    val combPort=Tools.getPortByName(comb,"array")

    val joined_to_folder=Array2Folder(combPort)