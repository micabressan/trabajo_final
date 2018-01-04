  test("map divide 2") {
    new TestSets {
      val set: Set = (elem: Int) => List(2, 4, 12).contains(elem)
      def converter (elem: Int): Int = elem / 2
      assert(contains(map(set, converter), 1), "2 / 2 mapped to 1")
      assert(contains(map(set, converter), 2), "2 / 2 mapped to 1")
      assert(contains(map(set, converter), 6), "2 / 2 mapped to 1")
    }
  }

  test("map e => e - 1 to {1,3,4,5,7,1000} should be {[0,2,3,4,6],999}") {
    new TestSets {
      val set: Set = (elem: Int) => List(1,3,4,5,7,1000).contains(elem)
      def converter (elem: Int): Int = elem - 1
      assert(contains(map(set, converter), 0), "1 - 1 mapped to 0")
      assert(contains(map(set, converter), 999), "1000 - 1 mapped to 999")
    }
  }

  test("forall & map: doubling numbers") {
    new TestSets {
      val set: Set = (elem: Int) => List(1, 3, 4, 5, 7, 1000).contains(elem)
      def doubler(elem: Int): Int = elem * 2
      assert(forall(map(set, doubler), (elem: Int) => elem % 2 == 0), "The set obtained by doubling all numbers should contain only even numbers.")
    }
  }

  test("forall: {1,2,3,4}") {
    new TestSets {
      val set: Set = (elem: Int) => List(1, 2, 3, 4).contains(elem)
      assert(forall(set, (elem: Int) => elem < 5), "All elements in the set are strictly less than 5.")
    }
  }

  test("exists: given {1,3,4,5,7,1000}") {
    new TestSets {
      val set: Set = (elem: Int) => List(1, 3, 4, 5, 7, 1000).contains(elem)
      assert(!exists(set, (elem: Int) => elem == 2), "2 shouldn't exist in the given set.")
    }
  }

  test("forall: {-1000,0}") {
    new TestSets {
      val set: Set = (elem: Int) => List(-1000, 0).contains(elem)
      assert(forall(set, (elem: Int) => elem < 1000), "All elements in the set are strictly less than 1000.")
    }
  }

  test("exists & filter: even") {
    new TestSets {
      val set: Set = (elem: Int) => elem % 2 == 0
      assert(exists(set, (elem: Int) => elem % 2 == 1) === false, "The set of all even numbers should not contain odd element.")
    }
  }

  test("forall & filter: even") {
    new TestSets {
      val set: Set = (elem: Int) => elem % 2 == 0
      assert(forall(set, (elem: Int) => elem % 2 == 0), "The set of all even numbers should contain only even numbers.")
    }
  }