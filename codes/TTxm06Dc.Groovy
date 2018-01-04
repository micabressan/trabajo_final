def store = [:]; 
rootNode.someNode.each { (store['someKey'] ? store['someKey'] = [it.someVal]  ? store['someKey'] << it.someVal) }