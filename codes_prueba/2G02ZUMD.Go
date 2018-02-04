package main

import (
	_ "github.com/go-sql-driver/mysql"
	"database/sql"
	"fmt"
)

func main() {

	db, err := sql.Open("mysql", "root:gtplfdfujy@(10.100.86.9:3306)/ctsa_test?charset=utf8")
	checkErr(err)

	// query
	query, err := db.Prepare(`
		SELECT
			p.process
		FROM ctsa_test.users u
		join ctsa.processinfo p on u.login = p.username
		WHERE ora_user_id = 3184027
	`)
	checkErr(err)
	defer query.Close()

	var process string

	query.QueryRow().Scan(&process)

	fmt.Println(process)
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}