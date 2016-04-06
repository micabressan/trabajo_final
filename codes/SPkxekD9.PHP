<form action="send-email.php" method=post>
		            Ваше имя:
			        <input type="text" name="name"><br><br>
					Ваш E-mail:
					<input type="email" name="email"><br><br>
					Ваш телефон:
					<input type="text" name="phone"><br><br>
					Ваше ТЗ:
					<textarea type="text" name="tz"></textarea><br><br>
					<input type="file" name="files"><br><br>
					<input type="submit" name="submit" value="Отправить"><br>
		        </form>

<?php
$name = substr(htmlspecialchars(trim($_POST['name'])), 0, 1000);
$email = substr(htmlspecialchars(trim($_POST['email'])), 0, 1000);
$phone = substr(htmlspecialchars(trim($_POST['phone'])), 0, 1000);
$tz = substr(htmlspecialchars(trim($_POST['tz'])), 0, 1000);
$files = substr(htmlspecialchars(trim($_POST['files'])), 0, 1000);
$message = "sgant1@mail.ru ".$name."\n E-mail ".$email."\n Телефон ".$phone."\n ТЗ: ".$tz."\n Файлы:".$files;

mail("sgant1@mail.ru", "Заявка Sites4You: ", $message, "Content-Type: text/html; charset=UTF-8", "we@web-csc.esy.es");
echo "Заявка отправлена. Спасибо за сотрудничество с нами. <br> <a href='index.html'>Вернуться на сайт</a>";
?>