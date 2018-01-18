type Foo struct {
	img image.Image
}

func main() {
	var f Foo
	var img image.Image
	if f.img != nil { // f.img has been set before
		img = f.img
	} else {
		img = SomeImage()
		f.img = img
	}

	DoStuff(img)
}