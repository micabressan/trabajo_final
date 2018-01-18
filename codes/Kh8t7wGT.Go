// batches returns a channel of k-size permuted batches
func batches(data []Datum, k int) chan []Datum {
	c := make(chan []Datum)
	go func() {
		i := 0
		p := rand.Perm(len(data))
		for {
			batch := make([]Datum, k)
			for j := 0; j < k; j++ {
				batch[j] = data[p[i]]
				i = (i + 1) % len(data)
			}
			c <- batch
		}
	}()
	return c
}