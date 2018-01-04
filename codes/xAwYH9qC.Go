package west

import "database/sql"

// SchemaPostgres defines the schema for a postgres database
const SchemaPostgres = `
CREATE TABLE IF NOT EXISTS files (
	id           SERIAL PRIMARY KEY,
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
	id           SERIAL PRIMARY KEY,
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
	id            SERIAL PRIMARY KEY,
	key           TEXT NOT NULL,
	expires       INTEGER NOT NULL,
	user_id       INTEGER NOT NULL, 
	UNIQUE(key),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS collections (
	id            SERIAL PRIMARY KEY,
	name          TEXT NOT NULL,
	description   TEXT NOT NULL,
	thumbnailurl  TEXT NOT NULL,
	author_id     INT NOT NULL,
	uploaded      INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS collection_files (
	id            SERIAL PRIMARY KEY,
	file_id       INTEGER NOT NULL,
	collection_id INTEGER NOT NULL,
	UNIQUE(file_id, collection_id),
	FOREIGN KEY(file_id)       REFERENCES files(id),
	FOREIGN KEY(collection_id) REFERENCES collections(id)
);

CREATE TABLE IF NOT EXISTS tags (
	id       SERIAL PRIMARY KEY,
	name     TEXT NOT NULL,
	UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_tags (
	id        SERIAL PRIMARY KEY,
	file_id   INTEGER NOT NULL,
	tag_id    INTEGER NOT NULL,
	UNIQUE(file_id, tag_id),
	FOREIGN KEY(file_id) REFERENCES files(id),
	FOREIGN KEY(tag_id)  REFERENCES tags(id)
);`

// SchemaSqlite3 defines the schema for a sqlite3 database
const SchemaSqlite3 = `
CREATE TABLE IF NOT EXISTS files (
	id           INTEGER PRIMARY KEY AUTOINCREMENT,
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
	id           INTEGER PRIMARY KEY AUTOINCREMENT,
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
	id            INTEGER PRIMARY KEY AUTOINCREMENT,
	key           TEXT NOT NULL,
	expires       INTEGER NOT NULL,
	user_id       INTEGER NOT NULL, 
	UNIQUE(key),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS collections (
	id            INTEGER PRIMARY KEY AUTOINCREMENT,
	name          TEXT NOT NULL,
	description   TEXT NOT NULL,
	thumbnailurl  TEXT NOT NULL,
	author_id     INT NOT NULL,
	uploaded      INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS collection_files (
	id            INTEGER PRIMARY KEY AUTOINCREMENT,
	file_id       INTEGER NOT NULL,
	collection_id INTEGER NOT NULL,
	UNIQUE(file_id, collection_id),
	FOREIGN KEY(file_id)       REFERENCES files(id),
	FOREIGN KEY(collection_id) REFERENCES collections(id)
);

CREATE TABLE IF NOT EXISTS tags (
	id       INTEGER PRIMARY KEY AUTOINCREMENT,
	name     TEXT NOT NULL,
	UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_tags (
	id        INTEGER PRIMARY KEY AUTOINCREMENT,
	file_id   INTEGER NOT NULL,
	tag_id    INTEGER NOT NULL,
	UNIQUE(file_id, tag_id),
	FOREIGN KEY(file_id) REFERENCES files(id),
	FOREIGN KEY(tag_id)  REFERENCES tags(id)
);`

// SchemaMysql defines the schema for a mysql database
const SchemaMysql = `
CREATE TABLE IF NOT EXISTS files (
	id           INTEGER PRIMARY KEY AUTO_INCREMENT,
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
	id           INTEGER PRIMARY KEY AUTO_INCREMENT,
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
	id            INTEGER PRIMARY KEY AUTO_INCREMENT,
	key           TEXT NOT NULL,
	expires       INTEGER NOT NULL,
	user_id       INTEGER NOT NULL, 
	UNIQUE(key),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS collections (
	id            INTEGER PRIMARY KEY AUTO_INCREMENT,
	name          TEXT NOT NULL,
	description   TEXT NOT NULL,
	thumbnailurl  TEXT NOT NULL,
	author_id     INT NOT NULL,
	uploaded      INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS collection_files (
	id            INTEGER PRIMARY KEY AUTO_INCREMENT,
	file_id       INTEGER NOT NULL,
	collection_id INTEGER NOT NULL,
	UNIQUE(file_id, collection_id),
	FOREIGN KEY(file_id)       REFERENCES files(id),
	FOREIGN KEY(collection_id) REFERENCES collections(id)
);

CREATE TABLE IF NOT EXISTS tags (
	id       INTEGER PRIMARY KEY AUTO_INCREMENT,
	name     TEXT NOT NULL,
	UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_tags (
	id        INTEGER PRIMARY KEY AUTO_INCREMENT,
	file_id   INTEGER NOT NULL,
	tag_id    INTEGER NOT NULL,
	UNIQUE(file_id, tag_id),
	FOREIGN KEY(file_id) REFERENCES files(id),
	FOREIGN KEY(tag_id)  REFERENCES tags(id)
);`

// InitDB Initializes a database with the proper schema
func InitDB(db *sql.DB, driver string) error {
	// Initialize the database

	var schema string

	switch driver {
	case "postgres":
		schema = SchemaPostgres
	case "sqlite3":
		schema = SchemaSqlite3
	case "mysql":
		schema = SchemaMysql
	default:
		schema = SchemaPostgres
	}

	return nil
}