$ch = curl_init();
// Поля POST-запроса
$parameters = [
    'photo' => new CURLFile($pathToFile)
];
// Ссылка, куда будем загружать картинку - это upload_url
curl_setopt($ch, CURLOPT_URL, $link);
// Говорим cURL, что это POST-запрос
curl_setopt($ch, CURLOPT_POST, true);
// Говорим cURL, какие поля будем отправлять
curl_setopt($ch, CURLOPT_POSTFIELDS, $parameters);
// Говорим cURL, что нам нужно знать, что ответит сервер, к которому мы будем обращаться
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// Выполняем cURL-запрос. В этой переменной будет JSON-ответ от ВКонтакте
$curl_result = curl_exec($ch);
$curlDecodedAnswer = json_decode($curl_result,true);
// Закрываем соединение
curl_close($ch);