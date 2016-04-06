$str = exec('python test.py list_containers');
echo gettype($str);
$obj = json_decode($str);
var_dump($obj);
$obj = array_shift($obj);
echo "$obj->Status";