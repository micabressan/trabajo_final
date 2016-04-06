<select name="" id="">
<?php 

foreach($obg->nomedocampo as $idCampo=>$nomeCampo){
	echo '<option value="'. $idCampo .'">'. $nomeCampo .'</option>';
}
?>
</select>