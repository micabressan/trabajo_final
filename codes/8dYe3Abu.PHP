<?php error_reporting(0); $op = $_GET['op'];

echo"<form action='create.php' method='POST'>
Nome do Canal: <BR><input name='canal' id='canal' type='text' size='20'><BR><BR>
Senha: <BR><input name='senha' id='senha' type='text' size='20'><BR><BR>
<input type='submit' value='Criar sala'>
</form>";

if ($op==1){ echo "<hr width='100'><p align='center'><font color='#0000FF'>Seu Canal foi Criado!</font></p><hr width='100'>";}
/* Channel created successfully! */
if ($op==2){ echo "<hr width='100'><p align='center'><font color='#FF0000'>Desculpe! Você ja possui um Canal!</font></p><hr width='100'>";}
/* Here is the message to the User if he has already created a room on the day. */
?>