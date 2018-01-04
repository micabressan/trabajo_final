import org.apache.spark.rdd.RDD
import org.apache.spark.mllib.fpm.FPGrowth
import org.apache.spark.mllib.fpm.AssociationRules.Rule
import org.apache.spark.sql.hive.HiveContext
import sqlContext.implicits._
 
val data = sqlContext.sql("select DISTINCT transaction_id,sku from wrt.wrt_bundles_fp")
 
val transactions = data.map(r => (r.getDecimal(0), Seq(r.getDecimal(1)))).reduceByKey(_ ++ _).map(e => e._2.toArray).filter(a => a.size >2)

transactions.cache()
 
val fpg = new FPGrowth().setMinSupport(0.0002).setNumPartitions(100)
 
 
val model = fpg.run(transactions)
model.freqItemsets.collect().foreach { itemset => println(itemset.items.mkString("[", ",", "]") + ", " + itemset.freq)}

val minConfidence = 0.2
val modelList = model.generateAssociationRules(minConfidence).collect()

val results = for(rule <- modelList) yield { case(rule:org.apache.spark.mllib.fpm.AssociationRules.Rule[BigDecimal]) => (rule.antecedent.mkString("[", ",", "]"), rule.consequent .mkString("[", ",", "]"), rule.confidence)}

model.generateAssociationRules(minConfidence).collect().foreach { rule => if(rule.consequent.size > 1) rule.consequent .mkString("[", ",", "]")}

val resultRDD = sc.parallelize(modelList)

val finalResultRDD = resultRDD.map(rule => (rule.antecedent.mkString("[", ",", "]"), rule.consequent .mkString("[", ",", "]"), rule.confidence))

finalResultRDD.toDF().write.mode(SaveMode.Overwrite).saveAsTable("wrt.bundles_test")