Main.scala (consumer)

import java.util.Properties

import org.apache.kafka.clients.producer.{KafkaProducer, ProducerRecord}
import org.apache.kafka.streams._

object Main {

  def main(args: Array[String]): Unit = {
    println("Hello, Scala developer!")

    val properties = new Properties()
    properties.put(StreamsConfig.APPLICATION_ID_CONFIG, "scala-stream-test")
    properties.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092")
    properties.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer")
    properties.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer")

    val builder = new StreamsBuilder()
    val stream = builder.stream("test")

    val producer = new KafkaProducer[String, String](properties)

    val topic = "test";

    for(i <- 1 to 10){
      val record = new ProducerRecord(topic, "key", s"hello $i")
      producer.send(record)
      Thread.sleep(500)
    }

    val record = new ProducerRecord(topic, "key", "the end "+ new java.util.Date)
    producer.send(record)

    producer.close()
  }



}


======= project/build.properties ======
sbt.version=1.1.0-RC1


============== hello-world/build.sbt ======
libraryDependencies += "org.apache.kafka" %% "kafka" % "1.0.0"
// https://mvnrepository.com/artifact/org.apache.kafka/kafka-streams
libraryDependencies += "org.apache.kafka" % "kafka-streams" % "1.0.0"