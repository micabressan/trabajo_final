type Opt func(options *Options)

type Options struct {
	timeout int
}


func SendRequest(url string, opts... Opt) {
	options := &Options{}
	for _, opt := range	opts {
		opt(options)
	}
}

func Timeout(timeout int) Opt {
	return func(options *Options) {
		options.timeout = timeout
	}
}

func main() {
	SendRequest("http://ya.ru", Timeout(5))
}