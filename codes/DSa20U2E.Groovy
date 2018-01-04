 def "FindPath should return length 13 and route 1-2-5-3-6"() {
        given:
        def nodeNr1 = new Node(1, Node.NodeType.ENTRY, [], [])
        def nodeNr2 = new Node(2, Node.NodeType.REGULAR, [], [])
        def nodeNr3 = new Node(3, Node.NodeType.REGULAR, [], [])
        def nodeNr4 = new Node(4, Node.NodeType.REGULAR, [], [])
        def nodeNr5 = new Node(5, Node.NodeType.REGULAR, [], [])
        def nodeNr6 = new Node(6, Node.NodeType.EXIT, [], [])

        def connection1To3 = new Connection(nodeNr1, nodeNr3, 5)
        def connection1To2 = new Connection(nodeNr1, nodeNr2, 3)
        def connection2To4 = new Connection(nodeNr2, nodeNr4, 5)
        def connection2To5 = new Connection(nodeNr2, nodeNr5, 4)
        def connection5To3 = new Connection(nodeNr5, nodeNr3, 3)
        def connection3To6 = new Connection(nodeNr3, nodeNr6, 3)
        def connection4To6 = new Connection(nodeNr4, nodeNr6, 1)
        def connection5To6 = new Connection(nodeNr5, nodeNr6, 4)

        nodeNr1.setOutgoing([connection1To3, connection1To2])
        nodeNr2.setOutgoing([connection2To4, connection2To5])
        nodeNr3.setOutgoing([connection3To6])
        nodeNr4.setOutgoing([connection4To6])
        nodeNr5.setOutgoing([connection5To3, connection5To6])

        nodeNr2.setIncoming([connection1To2])
        nodeNr3.setIncoming([connection1To3, connection5To3])
        nodeNr4.setIncoming([connection2To4])
        nodeNr5.setIncoming([connection2To5])
        nodeNr6.setIncoming([connection3To6, connection4To6, connection5To6])

        when:
        def result = strategy.findPath(nodeNr1)
        then:
        result == new PathStrategy.Result([1, 2, 5, 3, 6], 13)
    }