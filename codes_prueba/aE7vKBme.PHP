Maping API V3
- ambildata.php

 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 
  <?php
    include "koneksi.php";
    $query = "SELECT       tagihandonatur.kodej AS kodeJ,
					       tagihandonatur.kwsn AS kwsn_mp,
					       count(tagihandonatur.infaq) AS org_mp,
					       sum(tagihandonatur.infaq) AS uang,
					       kawasan.ins_pk AS ins_pk_mp,
					       all_wilayah.NAMA_KEL AS kelurahan,
					       all_wilayah.NAMA_KEC AS NAMA_KEC,
					       all_wilayah.NAMA_KABKO AS NAMA_KABKO,
					       all_wilayah.NAMA_PROV AS NAMA_PROV,
					       all_wilayah.COORD AS COORD,
					       kawasan.alamat AS alamat_mp,
					       all_wilayah.lat AS lat,
					       all_wilayah.lng AS lng 
			   FROM        tagihandonatur 
			   LEFT JOIN   kawasan ON tagihandonatur.kwsn = kawasan.kwsn 
			   LEFT JOIN   all_wilayah on kawasan.iddesa = all_wilayah.ID_KEL
			   WHERE 	   kodeJ=0101
			   GROUP       BY tagihandonatur.kwsn ASC";

$data = mysql_query($query);
$json  = '{"wilayah": {';
$json .= '"petak":[ ';
while($x = mysql_fetch_array($data)){
	$json .= '{';
	$kawasan=mysql_query("SELECT 	tagihandonatur.kodej AS kodeJ,
									tagihandonatur.kwsn AS kwsn_mp,
									count(tagihandonatur.infaq) AS org_mp,
									sum(tagihandonatur.infaq) AS uang,
									kawasan.ins_pk AS ins_pk_mp,
									all_wilayah.NAMA_KEL AS kelurahan,
									kawasan.alamat AS alamat_mp
				   FROM        		tagihandonatur 
				   LEFT JOIN   		kawasan ON tagihandonatur.kwsn = kawasan.kwsn 
				   LEFT JOIN   		all_wilayah on kawasan.iddesa = all_wilayah.ID_KEL
				   WHERE       		tagihandonatur.kwsn='".$x['kwsn_mp']."'");
    
$hsl=mysql_fetch_array($kawasan);
    $json .= '"id":"'.$x['kwsn_mp'].'",
			  "judul":"'.htmlspecialchars($hsl['kelurahan']).'",
			  "deskripsi":"'.htmlspecialchars($hsl['alamat_mp']).'",
			  "kwsn":"'.htmlspecialchars($hsl['kwsn_mp']).'",
			  "insPK":"'.htmlspecialchars($hsl['ins_pk_mp']).'",
			  "org":"'.htmlspecialchars($hsl['org_mp']).'",
			  "tanda":"'.htmlspecialchars($hsl['kodeJ']).'",
			  "x":"'.$x['lat'].'",
			  "y":"'.$x['lng'].'",
			  "jenis":"'.$x['kodeJ'].'"
    },';
}
$json = substr($json,0,strlen($json)-1);
$json .= ']';
$json .= '}}';
echo $json;
 
?>
-----------------------------------------------------------------------------------------------------------------------------------------


- kordinat.php

||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 <html>
<head>
<title>Maping Jungut</title>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="jquery-1.4.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="css.css">

<script type="text/javascript">
var peta;
var pertama = 0;
var jenis = "";
var judulx = Array();
var kwsnx = Array();
var insPKx = Array();
var orgx = Array();
var desx = Array();
var i;
var url;
var gambar_tanda;
	
function peta_awal(){
    var surabaya = new google.maps.LatLng(-7.265757, 112.734146);
    var petaoption = {
        zoom: 12,
        center: surabaya,
        mapTypeId: google.maps.MapTypeId.HYBRID
        };
    peta = new google.maps.Map(document.getElementById("petaku"),petaoption);
    google.maps.event.addListener(peta,'click',function(event){
        kasihtanda(event.latLng);
    });
    ambildatabase('awal');
}
 
