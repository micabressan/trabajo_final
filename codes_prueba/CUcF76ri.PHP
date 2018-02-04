//функция проверки доступа текущего пользователя к показу телефона
function the_phone_view($post_id){
	global $User_Access,$user_ID;
    if($User_Access) echo get_post_meta($post_id,'real7',1);
	else echo '<a href="http://arenda-zarechny.ru/oplata">оплатить доступ</a>';
}

//этой строкой заменить строчку вывода номера телефона в теле объекта
the_phone_view($post_id);