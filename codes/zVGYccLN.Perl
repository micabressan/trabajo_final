# Внешний модуль авторизации для ejabberd через
# базу SMF.
#
# Author: Vadim Nevorotin aka Malamut
 
use 5.010;
use Digest::SHA1 qw(sha1_hex);
use DBI;
 
#############################################################
 
# Настройки базы данных (MySQL)
$MYSQL_host = 'bd.yourdomain.com';
$MYSQL_port = '3306';
$MYSQL_user = 'postfix';
$MYSQL_pass = 'PASSW0RD';
$MYSQL_db = 'my_smf';
 
# Параметры SMF - группа пользователей с доступом к почте и префикс таблиц
$SMF_GID = '15';
$SMF_prefix = 'smf_';
 
# Обслуживаемый домен
$valid_domain = "yourdomain.com";
 
#############################################################
 
# Просто соединяемся с БД
sub db_connect {
	my $dbh = DBI->connect("DBI:mysql:$MYSQL_db:$MYSQL_host:$MYSQL_port",$MYSQL_user,$MYSQL_pass);
	return $dbh;
}
 
$dbh = db_connect;
 
# Это именно то, что вы видите. Бесконечный цикл, ага.
while(1) {
	# Получаем запрос от ejabberd
	my $nread = sysread STDIN, my $buf, 2;
	unless ($nread == 2) { exit }
	my $len = unpack "n", $buf;
	$nread = sysread STDIN, $buf, $len;
 
	my ($op,$user,$domain,$passwd) = split /:/, $buf;
 
	# Сложно сказать зачем, но фильтруем символы
	$passwd =~ s/[\n\r]//g;
 
	# Домен проверяет ejabberd, но на всякий случай
	die "о_О" if $valid_domain ne $domain;
 
	my $result = 0;
	## Для идентичности поведения с почтовой системой:
	# если имя пользователя содержит неразрешённые символы - пропускаем его
	# Разрешены любые буквы, цифры и символы ".", "-" и "_"
	if ($user =~ /^\w+[\w.\-_]*\w+$/) {
		# Пытаемся восстановить соединение, если оно сброшено
		unless ($dbh) { $dbh = db_connect }
		# Подготавливаем запрос если соединение установлено. При неудаче - сбрасываем соединение
		my $sth = $dbh->prepare("SELECT memberName, realName, passwd
				FROM ${SMF_prefix}members
				WHERE (ID_GROUP = $SMF_GID OR FIND_IN_SET($SMF_GID, additionalGroups)) AND realName = '$user'")
			or $dbh = undef if $dbh;
		# Выполняем запрос если соединение установлено. При неудаче - сбрасываем соединение
		$sth->execute() or $dbh = undef if $dbh;
 
		# Если соединение не сброшено
		if ($dbh) {
			# Получаем количество найденных строк
			my $num = $sth->rows();
			# Получаем ответ если он состоит ровно из одной строки
			my $row = $sth->fetchrow_hashref() if $num == 1;
 
			# Проверяем пароль или пользователя
			if ($op =~ /auth/i and $num == 1) {
				my $epass = sha1_hex(lc($row->{memberName}) . $passwd);
	   			$result = $epass eq $row->{passwd} ? 1 : 0;
	   		} elsif ($op =~ /isuser/i and $num == 1) {
	   			$result = exists $row->{memberName} ? 1 : 0;
	   		}
		}
	} else {
		$result = 0;
	}
 
	# Отправляем ответ для ejabberd
	my $out = pack "nn", 2, $result;
	syswrite STDOUT, $out;
}