	def injectSubjectKeys(def doc, def subjectKeys) {

		def subjectKeyGroup = doc.breadthFirst().group.find {it.@id.equals('1')}
		subjectKeyGroup.select1.each { subject ->
			subjectKeys.each{ key ->
				println("${subject - ${key}")
//				Node itemNode = new Node(it, "item", [id:it])
//				addItemElements(itemNode)
			}
		}
	}