# Имя нового пользователя FTP 
  my $user = shift; 
# Путь до папок FTP пользователей
$path2 = 'C:\\inetpub\\FTP\\LocalUser\\';
# Генерируем пароль
@chars = (a..z, A..Z, 0..9);
$password = join '', map { @chars[rand @chars] } 1 .. 8;
## Создаём директорию  и проверяем создание.
print "Making directory...";
mkdir("$path2$user");
if ( -d $path2 . $user ){
print "Ok!\n";
}else{
print "Error: path not found!\n"}
## Создаём пользователя
print "Creating user...";
$cmd = "net user $user $password /add /passwordchg:no";
&cmd($cmd);
# /expires:never не работает, поэтому другая команда:
$cmd = "wmic useraccount where \"name=\'$user\' \" set passwordexpires=false";
&cmd($cmd);
## Добавляем в группу IIS_IUSRS
print "Adding user to IIS_IUSRS...";
$cmd = "net localgroup IIS_IUSRS $user /add";
&cmd($cmd);
## Добавляем в группу Ftp-users
print "Adding user to Ftp-users...";
$cmd = "net localgroup Ftp-users $user /add";
&cmd($cmd);
## Удаляем из группы Пользователи
print "Delete user from Users...";
$cmd = "net localgroup Пользователи $user /delete";
&cmd($cmd);

$result = "Логин: $user <br>
Пароль: $password <br>
Сервер: ftp4.fttech.ru <br>
Ссылка: ftp://$user:$password\@ftp4.fttech.ru/ <br>

";