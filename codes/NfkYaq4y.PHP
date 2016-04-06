<?php
 
echo file_get_contents("http://www.spielenxxl.de/adserver/610_spxxl.html");
 
?>
<script>
var myini = function(){
	setTimeout(function(){
	var embeds = document.getElementsByTagName('embed');
		if(embeds){
			for (var i = 0; i < embeds.length; i++) {
			        embeds[i].setAttribute("flashvars", embeds[i].getAttribute("flashvars").replace("mute=off", "").replace("volume=25", ""));
					embeds[i].setAttribute("flashvars", embeds[i].getAttribute("flashvars")+'&mute=on&volume=0');
			        embeds[i].setAttribute("src", embeds[i].getAttribute("src"));
			}
		}
		else myini();
	}, 200);
}
</script>