$(document).ready(function(){

    $("#tutup").click(function(){
        $("#jendelainfo").fadeOut();
    });
});


	
function set_icon(jenisnya){

    switch(jenisnya){
        case "0101":
            gambar_tanda = 'icon/atiq.png';
            break;
		case "0103":
            gambar_tanda = 'icon/chitof.png';
            break;	
		
    }
}
function ambildatabase(akhir){
   
    url = "ambildata.php";
    
    $.ajax({
        url: url,
        dataType: 'json',
        cache: false,
        success: function(msg){
            for(i=0;i<msg.wilayah.petak.length;i++){
                judulx[i] = msg.wilayah.petak[i].judul;
                desx[i] = msg.wilayah.petak[i].deskripsi;
				kwsnx[i] = msg.wilayah.petak[i].kwsn;
				insPKx[i] = msg.wilayah.petak[i].insPK;
				orgx[i] = msg.wilayah.petak[i].org;
 
                set_icon(msg.wilayah.petak[i].jenis);
                var point = new google.maps.LatLng(
                    parseFloat(msg.wilayah.petak[i].x),
                    parseFloat(msg.wilayah.petak[i].y));
                tanda = new google.maps.Marker({
                    position: point,
                    map: peta,
                    icon: gambar_tanda
                });
                setinfo(tanda,i);
 
            }
        }
    });
}
 
function setjenis(jns){
    jenis = jns;
}
 
function setinfo(petak, nomor){
    google.maps.event.addListener(petak, 'click', function() {
        $("#jendelainfo").fadeIn();
        $("#teksjudul").html(judulx[nomor]);
        $("#teksdes").html(desx[nomor]);
		$("#tekskws").html(kwsnx[nomor]);
		$("#teksins").html(insPKx[nomor]);
		$("#teksorg").html(orgx[nomor]);
		
    });
}
</script>
<style>
#jendelainfo{position:absolute;z-index:1000;top:70;
left:1040;background-color:yellow;display:none;}
</style>
</head>
<body onload="peta_awal()">
<center>
<h1>Kordinat Kawasan Jungut YDSF</h1>
<table id="jendelainfo" border="1" cellpadding="4" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFCC00" width="250" height="136">
  <tr>
    <td width="248" bgcolor="#000000" height="19"><font color=white>Kelurahan &nbsp; <span id="teksjudul"></span></font></td>
    <td width="30" bgcolor="#000000" height="19">
    <p align="center"><font color="RED"><a style="cursor:pointer" id="tutup" title="Tutup"><b><img src="icon/close.png"></b></a></font></td>
  </tr>
  <tr>
    <td width="290" bgcolor="#FFCC00" height="100" valign="top" colspan="2">
		<table>
			<tr>
				<td>Kawasan</td>
				<td>: <span id="tekskws"></span></td>
			</tr>
			
			<tr>
				<td>INSTANSI</td>
				<td>: <span id="teksins"></span></td>
			</tr>
			
			<tr>
				<td>ORG</td>
				<td>: <span id="teksorg"></span></td>
			</tr>
			
			<tr>
				<td>Alamat</td>
				<td>: <span id="teksdes"></span> </td>
			</tr>
		</table>
	  
   </td>
  </tr>
</table>
<form name="select"  method="post" action="kordinat.php">	
	<table border=0 width=75% align='left'>

		<tr>

			<td width=90%>
				<div id="petaku" style="width:90%px; height:540px"></div>
			</td>

			<td>
				<select name="pilih" onChange="payment()">
				<option value='0' class='input'>-----</option>
				<option value='0101' class='input'>0101</option>
				</select>
			</td>

		</tr>


	</table>
</form>
<br>
<table width="815" border="0" cellspacing="1" cellpadding="2" align="center">

          <div class="cleaner"></div>
</table>
</body>
</html>