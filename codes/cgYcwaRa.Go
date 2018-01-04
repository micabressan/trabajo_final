package main

import (
	"fmt"
	"bufio"
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
Добрый день.
У вас сегодня экзамен, а вы проснулись слишком поздно...
Вам, естественно, надо успеть на него, но как?
Мы постараемся дать вам совет, как, исходя из сложившейся ситуации, Вам следует поступить.
Но для этого Вы должны представить мне всю информацию.
Для того чтобы начать нажмите Enter...
`

func main() {
	r := bufio.NewReader(os.Stdin)

	fmt.Println(greeting)
	_, _ = r.ReadString('\n')
	clearCall()

	// START Блок с вопросами студенту
	var lating_ string
	var lating bool // значительно ли текущее опоздание
	{
		fmt.Println("Скажите, Вы действительно опаздываете (Y/N)?")
		lating_, _ = r.ReadString('\n')
		lating = lating_ == "Y\n"
	}

	var howcommon_ string
	var howCommon int // время пути до института
	{
		fmt.Println("Сколько минут Вам добираться до института общественным транспортом?")
		howcommon_, _ = r.ReadString('\n')
		howCommon, _ = strconv.Atoi(strings.TrimSuffix(howcommon_, "\n"))
	}


	var onWalk_ string
	var onWalk int // Время вашего передвижения
	{
		fmt.Println("Сколько минут Вам приходится идти пешком?")
		onWalk_, _ = r.ReadString('\n')
		onWalk, _ = strconv.Atoi(strings.TrimSuffix(onWalk_, "\n"))
	}


	var bymetro_ string
	var byMetro int // Время проезда в метрополитене
	{
		fmt.Println("Сколько минут вам приходится проводить в метро?")
		bymetro_, _ = r.ReadString('\n')
		byMetro, _ = strconv.Atoi(strings.TrimSuffix(bymetro_, "\n"))
	}


	var bybus_ string
	var byBus int // Время проезда в автобусе,тролейбусе,трамвае
	{
		fmt.Println("Сколько времени вам приходится проводить в автобусе?")
		bybus_, _ = r.ReadString('\n')
		byBus, _ = strconv.Atoi(strings.TrimSuffix(bybus_, "\n"))
	}


	var onlyge4_ string
	var onlyge4 bool // На предстоящем экзамене не ставят меньше 4
	{
		fmt.Println("Ha предстоящем экзамене не ставят меньше 4? (Y/N)")
		onlyge4_, _ = r.ReadString('\n')
		onlyge4 = onlyge4_ == "Y\n"
	}


	var probability_ string
	var probability int // Объективная вероятность получения вами желаемой оценки
	{
		fmt.Println("Какова объективная вероятность получения вами желаемой оценки?")
		probability_, _ = r.ReadString('\n')
		probability, _ = strconv.Atoi(strings.TrimSuffix(probability_, "\n"))
	}
	// END Блок с вопросами студенту

	// START RULES
	var mainExam bool // важен ли предстоящий экзамен
	if onlyge4 { // Rule #4
		mainExam = false
	} else if probability >= 90 { // Rule #5
		mainExam = false
	} else { // Rule #6
		mainExam = true
	}

	var bigLate bool // значительно ли текущее опоздание
	if howCommon < (onWalk + byMetro + byBus + 15) { // Rule #8
		bigLate = true
	} else { // Rule #9
		bigLate = false
	}

	fmt.Println(probability)

	var whatTodo = 4 // совет как действовать в данной ситуации
	if !lating { // Rule #7
		whatTodo = 3
	} else if mainExam && bigLate { // Rule #1
		whatTodo = 0
	} else if !mainExam { // Rule #2
		whatTodo = 1
	} else { // Rule #3
		whatTodo = 2
	}
	// END RULES

	// Выводим ответ
	fmt.Println("Вот что мне кажется приемлемым в данной ситуации:")
	switch whatTodo {
	case 0:
		fmt.Println("Берите такси до института. В такой ситуации деньги значения не имеют.")
	case 1:
		fmt.Println(`
На не очень важный экзамен не стоит слишком спешить.
Вам простят ваше опоздание.
Так что спокойно поезжайте на общественном транспорте.
`)
	case 2:
		fmt.Println(`
Все еще будет хорошо. Вам стоит взять такси на часть пути,
до какого-нибудь метро или автобусной остановки.
`)
	case 3:
		fmt.Println("Все в порядке. Желаю вам ни пуха ни пера")
	case 4:
		fmt.Println("Наверное, вы хорошо учитесь. Так что можете не спешить на экзамен.")
	case 5:
		fmt.Println("Я не знаю, что вам посоветовать.")
	}
}