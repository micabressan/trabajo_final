package main

import (
	"bytes"
	"go/format"
	"io/ioutil"
	"strings"
	"text/template"
)

// TmplData ..
type tmplData struct {
	Pkgname string
	Schemas []schemaConfig
}

type schemaConfig struct {
	Name string
	Pkey string
}

var schema = `
{{define "schema"}}
package {{ .Pkgname }}

import "database/sql"

{{- range .Schemas }}
// Schema{{ title .Name }} defines the schema for a {{ .Name }} database
const Schema{{ title .Name }} = ` + "`" + `
CREATE TABLE IF NOT EXISTS files (
	id           {{ .Pkey }},
	url          TEXT NOT NULL,
	sourceurl    TEXT NOT NULL,
	mediatype    TEXT NOT NULL,
	title        TEXT NOT NULL,
	description  TEXT NOT NULL,     
	thumbnailurl TEXT NOT NULL,
	odescription TEXT NOT NULL,
	ouploaded    TEXT NOT NULL,
	oauthor      TEXT NOT NULL,
	uploaded     INTEGER NOT NULL,
	authorid     INTEGER NOT NULL,
	deleted      INTEGER NOT NULL,
	hash         TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
	id           {{ .Pkey }},
	username     TEXT NOT NULL,
	avatarurl    TEXT NOT NULL,
	joined       TEXT NOT NULL,
	salt         TEXT NOT NULL,
	passwordhash TEXT NOT NULL,
	role         INTEGER NOT NULL,
	settings     TEXT NOT NULL,
	banned       INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS user_sessions (
	id            {{ .Pkey }},
	key           TEXT NOT NULL,
	expires       INTEGER NOT NULL,
	user_id       INTEGER NOT NULL, 
	UNIQUE(key),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS collections (
	id            {{ .Pkey }},
	name          TEXT NOT NULL,
	description   TEXT NOT NULL,
	thumbnailurl  TEXT NOT NULL,
	author_id     INT NOT NULL,
	uploaded      INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS collection_files (
	id            {{ .Pkey }},
	file_id       INTEGER NOT NULL,
	collection_id INTEGER NOT NULL,
	UNIQUE(file_id, collection_id),
	FOREIGN KEY(file_id)       REFERENCES files(id),
	FOREIGN KEY(collection_id) REFERENCES collections(id)
);

CREATE TABLE IF NOT EXISTS tags (
	id       {{ .Pkey }},
	name     TEXT NOT NULL,
	UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_tags (
	id        {{ .Pkey }},
	file_id   INTEGER NOT NULL,
	tag_id    INTEGER NOT NULL,
	UNIQUE(file_id, tag_id),
	FOREIGN KEY(file_id) REFERENCES files(id),
	FOREIGN KEY(tag_id)  REFERENCES tags(id)
);` + "`" + `

{{- end}}

// InitDB Initializes a database with the proper schema
func InitDB(db *sql.DB, driver string) error {
	// Initialize the database

	var schema string

	switch driver {
	{{- range .Schemas }}
	case "{{.Name}}":
		schema = Schema{{title .Name}}
	{{- end}}
	default:
		schema = Schema{{title ((index .Schemas 0).Name)}}
	}

	return nil
}

{{ end }}
`

func main() {
	var dest bytes.Buffer

	tmpl := template.New("")
	tmpl.Funcs(template.FuncMap{
		"title": strings.Title,
	})
	template.Must(tmpl.Parse(schema))
	tmpl.ExecuteTemplate(&dest, "schema", tmplData{
		Pkgname: "west",
		Schemas: []schemaConfig{
			schemaConfig{
				Name: "postgres",
				Pkey: "SERIAL PRIMARY KEY",
			},
			schemaConfig{
				Name: "sqlite3",
				Pkey: "INTEGER PRIMARY KEY AUTOINCREMENT",
			},
			schemaConfig{
				Name: "mysql",
				Pkey: "INTEGER PRIMARY KEY AUTO_INCREMENT",
			},
		},
	})

	formatted, err := format.Source(dest.Bytes())
	if err != nil {
		ioutil.WriteFile("schema_error.txt", dest.Bytes(), 0600)
		panic(err)
	}

	ioutil.WriteFile("schemas.gen.go", formatted, 0600)
}