<?php

$str = "Krassi e goliaaaaam pi4";

$arr = explode(" ", $str);

$lenghts = array_map('mb_strlen', $arr);
$maxLenght = max($lenghts);



for ($i = 0; $i < $maxLenght + 2; $i++) {
    echo "*";
}
echo PHP_EOL;

for ($i = 0; $i <= count($arr, 0) - 1; $i++) {
    echo "*" . $arr[$i];
    for ($s = 0; $s < $maxLenght - mb_strlen($arr[$i]); $s++) {
        echo "-";
    }
    echo "*" . PHP_EOL;
}

for ($i = 0; $i < $maxLenght + 2; $i++) {
    echo "*";
}


?>