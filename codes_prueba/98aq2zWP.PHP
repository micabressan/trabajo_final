<?php
$nickdoboot = rand(0, 99);
$espaco = rand(0, 99999);
//error_reporting(E_ALL);
//ini_set('display_errors', 1);
require_once("libraries/TeamSpeak3/TeamSpeak3.php");
if($_COOKIE["config90909982930461"]==""){
$ts3_VirtualServer = TeamSpeak3::factory("serverquery://XXXX:XXXX@XXXX:XXXX/?server_port=9987&nickname=www.CLANPUTOS.com_Canal$nickdoboot");
$grupo_do_ca = 89;

$nome_canal        = $_POST['canal'];
$pass_canal        = $_POST['senha'];



$top_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name"          => "[cspacer]$nome_canal",
	"channel_topic" 			=> "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_codec_quality"  => 0x08,
	"channel_flag_permanent" => TRUE,
	"channel_password" => "$pass_canal",
	"channel_flag_maxclients_unlimited" => 0,
	"channel_order"          => 4400,
));

$sub_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name" => "Sala 1",
	"channel_topic" => "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_flag_permanent" => TRUE,
	"channel_password" => "$pass_canal",
	"cpid"                  => $top_cid,
));

$sub_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name" => "Sala 2",
	"channel_topic" => "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_flag_permanent" => TRUE,
	"channel_password" => "$pass_canal",
	"cpid"                  => $top_cid,
));

$sub_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name" => "Sala 3",
	"channel_topic" => "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_flag_permanent" => TRUE,
	"channel_password" => "$pass_canal",
	"cpid"                  => $top_cid,
));

$sub_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name" => "Sala 4",
	"channel_topic" => "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_flag_permanent" => TRUE,
	"channel_password"		=> "$pass_canal",
	"cpid"                  => $top_cid,
));

$sub_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name" => "AFK",
	"channel_topic" => "ESSE CANAL SERÁ APAGADO SE FICAR INATIVO POR MAIS DE 10 DIAS",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_flag_permanent" => TRUE,
	"cpid"                  => $top_cid,
));

setcookie('config90909982930461', '1', (time() + (3 * 24 * 3600)));

foreach($ts3_VirtualServer->clientList() as $client) {
	if($_SERVER['REMOTE_ADDR'] == $client['connection_client_ip']) {
		$ts3_VirtualServer->clientGetById($client['clid'])->setChannelGroup($top_cid, $grupo_do_ca);
		break;
    }
}

$top_cid = $ts3_VirtualServer->channelCreate(array(
	"channel_name"          => "[*spacer$espaco]▂",
	"channel_topic"			=> "DIVISAO",
	"channel_codec"          => TeamSpeak3::CODEC_SPEEX_ULTRAWIDEBAND,
	"channel_codec_quality"  => 0x08,
	"channel_flag_permanent" => TRUE,
	'channel_flag_maxclients_unlimited' => 0,
	"channel_order"          => 4400,
));

header("Location: index.php?op=1");
}
else
{ 
header("Location: index.php?op=2");
}
?>