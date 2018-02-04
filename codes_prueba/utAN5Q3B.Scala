// GENERATOR!
  
  val genLeaf = for {
    e <- arbitrary[Int]
  } yield Leaf(e)

  val genNode = for {
    t1 <- genBTree
    t2 <- genBTree
  } yield Node(t1,t2)

  def genBTree: Gen[BTree[Int]] = oneOf(genLeaf,genNode)

// PROPERTY!

  val propBTree = forAll(genBTree){
    (tree : BTree[Int]) =>
    treeToList[Int](treeMap[Int, Int](x => x + 1)(tree)) ==
    treeToList[Int](tree).map(x => x + 1)
  }

// Testing??

 ktdcw.G07.Task1to5.propBTree.check


// ERROR!!!

! Exception raised on property evaluation.
> Exception: java.lang.NullPointerException: null
org.scalacheck.Gen$$anonfun$flatMap$1$$anonfun$apply$1.apply(Gen.scala:55)
org.scalacheck.Gen$$anonfun$flatMap$1$$anonfun$apply$1.apply(Gen.scala:55)
org.scalacheck.Gen$R$class.flatMap(Gen.scala:191)
org.scalacheck.Gen$R$$anon$3.flatMap(Gen.scala:176)
org.scalacheck.Gen$$anonfun$flatMap$1.apply(Gen.scala:55)