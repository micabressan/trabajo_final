<? $select = file_get_contents('Funcoes/AltTema.txt');
header("Content-Type: text/html; charset=ISO-8859-1",true) ;
$resultado = mysql_query('SELECT * FROM tema WHERE id=' . $select);
while($tema = mysql_fetch_array($resultado))
{ $codigo = $tema['codigo'];?><div id="conteudo_esquerdo">
      <div class="conteudo_tesquerdo" style="background:<? echo $tema['codigo']; ?>">
        <p style="padding:5px;">Not&iacute;cias</p>
      </div><?php
$query = "SELECT * FROM noticias";
$result = mysql_query($query);
$play = mysql_num_rows($result);
if($play <= "0"){
echo "<br><div class='warning'>Nenhuma Not&iacute;cia cadastrada</div>";}
?>
      <?php
	  include('Fail/Settings.php');
	$query = "SELECT * FROM noticias order BY id DESC";
	$result = mysql_query($query,$conecta);
	while ($play = mysql_fetch_array($result)){
	$id = $play["id"];
	$titulo = $play['titulo'];
	$data = $play['data'];
	$foto = $play['foto'];
	$n = $i+1;
	$i++;
	?>
      </p>
      <table width="612" height="79" border="0" align="center" cellspacing="4">
        <tr>
          <td width="75" rowspan="3" class="tt" id="noticia"><div align="center"><img src="<?php echo $foto;?>" width="75" height="75" border="0" title="<? echo"$login" ?>" /></div></td>
          <td width="521"><b><?php echo $titulo;?></b></td>
        </tr>
        <tr>
          <td>Data: [<?php echo $data;?></a>]</td>
        </tr>
        <tr>
          <td><div align="right"><a href="javascript:;" onclick ="Load('?sexy=plVerNoticia&id=<? echo $play['id']; ?>','conteudo','GET');"># Leia Mais</a></div></td>
        </tr>
      </table>
      <?php } ?>
      </div>
    </div>
    </div>
</div>
    </body>
</html>
<? } ?>