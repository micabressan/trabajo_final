<?php
if (empty($_POST['liczba1']) || (empty($_POST['liczba2'])
 && $_POST['liczba2']!=0)) {
    echo "Wpisz podstawę i wykładnik potęgi";
}
else {
 if ($_POST['liczba2']>=0) {    
 echo "Wynik działania wynosi: ";
 echo pow($_POST['liczba1'], $_POST['liczba2']);
 }
 else {
 echo "Wykładnik potęgi musi być dodatni";
 }
}  
?>