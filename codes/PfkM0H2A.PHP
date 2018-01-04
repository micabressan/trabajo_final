//pagelogin.php

//change so that users greater than r3vvip or whatever class you want to be able to use link

$res = sql_query("SELECT id, username, passhash, enabled FROM users WHERE hash1 = ".sqlesc($hash1)." AND class >= ".UC_STAFF." AND status = 'confirmed' LIMIT 1");


//blocks/userdetails/loginlink.php
//Do the same for this

if ($CURUSER['class'] >= UC_STAFF && $id == $CURUSER['id']) {
    $hash1 = $mc1->get_value('hash1_'.$id);
    if ($hash1 === false) {
        $res = sql_query("SELECT hash1 FROM users WHERE id = ".sqlesc($CURUSER['id'])." AND class >= ".UC_STAFF) or sqlerr(__FILE__, __LINE__);