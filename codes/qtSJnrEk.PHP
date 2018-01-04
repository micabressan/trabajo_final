<?php 
$target_path = "upload/"; 
$target_path = $target_path . basename( $_FILES['archivo-a-subir']['name']);
echo "\nTarget Path set as " . $targetPath;
echo "\ntrying to move it";
echo "\ngetting name property" . $_FILES['archivo-a-subir']['name'];
echo "\ngetting temp_name property" . $_FILES['archivo-a-subir']['tmp_name'];
if(move_uploaded_file($_FILES['archivo-a-subir']['tmp_name'], $target_path)) 
{ 
echo "\nEl archivo ". basename( $_FILES['archivo-a-subir']['name'])." ha sido subido exitosamente!"; 
} 
else
{ 
echo "Hubo un error al subir tu archivo! Por favor intenta de nuevo."; 
}

 ?>