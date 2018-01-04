$hora = date("G"); // Definimos la variable con la hora
$nombre = 'Christian'; // Definimos el Nombre para Mostrar junto a la Hora

// Si son las 5 de la madrugada o antes...
if($hora <= 5) {
	$saludo = "¡Buenas noches, ".$nombre."!";
}

// Si son entre las 6 y las 11 de la mañana...
else if($hora >= 6 and $hora <= 11) {
	$saludo = "¡Buenos días, ".$nombre."!";
}

// Si la hora es ente el medio día y las 18 (6:00pm)...
else if($hora >= 12 and $hora <= 18) {
	$saludo = "¡Buenas tardes, ".$nombre."!";
}

// O si son más de las 19 (7:00pm)...
else if($hora >= 19) {
	$saludo = "¡Buenas noches, ".$nombre."!";
}

echo $saludo;