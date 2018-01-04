$sciezka_do_pliku = $my_images_dir . "/temp/" basename($_FILES["obraz_do_wrzucenia"]["name"]);

$rozszerzenie = strtolower(pathinfo($sciezka_do_pliku, PATHINFO_EXTENSION));

$sciezka_do_pliku = $my_images_dir . basename($_FILES["obraz_do_wrzucenia"]["tmp_name"]) . $rozszerzenie;

move_uploaded_file($_FILES["obraz_do_wrzucenia"]["tmp_name"], $my_images_dir);