<style>
.tt{border:1px solid #CCC;}
</style>
<?
$select = file_get_contents('Funcoes/AltTema.txt');
$resultado = mysql_query('SELECT * FROM tema WHERE id=' . $select);
while($tema = mysql_fetch_array($resultado))
{ $codigo = $tema['codigo'];?>
<?php
require_once("Fail/Settings.php");
$id = $_GET["id"];
$select = "SELECT*FROM noticias WHERE id='$id'";
$result = mysql_query($select);
while($play = mysql_fetch_array($result)){
$id = $play["id"];
$titulo = $play['titulo'];
$data = $play['data'];
$foto = $play['foto'];
$conteudo = $play['conteudo'];
$poster = $play['poster'];
?>
<div id="conteudo_esquerdo">
      <div class="conteudo_tesquerdo" style="background:<? echo $tema['codigo']; ?>">
        <p style="padding:5px;">Noticia <strong>
          <?=$titulo;?>
        </strong></p>
  </div>
<div style="padding: 10px;">
  <table width='485' border='0' align='center' cellspacing='4'>
    <tr>
      <td colspan='2' class='tt' id='semfoto'><img src='<?=$foto;?>' width='490' height='200' /></td>
    </tr>
    <tr>
      <td width='194' class='tt'><span class='text3'>Titulo: </span><strong>
        <?=$titulo;?>
      </strong></td>
      <td width='285' class='tt'><span class='text3'>Postada Dia: </span>
      <strong><?=$data;?>
      </strong></span></td>
    </tr>
    <tr>
      <td colspan='2' class='tt'><?=$conteudo;?></td>
    </tr>
    <tr>
      <td colspan='2' class='tt'><div align="right">Postada por:<strong>
        <?=$poster;?>
      </strong></div></td>
    </tr>
  </table>
</div></div>
    </div>
    </div>
    </div>
</body>
</html>
<? }} ?>