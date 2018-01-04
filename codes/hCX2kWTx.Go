package main

import (
	"image"
	_ "image/png"
	"log"
	"os"

	"github.com/andlabs/ui"
)

var pic image.Image

type areaHandlerDraw struct {
	a  *ui.Area
	dp *ui.AreaDrawParams
}

func (t areaHandlerDraw) Draw(a *ui.Area, dp *ui.AreaDrawParams) {

	var brush ui.Brush
	brush.Type = ui.Solid

	for x := 0; x < pic.Bounds().Max.X; x++ {
		for y := 0; y < pic.Bounds().Max.Y; y++ {
			var p = ui.NewPath(ui.Winding)
			var sp ui.StrokeParams
			r, g, b, alpha := pic.At(x, y).RGBA()
			
			brush.A = float64(alpha / (65536 / 100))
			brush.R = float64(r / (65536 / 100))
			brush.G = float64(g / (65536 / 100))
			brush.B = float64(b / (65536 / 100))
			p.NewFigure(float64(x), float64(y))
			p.LineTo(float64(x), float64(y))
			p.CloseFigure()
			p.End()
			sp.Thickness = 1.0
			sp.Cap = ui.FlatCap
			sp.Join = ui.RoundJoin
			dp.Context.Stroke(p, &brush, &sp)
			p.Free()
			//dp.Context.Save()
		}
	}

	return
}

func (t areaHandlerDraw) MouseEvent(a *ui.Area, me *ui.AreaMouseEvent) {
	return
}

func (t areaHandlerDraw) MouseCrossed(a *ui.Area, left bool) {
	return
}

func (t areaHandlerDraw) DragBroken(a *ui.Area) {
	return
}

func (t areaHandlerDraw) KeyEvent(a *ui.Area, ke *ui.AreaKeyEvent) (handled bool) {
	return
}

func main() {

	err := ui.Main(func() {

		reader, err := os.Open("test.png")
		if err != nil {
			log.Fatal(err)
		}
		defer reader.Close()

		pic, _, err = image.Decode(reader)
		if err != nil {
			log.Fatal(err)
		}
		a := areaHandlerDraw{nil, nil}

		logo := ui.NewArea(a)

		logo.Show()
		button := ui.NewButton("OK")
		greeting := ui.NewLabel("")
		box := ui.NewVerticalBox()
		box.Append(ui.NewLabel("Enter your name:"), false)
		box.Append(logo, true)
		box.Append(button, false)
		box.Append(greeting, false)
		window := ui.NewWindow("Hello", 201, 165, false)
		window.SetChild(box)
		button.OnClicked(func(*ui.Button) {
			//greeting.SetText("Hello, " + name.Text() + "!")
		})
		window.OnClosing(func(*ui.Window) bool {
			ui.Quit()
			return true
		})
		window.Show()
	})
	if err != nil {
		panic(err)
	}
}