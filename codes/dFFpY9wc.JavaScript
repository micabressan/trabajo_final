// ==UserScript==
// @name Player ranking colouring nlp4
// @namespace info.blargh.player.ranking.colour
// @description Colours players you can attack on nlp4's ranking
// @include https://nlp4.tribalwars.nl/game.php?*screen=ranking*
// @version 1
// @grant none
// @new editor     Donlee
// ==/UserScript==

pp = parseInt(document.getElementById("rank_points").innerHTML.replace(/[^\d]/g,""));
rng = [(pp/17.5)*10,pp*1.75];
nrng = [(pp/18.0)*10,pp*1.80];

a=document.querySelector("#player_ranking_table");
if (a){
t=document.createElement("div");
t.innerHTML="<b>01.01.2018 tot 25.01.2018 Aanvals blockade(175%) is:</b> "+Math.round(rng[0])+" tot "+Math.round(rng[1])+" punten <br /><b> </b> <br /><b>volgende verandering</b> <br /><b> 25.01.2018 Aanvalsbeperking zal aangepast worden om aanvallen toe te laten op spelers 80% groter/kleiner dan jou.</b> <br /><b> 25.01.2018 Prijs Goudmunten zullen verlaagd worden naar 50% van de basisprijs.</b> <br /><b>nieuwe blockade(180%) is:</b> "+Math.round(nrng[0])+" tot "+Math.round(nrng[1]);



a.parentNode.insertBefore(t,a);
r = document.querySelectorAll("#player_ranking_table tr");
for (i=1; i< r.length; i++){
if (r.className!="lit"){
p = parseInt(r.querySelector("td:nth-child(4)").innerHTML.replace(/[^\d]/g,""));
if (p > rng[0] && p < rng[1]){
r.style.color ="Green";
}
else if (p > nrng[0] && p < nrng[1]){
r.style.color ="Purple";
}
}
}
}