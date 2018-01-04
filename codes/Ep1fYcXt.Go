func init() {
	db, err := sql.Open("postgres", config.DbConnectString)
        if err != nil {
	        log.Fatal(err)
	}
	defer db.Close()
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}
}

"db_connection_string": "host=localhost port=5432 user=user dbname=dbname sslmode=disable"