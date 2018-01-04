type Resource struct {
	Name         string
	LastAnalyzed string
	Url          *url.URL
	Status       string
	StatusCode   int
	LastModified string
	Type         string
	Links        []*Resource
	Assets       []*Resource
}