
  implicit val system: ActorSystem = ActorSystem("hello")
  implicit val mat: ActorMaterializer = ActorMaterializer()
  
  val queue = Source.queue[String](3, akka.stream.OverflowStrategy.backpressure)
    .throttle(1, 1.second, 1, ThrottleMode.shaping)
    .to(Sink foreach println)
    .run()

  queue offer "1"
  queue offer "2"
  queue offer "3"
  queue offer "4"
  queue offer "5"
  queue offer "6"
  queue offer "7"
  queue offer "8"
  queue offer "9"
  queue offer "10"
  queue offer "11"
  queue offer "12"
  queue offer "13"
  println("superkek")
  queue offer "14"
//outputs:
//  superkek
//  1
//  2
//  3
//  4
//  5
//  6