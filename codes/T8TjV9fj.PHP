<?php
include 'methods.php';
$db = new mysqli("localhost", "wor647_strong", "strongcms777", "wor647_strong");

if(mysqli_connect_errno()) {
printf("Не удалось подключиться: %s\n", mysqli_connect_error());
exit();
}

if(isset($_REQUEST['method'])) {
$method = trim($_GET['method']);
$id = intval(abs($_GET['id']));

if(empty($methods[2]) or empty($method)) {
$error = 1;
$response = 'Метод не выбран';
$result = array('error' => $error, 'response' => $response);
echo json_encode($result, JSON_UNESCAPED_UNICODE);
} elseif(!empty($method) and $method != $methods[2]) {
$error = 2;
$response = 'Не тот метод';
$result = array('error' => $error, 'response' => $response);
echo json_encode($result, JSON_UNESCAPED_UNICODE);
} elseif(empty($id)) {
$error = 3;
$response = 'ID не указан';
$result = array('error' => $error, 'response' => $response);

echo json_encode($result, JSON_UNESCAPED_UNICODE);
} elseif($methods[2] == 'user.info') {
$res = $db->query("SELECT * FROM get_user WHERE id = '".$id."' ")->fetch_assoc();
if(empty($res['id'])) {
$error = 4;
$response = 'Пользователь не найден';
$result = array('error' => $error, 'response' => $response);
echo json_encode($result, JSON_UNESCAPED_UNICODE);
} else {
$response = 'Ok';
$result = array('response' => $response, 'id' => $id, 'name' => $res['name'], 'city' => $res['city']);
echo json_encode($result, JSON_UNESCAPED_UNICODE);
}
}
} else {
$error = 5;
$response = 'Ничего не указано';
$result = array('error' => $error, 'response' => $response);
echo json_encode($result, JSON_UNESCAPED_UNICODE);

}
?>