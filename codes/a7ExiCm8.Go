package redis

type Redis struct {}

func (r *Redis) Set(key string, val []byte) {
    // not relevant
}

func (r *Redis)  Get(key string) ([]byte, error) {
    // not relevant
}

func New() *Redis {
	return &Redis{}
}