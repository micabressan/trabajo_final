<?php

echo "Enter a number: ";
$x = trim(fgets(STDIN));
echo "Enter a number for power: ";
$y = trim(fgets(STDIN));;

function powerWithAddition($x, $y){

    if($y == 0){
        return 1;
    }

    $calcY = powerWithAddition($x, $y-1);

    $sum = 0;
    for ($i = 0; $i < $calcY; $i++) {

        $sum += $x;

    }

    return $sum;


}

echo powerWithAddition($x,$y);

?>