  /*
    Based on the algorithm from page 10.

    for:
      A = {a, b, c, d}
      I = {(a, d), (d, a), (b, c), (c, b)}
      w = badacb

    build:

      | * | b |
      | a | * | * | * |
      | a | * | * | d |
      | * | * | * | * |
      | * | b | c | * |
      -----------------
        a   b   c   d

  */
  def buildStacks(): Map[Char, ListBuffer[Char]] = {
    val (alphabet, actionSeq) = (problemData.alphabet, problemData.actionSequence)
    val stacks = alphabet.map((_, ListBuffer.empty[Char])).toMap

    actionSeq
      .reverse
      .foreach { x =>
        stacks(x) += x
        stacks.keys
          .filterNot(_ == x)
          .filterNot(isIndependent(x, _))
          .foreach(stacks(_) += MARKER)
      }

    stacks
  }

  def calculateFoataForm(stacks: Map[Char, ListBuffer[Char]]): String = {
    val fnf = new StringBuffer()
    val stacksCopy = mutable.Map(stacks.toSeq: _*)

    while (stacksCopy.values.exists(_.nonEmpty)) {
      val lettersOnTop =
        stacksCopy.values
          .map(_.lastOption)
          .collect { case Some(l) => l }
          .filterNot(_ == MARKER)
          .toList
          .sorted

      lettersOnTop.foreach { letterOnTop =>
        stacksCopy
          .filterNot { case (letter, _) => isIndependent(letterOnTop, letter) }
          .foreach { case (letter, stack) => stacksCopy.update(letter, stack.init) }
      }

      fnf.append(s"(${lettersOnTop.mkString("")})")
    }

    fnf.toString
  }