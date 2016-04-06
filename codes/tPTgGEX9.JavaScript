function prueba() {
	var list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	var list_len = list.length;
	var len_permut = 2;
	for (var i = 0; i < list_len; i++) {
		for (var j = 0; j < len_permut; j++) {
			console.log(list[i]);
		}
	}
}

prueba();