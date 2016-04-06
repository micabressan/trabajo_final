else if (res.command == "getProfileName") { // Если команда на изменение имени
	updateJob({JobID: res.job_id, Status: 2}, function(){ // Обновляем статус задачи. Сайт после изменения статуса дать новую задачу!
		sendProfileName(function(){ // Изменяем имя, отправляем результат на сайт
			updateJob({ // Статус - ОК
				JobID: res.job_id,
				Status: 3
			});
		});
	});
}