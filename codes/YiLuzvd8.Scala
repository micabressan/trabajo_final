#!/usr/bin/env amm

/**
Script to perform speedtest using multiple parallel threads.

This is written using Ammonite: http://ammonite.io/#ScalaScripts

Ammonite can be installed using the following command:

sudo curl -L -o /usr/local/bin/amm https://git.io/vdNv2 && sudo chmod +x /usr/local/bin/amm && amm

To run the script first make it executable:

chmod a+x speedtest.sc

To run with default parameters:

./speedtest.sc

To override parameters you need to add -- followed by extra arguments

--parallels 4
  Number of threads

--url
  URL to download

--periods 5
  Number of periods
  
Example:

./speedtest.sc -- --periods 10

*/

val bufferSize = 1*1024*1024

sealed trait ChannelData
case class SpeedData(thread: Int, time: Long, size: Long) extends ChannelData
case class Done(thread: Int) extends ChannelData

val channel = new scala.concurrent.Channel[ChannelData]

def downloadOnce(thread: Int, urlString: String) = new Thread {
  override def run: Unit = {
    val buffer = new Array[Byte](bufferSize)
    val url = new java.net.URL(urlString)
    val stream = url.openStream
    var bytesRead = 0
    def loop: Unit = stream.read(buffer) match {
      case n if n <= 0 =>
        channel.write(Done(thread))
      case n =>
        channel.write(SpeedData(thread,System.currentTimeMillis,n))
        loop
    }
    loop
  }
}.start

@main
def main(parallels: Int = 4, url: String = "http://ookla1.kviknet.dk:8080/download?nocache=x&size=500000000", periods: Int = 5) = {
  println(f"Downloading from $url using $parallels threads.")
  val begin = System.currentTimeMillis
  for(n <- 1 to parallels) downloadOnce(n,url)
  val builder = new scala.collection.immutable.VectorBuilder[SpeedData]
  var doneCount = 0
  while(doneCount < parallels) {
    channel.read match {
      case sd @ SpeedData(_,_,_) => builder += sd
      case Done(thread) => doneCount = doneCount + 1
    }
  }
  val end = System.currentTimeMillis
  val data = builder.result
  val total = data.map(_.size).sum
  println(f"Downloaded $total bytes in ${end-begin} ms = ${total*8/(end-begin)/1000} Mbps.")
  def groupFun(t: Long) = (((t-begin).toDouble / (end-begin))*periods).toInt
  val groupedData = data.groupBy( d => groupFun(d.time)).mapValues(_.map(_.size).sum)
  for(n <- 1 to periods) {
    val size = groupedData.get(n-1).getOrElse(0L)
    println(f"Period $n downloaded $size bytes in ${(end-begin)/periods} ms = ${size*8/((end-begin)/periods)/1000} Mbps.")
  }
}