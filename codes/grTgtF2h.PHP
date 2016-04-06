<?php
ini_set('default_charset','UTF-8');
 
// Recupera a URL da requisição e seus parâmetros, separando em um vetor dividido pelo caracter "/"
$geturl = explode( "/", str_replace( strrchr( $_SERVER["REQUEST_URI"], "?" ), "", $_SERVER["REQUEST_URI"] ) );
array_shift( $geturl );
 
// Recupera o ID da subcategoria, informado na URL (2º parâmetro) e converte para inteiro
$id = intval( $geturl['1'] );
 
if ( $id == 0 )
{
    // Caso o ID seja 0, vou listar as subcategorias para o usuário selecionar qual deseja visualizar
    $frmSubcategoria = new frmSubcategoria();
    $frmSubcategoria->listar();
}
else
{
 
    // Caso o ID seja > 0, vou consultar os dados dessa subcategoria no banco de dados
    $ctrSubcategoria = new ctrSubcategoria();
    $subcategoria = $ctrSubcategoria->recuperarObjetoBanco( $id );
 
    // Agora que meu controller criou o objeto, vou exibir os ítens dessa sub-categoria
    $frmSubcategoria = new frmSubcategoria();
    $frmSubcategoria->visualizar( $subcategoria );
}
 
?>