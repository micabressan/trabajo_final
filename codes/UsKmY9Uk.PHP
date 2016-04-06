<?php
 ini_set('default_charset','UTF-8');
// Recupera a URL da requisição e seus parâmetros, separando em um vetor dividido pelo caracter "/"
$geturl = explode( "/", str_replace( strrchr( $_SERVER["REQUEST_URI"], "?" ), "", $_SERVER["REQUEST_URI"] ) );
array_shift( $geturl );
 
// Considera o primeiro parâmetro como o arquivo php
$tipo = $geturl[0];
 
// Se o arquivo existir, inclui na página. Caso contrário, devemos redirecionar o usuário para uma
// tela amigável de error 404
if ( is_file( "$tipo.php" ) )
{
    include "$tipo.php";
}
else
{
    echo "
<h1 class='corVermelho'>ERRO: Página não encontrada (Erro 404)</h1>
<p>
    <strong>Página Solicitada: <em>{$_SERVER['REQUEST_URI']}</em></strong><br/><br/>
    Esta pasta ou página não pôde ser encontrada. Provavelmente ela foi
    renomeada, apagada ou simplesmente não existe. Por favor, verifique
    se o endereço digitado está correto e tente novamente.
    <br/><br/>Caso você necessite realmente de acessar esta pasta ou
    arquivo, entre em contato com o <a href='mailto:juninhoeverkaw10@gmail.com'>Administrador do Sistema.</a>
</p>";
}
 
?>