<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Jedzonko i Pićku</title>
</head>
<body>


<?php 
$wybor=2;
// 1-kawa
// 2-napoj
// 3-pizza
$kawa="cappuchino";
// 1.espresso
// 2.cappuchino
// 3.americana
// 4.latte

$pojemnosc=400;
// 1. 200ml
// 2. 350ml
// 3. 400ml
$napoj="cola";
// 1.sprite
// 2.fanta
// 3.7up
// 4.cola
$pizza="peperoni";
// 1.peperoni
// 2.hawajska
// 3.capricosa
// 4.kebab
$wielkosc="48cm";
// 1.32cm  
// 2.40cm 
// 3.48cm 


if ($wybor==1) {
	if ($kawa=="espresso") {
		echo "Zamówiona kawa to ".$kawa. " w ilości ".$pojemnosc." ml";
		echo '<br>';
		echo "Do kawy nie zostało wykorzystane mleko";
    }
    elseif ($kawa=="cappuchino") {
    	echo "Zamówiona kawa to ".$kawa. " w ilości ".$pojemnosc." ml";
    	echo "<br>";
    	$x1= $pojemnosc/5;
    	$mleko=$x1*4;
    	echo " Do kawy wykorzystano " .$mleko. " ml mleka oraz ".$x1. " ml kawy";
	}
	elseif ($kawa=="americana") {
    	echo "Zamówiona kawa to ".$kawa. " w ilości ".$pojemnosc." ml";
    	echo "<br>";
    	echo "Do kawy nie zostało wykorzystane mleko";
	}
    elseif ($kawa=="latte") {
    	echo "Zamówiona kawa to ".$kawa. " w ilości ".$pojemnosc." ml";
    	echo "<br>";
    	$x1= $pojemnosc/4;
    	$mleko=$x1*3;
    	echo " Do kawy wykorzystano " .$mleko. " ml mleka oraz ".$x1. " ml kawy";
	}
    else{ echo "takiej kawy nie ma w naszym menu";}
    }  
elseif ($wybor==2){
 	echo "Zamówiony napój to ".$napoj. " w ilości " .$pojemnosc. " ml";
 	echo '<br>';
 	echo "Smacznego";
 	}
elseif($wybor==3){
 	if ($wielkosc=="32cm") {
 		$rozmiar=$wielkosc."-mała";
 		echo "Zamówiona pizza to: ".$pizza. " o rozmiarze ".$rozmiar;
 	}
 	elseif ($wielkosc=="40cm") {
 		$rozmiar=$wielkosc."-średnia";
 		echo "Zamówiona pizza to: ".$pizza. " o rozmiarze ".$rozmiar;
 	}
 	elseif ($wielkosc=="48cm") {
 		$rozmiar=$wielkosc."-duża";
 		echo "Zamówiona pizza to: ".$pizza. " o rozmiarze ".$rozmiar;
 	}
 	else{ echo "takiego rozmiaru nie ma w naszym menu";}
 }
else {
	echo "Tego u nas nie zamówisz :/";
}
 ?> 
 </body>
</html>