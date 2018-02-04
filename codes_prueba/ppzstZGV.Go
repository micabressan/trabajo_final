package main

	
import (
    "fmt"
    "log"
    "os"
    "time"
    "math/rand"
)


type matrix3x2 struct {
	a float32
	b float32
	c float32
	d float32
	e float32
	f float32
}

func transform2D(x float32, y float32, m matrix3x2) (float32, float32) {
	return (m.a*x + m.b*y + m.c), (m.d*x + m.e*y + m.f)
}


func main() {
	fmt.Println("GoFlame a fractal generator in Go")

	// size of the img
	const img_width = 1000
	const img_height = 1000
	const max_iter = 1e6


	fmt.Println("Width  = ", img_width)
	fmt.Println("Height = ", img_height)

	// create the img
	var img [img_width][img_height]int

	// create the point P that will travel
    s1 := rand.NewSource(time.Now().UnixNano())
    r1 := rand.New(s1)
	Px := r1.Float32()*2 - 1
	Py := r1.Float32()*2 - 1

	fmt.Println("Starting with (P.x, P.y) = (", Px, ", ", Py, ")")

	// all the 2D transformation matrices
	var m []matrix3x2
	m = append(m, matrix3x2{0.5, 0, 0, 0, 0.5, 0})
	m = append(m, matrix3x2{0.5, 0, 0.5, 0, 0.5, 0})
	m = append(m, matrix3x2{0.5, 0, 0, 0, 0.5, 0.5})

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

	for i:=0; i < img_width; i++ {
		for j:=0; j < img_height; j++ {
			img[i][j] = int(255*float32(img[i][j])/float32(max))
		}
	}

	// print to file
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
}