val sqlContext = new org.apache.spark.sql.SQLContext(sc)
val df = sqlContext.read.parquet("/user/zhinkin/sessions_parquet/2017-12-12.parquet/sessions-r-*.gz.parquet")
val resDF = df.filter(($"_vid".isNotNull) && ($"location".contains(".perekrestok.ru"))).select("_vid", "depth", "duration_ms", "bounce", "utm_source")
val seqDF = sc.sequenceFile[String, String]("/user/reporter/seg-idx/2017-12-12.seq").map { case (seg_val, vid_InSegCnt) => {
    val Array(seg, value) = seg_val.split("\t")
    val Array(_vid, inSegCount) = vid_InSegCnt.split("\t")
    // (seg.toString, value.toString, _vid.toString, inSegCount.toString)
    (seg, value, _vid, inSegCount)
    }
}.toDF("seg", "value", "_vid", "inSegCount")

val joinedSessionDF = seqDF.join(resDF, Seq("_vid"), "inner").filter(($"depth".isNotNull) && ($"duration_ms".isNotNull))//.toDF("seg", "value", "_vid", "inSegCount", "depth", "duration_ms", "bounce", "utm_source")

val idxStratDF = sc.sequenceFile[String, String]("/user/reporter/idx/2017-12-12.seq").map { case (event_strat, _vid_times) => {
    val Array(event, strat) = event_strat.split("#")
    val Array(_vid, times) = _vid_times.split("\t")
    (_vid, strat)
    }
}
.filter{
    case (vid, strat) => (strat != "12264")
}.map(_._1).filter(_.nonEmpty).toDF("_vid")

val joinedSessionNoRetDF = joinedSessionDF.join(idxStratDF, Seq("_vid"), "inner")

joinedSessionNoRetDF.show(10)