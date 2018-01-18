package main

import "fmt"

const neededPoints = 450

var (
	points [10]int
	counts [10]int
)

func main() {

	flag, i, sum := true, 0, 0

	fmt.Printf("Привет, это вычислятор обменятора. \nИщем количество предметов, чтобы получить %d очков в итоге\n", neededPoints)

	for flag {

		fmt.Println("Укажите количество очков, выдаваемых за вносимый итем: ")
		fmt.Scanf("%d", &points[i])

		if (points[i] == 0) {

			fmt.Println("Даладна?! О_О")

		} else {

			fmt.Println("Укажите количество итемов (0, если неизвестно): ")
			fmt.Scanf("%d", &counts[i])

			if counts[i] == 0 {
				flag = false
			}

			i++
		}
	}

	fmt.Println("Вычисляем...")

	for i = 0; counts[i] > 0; i++{
		sum += points[i] * counts[i]
	}

	a := sum % neededPoints

	fmt.Printf("Сумма имеющихся очков: %d\n", sum)
	fmt.Printf("Необходимое количество очков: %d\n", a)

	switch {

	case a%points[i] == 0:

		fmt.Printf("Необходимое количество итемов по %d очков: %d\n", points[i], a/points[i])

	default:

		fmt.Printf("%d не делится на %d без остатка\n", a, points[i])

	}

}