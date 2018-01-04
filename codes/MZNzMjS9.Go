type Chan chan int

type T struct {
	Chan
	name string
}


func test() {
	t := new(T)

	t<- 5   // This is currently illegal
	t.Chan<- 5  // This is OK
}