package main

import (
	"encoding/json"
	"log"

	"github.com/go-pg/pg"
)

type User struct {
	ID              int64
	PretendUsername string
	Identity        *UserIdentity
	IdentityID      int64
}

type UserIdentity struct {
	ID            int64
	UserID        int64
	Username      string
	PreferredName string
}

func main() {
	db := pg.Connect(&pg.Options{
		User:     "marceline",
		Password: "marceline",
		Addr:     "localhost:5432",
		Database: "marcelinetest",
	})

	err := db.DropTable(&User{}, nil)
	if err != nil {
		log.Println(err)
	}
	err = db.CreateTable(&User{}, nil)
	if err != nil {
		panic(err)
	}
	err = db.DropTable(&UserIdentity{}, nil)
	if err != nil {
		log.Println(err)
	}
	err = db.CreateTable(&UserIdentity{}, nil)
	if err != nil {
		panic(err)
	}

	var user User
	user.PretendUsername = "test2"
	user.Identity = &UserIdentity{Username: "test2"}

	log.Println(db.Insert(user.Identity))
	user.IdentityID = user.Identity.ID
	log.Println(db.Insert(&user))

	var user2 User
	db.Model(&user2).Column("user.*", "Identity").Limit(1).Select()
	user2J, _ := json.Marshal(user2)
	user2JS := string(user2J)

	log.Println(user2JS)

}