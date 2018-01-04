const TelegramBot = require('node-telegram-bot-api');

const token = 'token';

const bot = new TelegramBot(token, { polling: true });

var schedule = [
	["нихуя :)"],
	[
		"История",
		"Делопроизводство",
		"Информатика"
	],
	[
		"Узбекский язык",
		"Физ-ра",
		"Электроника"
	],
	[
		"Архитекура ПК",
		"Операционные системы (Учебная практика)",
		"Начальная допризывная подготовка"
	],
	[
		"Английский язык",
		"Компьютерные сети",
		"Математика"
	],
	[
		"Физика",
		"Эстетика",
		"Операционные системы"
	],
	[
		"СУБД",
		"Охрана труда",
		"Компьютерные сети (Учебная практика)"
	]
];

var days = [
	"Воскресенье",
	"Понедельник",
	"Вторник",
	"Среду",
	"Четверг",
	"Пятницу",
	"Субботу"
];

var timetable = [
	{
		"start": "13:00",
		"end": "14:20"
	},
	{
		"start": "14:30",
		"end": "15:50"
	},
	{
		"start": "16:00",
		"end": "17:20"
	},
	{
		"start": "17:30",
		"end": "18:50"
	}
];

// messages.
bot.on('message', (msg) => {
	const chatId = msg.chat.id;
	const command = (/\/(\w*)(@kit10bot)?/.exec(msg.text))[1];

	if (command == "start") {
		response = `Добро пожаловать! Бот создан @shahzodkudratov для того, чтобы получать актуальное расписание уроков группы КИТ-10.

На текущий момент доступны 4 команды:
/today - Показать расписание на сегодня
/tomorrow - Показать расписание на завтра
/week - Показать расписание на неделю
/time - Показать время уроков`;
		bot.sendMessage(chatId, response);
	} else if (command == "today") {
		today = new Date();
		id = today.getDay();

		if (id == 0) {
			bot.sendMessage(chatId, "Пездюк, сегодня воскресенье");
		} else {
			response = "Короче, сегодня:\n\n";
			for (i = 0; i < schedule[id].length; i++) {
				response += schedule[id][i] + "\n";
			}
			bot.sendMessage(chatId, response);
		}
	} else if (command == "tomorrow") {
		tomorrow = new Date(Date.now() + 1 * 24 * 60 * 60 * 1000);
		id = tomorrow.getDay();

		if (id == 0) {
			bot.sendMessage(chatId, "Пездюк, завтра воскресенье.");
		} else {
			response = "Короче, завтра:\n\n";
			for (i = 0; i < schedule[id].length; i++) {
				response += schedule[id][i] + "\n";
			}
			bot.sendMessage(chatId, response);
		}
	} else if (command == "week") {
		respa = "======================================\n";
		for (i = 1; i < schedule.length; i++) {
			respa += "Расписание на " + days[i] + ":\n\n";
			for (j = 0; j < schedule[i].length; j++) {
				respa += schedule[i][j] + "\n";
			}
			respa += "======================================\n";
		}
		bot.sendMessage(chatId, respa);
	} else if (command == "time") {
		respa = "==========================\n";
		for (i = 0; i < timetable.length; i++) {
			respa += (i + 1) + " пара:\n";
			respa += "Начало: " + timetable[i].start + "\n";
			respa += "Конец: " + timetable[i].end + "\n";
			respa += "==========================\n";
		}
		bot.sendMessage(chatId, respa);
	}
	console.log(msg);
});