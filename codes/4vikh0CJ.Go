package main

import(
	"html/template"
    "net/http"
)

var templates = template.Must(template.ParseGlob("templates/*"))

func main(){
	http.HandleFunc("/", IndexHandler)
	http.Handle("/img/", http.StripPrefix("/img/", http.FileServer(http.Dir("web/img"))))
	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("web/css"))))
	http.Handle("/js/", http.StripPrefix("/js/", http.FileServer(http.Dir("web/js"))))
    http.ListenAndServe(":8080", nil)
}

func IndexHandler(w http.ResponseWriter, r *http.Request) {

    // you access the cached templates with the defined name, not the filename
    err := templates.ExecuteTemplate(w, "index", nil)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
}