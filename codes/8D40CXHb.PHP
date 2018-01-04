<?php

$num = 10; // string number after which you need to add blank line

$str = 'Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled
Untitled';

$arr = explode("\n", $str);

$result = array();

$i = 1;

foreach ($arr as $v) {
	
	$result[] .= $v;
	
	if($i % $num == 0) $result[] .= "";
	
	$i++;
}

echo implode("\n", $result);