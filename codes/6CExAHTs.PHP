<?php
$user = 'root';
$haslo ='Paluszek2';
$host = 'localhost';
$baza = 'database';
$id_conn = mysql_connect($host, $user, $haslo);
mysql_select_db($baza);
if($id_conn == false) die( 'BŁĄD dostępu do danych!');
$tabela="CREATE TABLE IF NOT EXISTS rosliny13b_08 (
id INT(10) NOT NULL AUTO_INCREMENT ,
nazwa VARCHAR(45) NOT NULL ,
gatunek VARCHAR(45) NOT NULL ,
wystepowanie VARCHAR(45) NOT NULL ,
PRIMARY KEY (id)
) ENGINE = InnoDB" ;
mysql_query($tabela);
?>