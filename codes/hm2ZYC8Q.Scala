  /**
    * Calculate the frequency table for pages within a session data frame
    */
  def calculateViewFreq(df: DataFrame, nss: Seq[Int], useEntity: Boolean) : RDD[(Int, Int)] = {
    import df.sqlContext.implicits._
    import org.apache.spark.sql.functions._

    val idField = if (useEntity) "wikidata_id" else "page_id"

    df.withColumn("view", explode(df("views")))
      .select("client_hash", "view.namespace_id", "view." + idField)
      .where(if (useEntity) lit(true) else $"namespace_id".isin(nss:_*))
      .groupBy(idField)
      .agg(countDistinct('client_hash))
      .map { row => (row.getInt(0), row.getLong(1).toInt) }
  }