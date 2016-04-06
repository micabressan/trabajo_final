<?php
$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
$connected = socket_connect($socket, "127.0.0.1", 3690);
socket_write($socket, implode(array_map("chr", array(0x00, 0x00, 0x00,  0x01, 0x01))));
$lenBytes = unpack('C*', socket_read($socket, 4));
$i = ($lenBytes[1]<<24) + ($lenBytes[2]<<16) + ($lenBytes[3]<<8) + $lenBytes[4];
$packet = unpack('C*', socket_read($socket, $i));
$players = ($packet[2]<<24) + ($packet[3]<<16) + ($packet[4]<<8) + $packet[5];
$maxplayers = ($packet[6]<<24) + ($packet[7]<<16) + ($packet[8]<<8) + $packet[9];
$servername_len = ($packet[10]<<24) + ($packet[11]<<16) + ($packet[12]<<8) + $packet[13];
$servername = "";
for($i = 0 ; $i < $servername_len ; $i++)
    $servername .= chr($packet[14 + $i]);
$serverid = ($packet[14 + $servername_len]<<24) + ($packet[15 + $servername_len]<<16) + ($packet[16 + $servername_len]<<8) + $packet[17 + $servername_len];
$list_len = ($packet[18 + $servername_len]<<24) + ($packet[19 + $servername_len]<<16) + ($packet[20 + $servername_len]<<8) + $packet[21 + $servername_len];
$pos = 22 + $servername_len;
$playerList = array();
for($i = 0 ; $i < $list_len ; $i++) {
    $nick_len = ($packet[$pos]<<24) + ($packet[$pos + 1]<<16) + ($packet[$pos + 2]<<8) + $packet[$pos + 3];
    $nick = "";
    for($j = 0 ; $j < $nick_len ; $j++)
        $nick .= chr($packet[$pos + 4 + $j]);
    array_push($playerList, $nick);
    $pos += 4 + $nick_len;
}
socket_close($socket);

$output = array(
    "players" => $players,
    "maxplayers" => $maxplayers,
    "server_name" => $servername,
    "server_id" => $serverid,
    "player_list" => $playerList
);
echo json_encode($output);