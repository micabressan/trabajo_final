package main

import (
	"strings"
	"fmt"
)

type Positie struct {
	y int
	x int
}

func main() {
	vierkant := rooster(4, ">>>>^<^v^v^^>>v>")
	fmt.Println(tekst(vierkant))

	fmt.Printf("%#v\n", stap(vierkant, Positie{y: 3, x: 0}))
	fmt.Println(tekst(vierkant))
	fmt.Printf("%#v\n", stap(vierkant, Positie{y: 3, x: 1}))
	fmt.Println(tekst(vierkant))

	vierkant = rooster(4, ">>>>^<^v^v^^>>v>")
	fmt.Println(tekst(vierkant))
	fmt.Printf("%#v\n", stappen(vierkant))
	fmt.Println(tekst(vierkant))

}

func stappen(rooster [][]string) (posities []Positie) {
	pos := Positie{
		y: len(rooster) - 1,
		x: 0,
	}
	posities = append(posities, pos)
	for {
		pos = stap(rooster, pos)
		posities = append(posities, pos)

		if pos.x == len(rooster) - 1 && pos.y == 0 {
			break
		}
	}
	return
}

func rooster(grootte int, tekst string) (rooster [][]string) {
	tekens := strings.Split(tekst, "")

	rooster = make([][]string, grootte)
	idx := 0
	for i := 0; i < grootte; i++ {
		rooster[i] = make([]string, grootte)
		for j := 0; j < grootte; j++ {
			rooster[i][j] = tekens[idx]
			idx++
		}
	}
	return
}

func tekst(rooster [][]string) (tekst string) {
	for i := range rooster {
		tekst += strings.Join(rooster[i], " ") + "\n"
	}
	return
}

func stap(rooster [][]string, pos Positie) (nwPos Positie) {
	richting := rooster[pos.y][pos.x]

	nwPos = pos
	switch richting {
	case "^":
		nwPos.y--
		rooster[pos.y][pos.x] = ">"
	case ">":
		nwPos.x++
		rooster[pos.y][pos.x] = "v"
	case "v":
		nwPos.y++
		rooster[pos.y][pos.x] = "<"
	case "<":
		nwPos.x--
		rooster[pos.y][pos.x] = "^"
	}

	if nwPos.y < 0 {
		nwPos.y = 0
	} else if nwPos.y > len(rooster)-1 {
		nwPos.y = len(rooster) - 1
	}

	if nwPos.x < 0 {
		nwPos.x = 0
	} else if nwPos.x > len(rooster)-1 {
		nwPos.x = len(rooster) - 1
	}
	return
}