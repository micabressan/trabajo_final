var counter int

func Test1(t *testing.T) {
	t.Error(counter)
	counter++
}

func Test2(t *testing.T) {
	t.Error(counter)
	counter++
}

func Test3(t *testing.T) {
	t.Error(counter)
	counter++
}

func Test4(t *testing.T) {
	t.Error(counter)
	counter++
}