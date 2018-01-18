class TransactionManagementTest extends FunSuite with TransactionManagement {

	private val db = new EmbeddedDatabaseBuilder().addDefaultScripts().build()

	private val template = new SimpleJdbcTemplate(db)

	val transactionManager = new DataSourceTransactionManager(db)

	test("default") {
		transactional() {
			val args = Map("id" -> 3, "first_name" -> "John", "last_name" -> "Johnson").asJava
			template.update("INSERT INTO USERS(ID, FIRST_NAME, LAST_NAME) VALUES (:id, :first_name, :last_name)", args)
		}
		expect(1) {
			template.queryForInt("SELECT COUNT(ID) FROM USERS WHERE ID = 3")
		}
	}

	test("exception") {
		transactional(rollbackFor = Seq(classOf[IOException])) {
			val args = Map("id" -> 4, "first_name" -> "John", "last_name" -> "Johnson").asJava
			template.update("INSERT INTO USERS(ID, FIRST_NAME, LAST_NAME) VALUES (:id, :first_name, :last_name)",
				args)
			
			throw new IOException("Undo!")
		}
		expect(0) {
			template.queryForInt("SELECT COUNT(ID) FROM USERS WHERE ID = 4")
		}
	}

	test("custom parameters") (pending)

}