type SafeMap struct {
    // The map is stored in a buffered channel so only
    // one thread can access it at a time.
    chan map[int]int
}

func NewSafeMap() *SafeMap {
    mapChan := make(chan map[int]int, 1)
    mapChan <- make(map[int]int)
    return &SafeMap{mapChan}
}

func (s *SafeMap) Put(k int, v int) {
    map := <-mapChan
    map[k] = v
    mapChan <- map
}