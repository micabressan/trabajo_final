package main

import "image"
import "image/color"
import "golang.org/x/tour/pic"

type Image struct{}

func (i Image) ColorModel() color.Model {
	return color.RGBAModel
}

func (i Image) Bounds() image.Rectangle {
	return image.Rectangle{
		Min: image.Point{0, 0},
		Max: image.Point{255, 255},
	}
}

func (i Image) At(x, y int) color.Color {
	return color.NRGBA{
		R: uint8(x % 256),
		G: uint8(y % 256),
		B: uint8((x * y) % 256),
		A: 255,
	}
}

func main() {
	m := Image{}
	pic.ShowImage(m)
}