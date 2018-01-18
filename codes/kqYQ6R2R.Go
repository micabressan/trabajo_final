type Foo struct {
	img image.Image
}

func main() {
	var f Foo
	if f.img == nil {
		f.img = SomeImage()
	}
	DoStuff(f.img)
}