func sockReader(ch chan trafChT, sock int) {
	var buf = make([]byte, 256)
	var trafCh = trafChT{}
	var err error

	for {
		_, err = syscall.Read(sock, buf)
		if err != nil {
			log.Fatal("reader 1:", err)
		}

		copy(trafCh.prefix[:], buf[prefixIdx:prefixIdxEnd])
		trafCh.traf = (uint64(buf[trafIdx]) * 256) + uint64(buf[trafIdxEnd])

		ch <- trafCh
	}
}