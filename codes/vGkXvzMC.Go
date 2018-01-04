c := make(chan string)

for i := 1; i <= 5; i++ {
	go func(i int, co chan<- string) {
		for j := 1; j <= 5; j++ {
			co <- fmt.Sprintf("hi from %d.%d", i, j)
		}
	}(i, c)
}

for i := 1; i <= 25; i++ {
	fmt.Println(<-c)
}