var boxcount = 3; // Vi har tre lådor
var boxsize = 2; // Varje låda har två kulor
var boxes = [[0, 0], [0, 1], [1, 1]]; // 0 är silver, 1 är guld - som ordstävet lyder?
var boxChoices = [0, 0, 0]; // Hur många gånger vi valt respektive låda
var ballChoices = [0, 0]; // Hur många gånger vi valt den första respektive andra kulan, för den låda vi valt
var goldCountWhenFirstGold = 0; // Antalet guldkulor som nummer två, givet att första är guld
var silverCountWhenFirstGold = 0; // Antalet silverkulor som nummer två, givet att första är guld
var attempts = 1000000; // Så här många simuleringar kör vi

for (var i = 0; i < attempts; i ++) {
    var boxPick = Math.floor(Math.random() * boxcount) // Väljer på måfå ett lådnummer
    boxChoices[boxChoice] += 1; // Bokför valet av låda
    var boxChoice = boxes[boxPick]; // Den låda vi valt    
    var ballPick = Math.floor(Math.random() * boxsize); // Väljer på måfå ett kulnummer
    var ball = boxChoice[ballPick];
    
    if (ball == 0) { // Vi har plockat upp en silverkula, så vi kastar detta resultat.
        continue;
    }

    var otherBall = ballPick == 0 // Här hämtar vi upp den andra bollen
        ? boxChoice[1]
        : boxChoice[0];

    if (otherBall == 0) {
        silverCountWhenFirstGold++;
    } else {
        goldCountWhenFirstGold++;
    }
}

console.log("Antal guldkulor: " + goldCountWhenFirstGold);
console.log("Antal silverkulor: " + silverCountWhenFirstGold);