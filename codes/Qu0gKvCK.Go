package memcache

type Memcache struct {}

func (r *Memcache) Set(key string, val []byte) {
    // not relevant
}

func (r *Memcache)  Get(key string) ([]byte, error) {
    // not relevant
}

func New() *Memcache {
	return &Memcache{}
}