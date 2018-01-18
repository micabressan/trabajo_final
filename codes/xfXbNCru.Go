package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"strconv"
	"strings"
)

// START DO NOT TOUCH
var clear map[string]func()

func init() {
	clear = make(map[string]func())
	clear["linux"] = func() {
		cmd := exec.Command("clear")
		cmd.Stdout = os.Stdout
		cmd.Run()
	}
	clear["windows"] = func() {
		cmd := exec.Command("cls")
		cmd.Stdout = os.Stdout
		cmd.Run()
	}
}

func clearCall() {
	value, ok := clear[runtime.GOOS]
	if ok {
		value()
	}
}

// END DO NOT TOUCH

var greeting = `
Добрый день. Мы постараемся дать вам совет, как при вашем финансовом положении провести отпуск
Для того чтобы начать нажмите Enter...
`

func main() {
	r := bufio.NewReader(os.Stdin)

	fmt.Println(greeting)
	_, _ = r.ReadString('\n')
	clearCall()

	var howres = 1
	var wife = false
	var withWife = false
	var townout = false
	var forest = false
	var mountain = false

	var s int = 0 // desc
	{
		fmt.Println("Какую сумму вы могли бы потратить?")
		s_, _ := r.ReadString('\n')
		s, _ = strconv.Atoi(strings.TrimSuffix(s_, "\n"))
	}

	// RULS
	// RULE 5
	var a int = 1
	if s > 3000 {
		fmt.Println("А сколько человек будет отдыхать за вас счет?")
		a_, _ := r.ReadString('\n')
		a, _ = strconv.Atoi(strings.TrimSuffix(a_, "\n"))
	}

	// RULE1
	if (s/a) >= 5000 && (s/a) < 9000 {
		howres = 0
	}

	// RULE2
	if (s/a) >= 900 && (s/a) < 90000 {
		howres = 1
	}

	// RULE3
	if (s / a) >= 90000 {
		howres = 2
	}

	// RULE4
	if (s/a) < 5000 && (s/a) >= 3000 {
		howres = 3
	}

	// RULE6
	if (s / a) < 3000 {
		howres = 4
	}

	// RULE7
	if (s/a) <= 3000 && (s/a) > 1000 {
		fmt.Println("Простите за бестактный вопрос, вы женаты (замужем)? (Y/N)")
		wife_, _ := r.ReadString('\n')
		wife = wife_ == "Y\n"
	}

	// RULE8
	if wife {
		fmt.Println("Вы проведете отпуск вместе? (Y/N)")
		withWife_, _ := r.ReadString('\n')
		withWife = withWife_ == "Y\n"
	}

	// RULE9
	if withWife {
		howres = 5
	}

	// RULE10
	if s <= 1000 {
		howres = 6
	}

	// RULE11
	if wife || withWife {
		fmt.Println("Вы хотели бы выбраться на природу?")
		townout_, _ := r.ReadString('\n')
		townout = townout_ == "Y\n"
	}

	// RULE11
	if townout {
		fmt.Println("Вам нравится отдых в лесу?")
		forest_, _ := r.ReadString('\n')
		forest = forest_ == "Y\n"
	}

	// RULE11
	if townout && !forest {
		fmt.Println("Вам нравится отдых в горах?")
		mountain_, _ := r.ReadString('\n')
		mountain = mountain_ == "Y\n"
	}

	// RULE 14
	if townout && !mountain {
		howres = 7
	}

	// RULE15
	if forest {
		howres = 8
	}

	// RULE16
	if mountain {
		howres = 9
	}

	// RULE17
	if townout {
		howres = 10
	}

	fmt.Println("Вот что приемлемо в данной ситуации:")

	var res string
	switch howres {
	case 0:
		res = "Вы можете приобрести каждому по путевке в санаторий на побережье какой-либо реки, оезра или водохранилища"
	case 1:
		res = "Вы можете приобрести каждому по потевке на Черное море"
	case 2:
		res = "Вы можете приобрести каждому по потевке на Канарские острова или двух недельный круиз"
	case 3:
		res = "Вам стоит подумать об отдыхе в лесу или горах, для такого отдыха у вас достаточно средств"
	case 4:
		res = "Следует подумать о скоращении числа отдыхающих за ваш счет либо об увеличении суммы на отдых"
	case 5:
		res = "На такую сумму можно отдохнуть только дома или на даче"
	case 6:
		res = "В таком финансовом положении вам стоит остаться дома и, возможно, разок-другой сходить в кафе"
	case 7:
		res = "В таком финансовом положении вам стоит остаться дома"
	case 8:
		res = "При ваших финансах вам стоит отправиться отдыхать в лес"
	case 9:
		res = "При ваших финансах вам стоит отправиться отдыхать в горы"
	case 10:
		res = "В таком финансовом положении вам стоит остаться дома"
	}

	fmt.Println(res)
}

// 	// Выводим ответ
// 	fmt.Println("Вот что мне кажется приемлемым в данной ситуации:")
// 	switch whatTodo {
// 	case 0:
// 		fmt.Println("Берите такси до института. В такой ситуации деньги значения не имеют.")
// 	case 1:
// 		fmt.Println(`
// На не очень важный экзамен не стоит слишком спешить.
// Вам простят ваше опоздание.
// Так что спокойно поезжайте на общественном транспорте.
// `)
// 	case 2:
// 		fmt.Println(`
// Все еще будет хорошо. Вам стоит взять такси на часть пути,
// до какого-нибудь метро или автобусной остановки.
// `)
// 	case 3:
// 		fmt.Println("Все в порядке. Желаю вам ни пуха ни пера")
// 	case 4:
// 		fmt.Println("Наверное, вы хорошо учитесь. Так что можете не спешить на экзамен.")
// 	case 5:
// 		fmt.Println("Я не знаю, что вам посоветовать.")
// 	}
// }