class TransactionManagementTest extends FunSuite with TransactionManagement {

	private val db = new EmbeddedDatabaseBuilder().addDefaultScripts().build()

	private val template = new SimpleJdbcTemplate(db)

	val transactionManager = new DataSourceTransactionManager(db)

	test("default") {

		transactional() {
			template.update("INSERT INTO USERS(ID, FIRST_NAME, LAST_NAME) VALUES (:id, :first_name, :last_name)",
				Map("id" -> 3, "first_name" -> "John", "last_name" -> "Johnson"))
		}

	}

	test("custom parameters") (pending)

}