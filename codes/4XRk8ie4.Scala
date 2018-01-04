import org.apache.spark.ml.evaluation.MulticlassClassificationEvaluator
import org.apache.spark.sql.{SparkSession}
import org.apache.spark.ml.classification.{LogisticRegression, NaiveBayes}
import org.apache.spark.ml.feature.{Tokenizer, HashingTF, IDF}
import org.apache.spark.sql.functions._
import org.apache.log4j.Logger
import org.apache.log4j.Level
import org.apache.spark.sql.types._
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.regression.DecisionTreeRegressionModel
import org.apache.spark.ml.regression.DecisionTreeRegressor
import org.apache.spark.ml.feature.VectorAssembler

object reviews2 {

  def main(args: Array[String]): Unit = {

    /*###################################################*/
    /*           Read the train and test datasets        */
    /*###################################################*/
    Logger.getLogger("org").setLevel(Level.OFF)
    Logger.getLogger("akka").setLevel(Level.OFF)

    // Create the spark session first
    val ss = SparkSession.builder().master("local").appName("tfidfApp").getOrCreate()
    import ss.implicits._ // For implicit conversions like converting RDDs to DataFrames
    val TraininputFile = "./data/train.csv"
    val TestinputFile = "./data/test.csv"


    println("reading from input file: " + TraininputFile)
    println

    //Read the train and the test datasets
    val TrainbasicDF = ss.read.option("header", "true").csv(TraininputFile)
    TrainbasicDF.printSchema()

    val TestbasicDf = ss.read.option("header", "true").csv(TestinputFile)
    TestbasicDf.printSchema()

    val TestreviewsDF = TestbasicDf
    TestreviewsDF.repartition(5)
    val TrainreviewsDf = TrainbasicDF
    TrainreviewsDf.repartition(4)


    /*###################################################*/
    /*                   Pre-Processing                  */
    /*###################################################*/
    /*###################################################*/
    /*                   Train-Dataset                   */
    /*###################################################*/

    //sampling
    //TrainreviewsDf.sample(withReplacement = ,fraction,seed)
    val sampledTrainreviews = TrainreviewsDf.sample(false,0.1)
    val a1=TrainreviewsDf.count()
    val a2=sampledTrainreviews.count()
    println("Sampled:", a2 )
    println("Real data:", a1)

    val tokenizer = new Tokenizer().setInputCol("product_title").setOutputCol("rWordsTitle")
    val TrainwordsDF = tokenizer.transform(sampledTrainreviews)
    TrainwordsDF.printSchema()

    val hashingTF = new HashingTF().setInputCol("rWordsTitle").setOutputCol("rRawFeatures")
    val TrainfeaturizedDF = hashingTF.transform(TrainwordsDF)
    TrainfeaturizedDF.printSchema()


    val idf = new IDF().setInputCol("rRawFeatures").setOutputCol("rFeatures")
    val idfM = idf.fit(TrainfeaturizedDF)
    val TrainidfDF = idfM.transform(TrainfeaturizedDF)
    TrainidfDF.printSchema()

    TrainidfDF.select("id", "relevance").take(3).foreach(println)

    val udf_toDouble = udf((s: String) => s.toDouble)

    TrainidfDF.withColumn("relevance", 'relevance cast DoubleType)
    val TraincompleteDf = TrainidfDF.select($"id", $"rFeatures", $"relevance", udf_toDouble($"relevance").as("dRelevance"))
    TraincompleteDf.printSchema()

    TrainreviewsDf.withColumn("relevance", 'relevance cast DoubleType)
    val TrainreviewsDf2 = TrainidfDF.select($"id", $"product_title", $"relevance", udf_toDouble($"relevance").as("Rrelevance"))
    TrainreviewsDf2.printSchema()
    // Split the data into training and test sets (30% held out for testing).
     val Array(trainingData, testData) = TraincompleteDf.randomSplit(Array(0.7, 0.3))
    //val Array(trainingData, testData) = TrainreviewsDf2.randomSplit(Array(0.7,0.3))
    //    trainingData.select("product_title","relevance").take(5).foreach(println)
    println("pok")
    trainingData.printSchema()

    //We need a vector in order to train our data
    val assembler= new VectorAssembler().setInputCols(Array("rFeatures")).setOutputCol("features")

    // Train a DecisionTree model.
    val dt = new DecisionTreeRegressor()
      .setLabelCol("dRelevance")
      .setFeaturesCol("rFeatures")
      .setMaxDepth(5)
      .setMaxBins(15)

    // Chain indexer and tree in a Pipeline.
    //val pipeline = new Pipeline()
     // .setStages(Array(tokenizer,hashingTF,idf,assembler, dt))
    println("pok")

    // Train model. This also runs the indexer.
    //val model = pipeline.fit(trainingData)
    val trainingDataSampled = trainingData.sample(false,0.1)
    val miniskaki = trainingDataSampled.count()
    println("ssssss")
    println(miniskaki)
    val model=dt.fit(trainingDataSampled)
    println("gamiswwwwwwww")
    // Make predictions.
    val miniskos = testData.count()
    println("dsdsdsdsdsdsdsds")
    println(miniskos)
    val predictions = model.transform(testData)

    println("------------------")
    predictions.printSchema()
    println("------------------")
    // Select example rows to display.
    predictions.select("prediction", "dRelevance", "rFeatures").show(5)

    // Select (prediction, true label) and compute test error.
    val evaluator = new RegressionEvaluator()
      .setLabelCol("rFeatures")
      .setPredictionCol("prediction")
      .setMetricName("rmse")
    val rmse = evaluator.evaluate(predictions)
    println("Root Mean Squared Error (RMSE) on test data = " + rmse)

    //val treeModel = model.stages(1).asInstanceOf[DecisionTreeRegressionModel]
   // println("Learned regression tree model:\n" + treeModel.toDebugString)

  }
}