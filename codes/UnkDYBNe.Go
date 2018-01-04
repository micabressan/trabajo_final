type WebPage struct {
	Url         *url.URL
	Domain      string
	Title       string
	Lang        string
	Keywords    string
	Charset     string
	Description string
	Content     string
	Links       []*url.URL
}