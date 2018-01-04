val ssc = new StreamingContext(sc)
   
val stream = ssc.receiverStream(new MyReceiver)
   
stream.filter(line => line.contains("Accepted"))
.map(line => (line.split.(0)+" "+line.split.(1), (1, 0))
.reduceByKey((a, b) => a + b)
..........
stream.filter(line => line.contains("Failed"))
.map(line => (line.split.(0)+" "+line.split.(1), (0, 1))
.reduceByKey((a, b) => a + b)
..........
.print()
ssc.start()
ssc.awaitTermination()