package model

import "database/sql"

// File stores information about saved media
// struct fields prefixed with O indicate that
// the data is from the original file.
type File struct {
	ID int

	// URL is the location of the file
	URL string

	// Description describes the media
	Description string

	// ThumbnailURL is the URL of the thumbnail file
	ThumbnailURL string

	// ODescription stores the original video description
	ODescription string

	// OUploaded is the original timestamp of when this file was created
	OUploaded string

	// OAuthor is the original username of the author who uploaded this file
	OAuthor string

	// Uploaded is the timestamp of when the file was uploaded.
	Uploaded string

	// AuthorID is the ID of the user who uploaded the file
	// If the value is negative, it was from an anonymous user.
	AuthorID int
}

// CreateFile creates a file in the database
func (t *Tx) CreateFile(f File) File {
	return File{}
}

// DropFile drops a file from the database
func (t *Tx) DropFile(fileID int) File {
	return File{}
}

// Files retrieves files from the database
//     offset : offset to obtain files from
//     limit  : limit of files to select
func (t *Tx) Files(offset, limit int) ([]File, error) {
	var rows *sql.Rows
	if limit > 0 || offset > 0 {
		r, err := t.tx.Query("SELECT * FROM files LIMIT $1 OFFSET $2", limit, offset)
		if err != nil {
			return nil, err
		}
		rows = r
	} else {
		r, err := t.tx.Query("SELECT * FROM FILES")
		if err != nil {
			return nil, err
		}
		rows = r
	}
	defer rows.Close()
	return t.ScanFiles(rows)
}

// ScanFiles scans an sql result set into files
func (t *Tx) ScanFiles(rows *sql.Rows) ([]File, error) {
	files := []File{}

	for rows.Next() {
		f, err := t.ScanFile(rows)
		if err != nil {
			return files, err
		}
		files = append(files, f)
	}

	return files, nil
}

// ScanFile scans an SQL rows result set into a file struct
func (t *Tx) ScanFile(rows *sql.Rows) (File, error) {
	f := File{}

	err := rows.Scan(
		&f.ID,
		&f.URL,
		&f.Description,
		&f.ThumbnailURL,
		&f.ODescription,
		&f.OUploaded,
		&f.OAuthor,
		&f.Uploaded,
		&f.AuthorID)
	if err != nil {
		return f, err
	}

	return f, nil
}

// FileCount returns the number of files
func (t *Tx) FileCount() int {
	var count int
	if err := t.tx.QueryRow("select COUNT(*) FROM files").Scan(&count); err != nil {
		return -1
	}
	return count
}