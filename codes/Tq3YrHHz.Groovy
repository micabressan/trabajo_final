	void testListAllMUSTReturnValidOpenclinicaStudies() {
		def factory = setUpMocks(listAllReturnXML)

		play {
			
			def soapClient = new OpenClinicaSoapClientImpl(factory, username, password)
			def actual = soapClient.listAll()

			def study1 = new OpenclinicaStudy(identifier: "default-study", OID: "S_DEFAULTS1", name:"Default Study")
			def study2 = new OpenclinicaStudy(identifier: "001", OID: "S_001", name: "Test Study")
			
			assertEquals actual[0], study1
			assertEquals actual[1], study2
		}
	}