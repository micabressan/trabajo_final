package main

	
import (
    "fmt"
    "log"
    "os"
    "time"
    "math"
    "math/rand"
    "image"
    "image/png"
)


type matrix3x2 struct {
	a float64
	b float64
	c float64
	d float64
	e float64
	f float64
}

func transform2D(x float64, y float64, m matrix3x2) (float64, float64) {
	return math.Sin(m.a*x + m.b*y + m.c), math.Sin(m.d*x + m.e*y + m.f)
}


func main() {
	fmt.Println("GoFlame a fractal generator in Go")

	// size of the img
	const img_width = 1000
	const img_height = 1000
	const max_iter = 1e7


	fmt.Println("Width  = ", img_width)
	fmt.Println("Height = ", img_height)

	// create the img
	var img [img_width][img_height]int

	// create the point P that will travel
    s1 := rand.NewSource(time.Now().UnixNano())
    r1 := rand.New(s1)
	Px := r1.Float64()*2 - 1
	Py := r1.Float64()*2 - 1

	fmt.Println("Starting with (P.x, P.y) = (", Px, ", ", Py, ")")

	// all the 2D transformation matrices
	var m []matrix3x2
	m = append(m, matrix3x2{0.5, 0, 0, 0, 0.5, 0})
	m = append(m, matrix3x2{0.5, 0, 0.5, 0, 0.5, 0})
	m = append(m, matrix3x2{0.5, 0, 0, 0, 0.5, 0.5})
	m = append(m, matrix3x2{1, 0, 0, 0, 1, 0})
	m = append(m, matrix3x2{-1, 0, 0, 0, 1, 0})
	m = append(m, matrix3x2{-1, 0, 0, 0, -1, 0})
	m = append(m, matrix3x2{1, 0, 0, 0, -1, 0})

	for i:=0; i < max_iter; i++ {
		n_rnd := r1.Intn(len(m))
		Px, Py = transform2D(Px, Py, m[n_rnd])
		
		Px_idx := int(img_width * (Px+1)/2.0 )
		Py_idx := int(img_height * (Py+1)/2.0 ) 
		if (Px_idx < img_width) && (Py_idx < img_height) {
			img[Px_idx][Py_idx]++
		}
	}

	max := 0
	for i:=0; i < img_width; i++ {
		for j:=0; j < img_height; j++ {
			if img[i][j] > max {
				max = img[i][j]
			}
		}
	}

	fmt.Println("Maximum value in hist = ", max)

	fractal_img := image.NewRGBA(image.Rect(0, 0, img_width, img_height))

	for i:=0; i < img_width; i++ {
		for j:=0; j < img_height; j++ {
			img[i][j] = int(255*float64(img[i][j])/float64(max))
			pix := uint8(255*float64(img[i][j])/float64(max))
			fractal_img.Pix[(i*img_width + j)*4] = pix
			fractal_img.Pix[(i*img_width + j)*4 + 1] = pix
			fractal_img.Pix[(i*img_width + j)*4 + 2] = pix
			fractal_img.Pix[(i*img_width + j)*4 + 3] = 255
		}
	}

	// print to pgm file
    file, err := os.Create("result.pgm")
    if err != nil {
        log.Fatal("Cannot create file", err)
    }
    defer file.Close()

    fmt.Fprintf(file, "P2\n%d %d\n255\n", img_width, img_height)
    
    for i:=0; i < img_width; i++ {
    	for j:=0; j < img_height; j++ {
    		fmt.Fprintf(file, "%d ", img[i][j])
    	}
    	fmt.Fprintf(file, "\n")
    }

    // print to png file
    // outputFile is a File type which satisfies Writer interface
    outputFile, err := os.Create("test.png")
    if err != nil {
    	// Handle error
    }

    // Encode takes a writer interface and an image interface
    // We pass it the File and the RGBA
    png.Encode(outputFile, fractal_img)

    // Don't forget to close files
    outputFile.Close()
}