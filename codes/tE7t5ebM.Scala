  val genLeaf = for {
    e <- arbitrary[Int]
  } yield Leaf(e)

  val genNode = for {
    t1 <- genBTree
    t2 <- genBTree
  } yield Node(t1,t2)

  def genBTree: Gen[BTree[Int]] = oneOf(genLeaf,genNode)

  val propBTree = forAll(genBTree.sample){
    tree => treeToList[Int](treeMap[Int, Int](x => x + 1)(tree)) == treeToList[Int](tree).map(x => x + 1)
  }


[error] /home/georg/uni/umst3/ktdcw/group-7/aichernig/ktdcw-FP-09.scala:426:59: type mismatch;
[error]  found   : Option[ktdcw.G07.Task1to5.BTree[Int]]
[error]  required: ktdcw.G07.Task1to5.BTree[Int]
[error]     tree => treeToList[Int](treeMap[Int, Int](x => x + 1)(tree)) == treeToList[Int](tree).map(x => x + 1)
																	^						  ^