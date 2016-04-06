package controllers

import play.api._
import play.api.mvc._

import org.apache.spark._

import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

import org.apache.spark.sql.SQLContext	
import org.apache.spark.sql._
import org.apache.spark.sql.DataFrame 

import org.apache.spark.mllib.recommendation._
import org.apache.log4j.Logger

class Application extends Controller {

  def index = Action {

		//val sc = new SparkContext( new SparkConf( ) )

		val sc = new SparkContext("local",
				"Application","/home/elyphas/scala/spark141",
				List("target/scala-2.11/playsparkapp_2.11-1.0-SNAPSHOT.jar"))

		val sqlContext = new org.apache.spark.sql.SQLContext( sc )

		val URL = "jdbc:postgresql://10.51.253.252/sicap?user=postgres&password=jctaurys"

		val Query = "(select cve_depto as Area, cve_articulo as Articulo, sum(cantidad) as rat from qry_recomm where cve_articulo = '025.101.3407' group by cve_depto, cve_articulo) as recomendar"

		val Conex = URL

		//val df = sqlContext.load( "jdbc", Map("url"->URL, "dbtable"->Query ) )
		
		val url="jdbc:postgresql://10.51.253.252/sicap"
		val prop = new java.util.Properties
		
		prop.setProperty("user","postgres")
		prop.setProperty("password","jctaurys")		
		
		val df = sqlContext.read.jdbc( url, "tblartic", prop )
		
		df.collect.foreach(println)
		
		//println( df.count() )
		
		val trainData =  df.map { Record => 	//Convirtiendo de Row a Rating

			val dept:Option[Any] = Some( Record( 0 ) ) // Note using Any here
			val Depto = ( dept match {
				case Some( dept:Int ) => 
					dept // this extracts the value in a as an Int
				case _ =>
					0
			} )

			val art:String = Record( 1 ).toString

			val artic: String = art.filterNot( ".".toSet )

			val Rat: String = Record( 2 ).toString

			Rating( Depto, artic.toInt, Rat.toString.toInt )
		}		

		//El modelo resultado es una MatrixFactorizacionModel
		val model = ALS.trainImplicit( trainData, 10, 5, 0.04, 1.0 )
		
		println("Se entreno el modelo ALS")
		
		val Resultado = model.userFeatures.mapValues( _.mkString( ", " ) ).take( 10 )

		//Resultado.foreach{ println }
				
		Ok( views.html.index( "Probando jdbc Play and PostgreSQL" + Resultado ) )
		
		
  }

}