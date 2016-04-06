package DataBaseType

type UserPassport struct {
	UserID      int    `sql:"type:bigint;AUTO_INCREMENT"        gorm:"primary_key"`
	UserLogin   string `sql:"type:varchar(50)  ;not null"       gorm:"unique_index"`
	UserPass    string `sql:"type:varchar(200) ;not null"`
	UserSaltInt int    `sql:"type:bigint       ;not null"`
}

type UseApi struct {
	Id       int    `sql:"AUTO_INCREMENT"                gorm:"primary_key"`
	ApiKey   string `sql:"type:varchar(13)   ;not null"  gorm:"unique_index"`
	Salt     string `sql:"type:text          ;not null"`
	Domen    string `sql:"type:text          ;not null"`
	Location string `sql:"type:text          ;not null"`
}

type Token struct {
	Id     int    `sql:"AUTO_INCREMENT"                gorm:"primary_key"`
	UserId int    `sql:"type:bigint       ;not null"   gorm:"index"`
	token  string `sql:"type:text         ;not null"`
}

package main

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	"login/DataBaseType"
	//_ "github.com/lib/pq"
	//_ "github.com/mattn/go-sqlite3"
	"crypto/md5"
	"html/template"
	"io"
	"log"
	"net/http"
)

var db gorm.DB

func TemplateHtml(templateName string, p map[string]string, w http.ResponseWriter) {
	t, err := template.ParseFiles("html/" + templateName)
	if err != nil {
		return
	}
	t.Execute(w, p)
	w.Header().Set("Content-Type", "text/html")
}

func templateAuth(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	row := db.Table("use_api").Where("api_key  = ?", vars["keyApi"]).Select("salt").Row()

	h := md5.New()
	io.WriteString(h, vars["keyApi"])
	io.WriteString(h, row.Scan(&salt))

	if h.Sum(nil) == vars["hash"] {
		p := map[string]string{
			"title":  "Авторизация",
			"domen":  "localhost",
			"keyApi": vars["keyApi"],
			"hash":   vars["hash"],
		}

		TemplateHtml("login.html", p, w)
	} else {
		p := map[string]string{
			"err":   "Неверный хеш",
			"domen": "localhost",
		}

		TemplateHtml("err.html", p, w)
	}
}

func auth(w http.ResponseWriter, r *http.Request) {

}

func templateReg(w http.ResponseWriter, r *http.Request) {
	p := map[string]string{
		"title": "Авторизация",
		"domen": "localhost",
	}

	TemplateHtml("reg.html", p, w)
}

func reg(w http.ResponseWriter, r *http.Request) {

}

func migration(w http.ResponseWriter, r *http.Request) {
	db.Set("gorm:table_options", "ENGINE=InnoDB").CreateTable(&DataBaseType.UserPassport{})
	db.Set("gorm:table_options", "ENGINE=InnoDB").CreateTable(&DataBaseType.UseApi{})
	db.Set("gorm:table_options", "ENGINE=InnoDB").CreateTable(&DataBaseType.Token{})
}

func main() {
	dbConnect, err := gorm.Open("mysql", "root:parsh888@/login?charset=utf8&parseTime=True&loc=Local")
	dbConnect.DB()
	dbConnect.DB().Ping()
	dbConnect.DB().SetMaxIdleConns(10)
	dbConnect.DB().SetMaxOpenConns(100)
	dbConnect.SingularTable(true)
	if err != nil {
		log.Fatal(err)
	}
	db = dbConnect

	r := mux.NewRouter()
	r.HandleFunc("/migration", migration).Methods("GET")

	r.HandleFunc("/{keyApi}/{hash}", templateAuth).Methods("GET")
	r.HandleFunc("/{keyApi}/{hash}", auth).Methods("POST")

	r.HandleFunc("/reg", templateReg).Methods("GET")
	r.HandleFunc("/reg", reg).Methods("POST")

	log.Fatal(http.ListenAndServe(":8080", r))
}