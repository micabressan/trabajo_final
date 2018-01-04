/*ПРИМЕРЕН СКРИПТ ЗА УСЛУГАТА "ИЗВЕСТЯВАНЕ ЗА ПЛАЩАНЕ"

Този примерен скрипт демонстрира обработката на входящ SMS от Вашият сървър при използване на услугата Известяване за плащане. За да работи скрипта е нужно да настройте в контролния панел на Mobio услуга от тип Известяване за плащане.*/

<?PHP

$message = $_REQUEST["message"];
$item = $_REQUEST["item"];
$fromnum = $_REQUEST["fromnum"];
$extid = $_REQUEST["extid"];
$servID = $_REQUEST["servID"];

$mobio_remote_addrs = array("87.120.176.216", "194.12.244.114");



if(in_array($_SERVER['REMOTE_ADDR'], $mobio_remote_addrs)) {


	// your script action begins
	// mark user as VIP, add credits...

	$sms_reply = "Uspeshna obrabotka.";

	// your script action ends

	file("http://mobio.bg/paynotify/pnsendsms.php?servID=$servID&tonum=$fromnum&extid=$extid&message=".urlencode($sms_reply));
}
?>