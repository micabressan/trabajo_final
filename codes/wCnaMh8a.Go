func Foo(x bool) bool {
	if x {
		fmt.Println("True)
		return !x
	} else {
		fmt.Println("False)
		return !x
	}

	panic("Code never reaches here")
}