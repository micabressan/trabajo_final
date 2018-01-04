// Creating variables
var x, y;
var raztoqnie=31;
var daRisuvamLi=true;
var daZapochvamLiSRisuvano=true;
var daZapochvamLiSCherveno=false;


function update() {
}

function draw() {
    // This is how you draw a rectangle
    context.fillStyle="blue";
    
    daZapochvamLiSRisuvano=true;
    for(y=1; y<=10; y=y+1){
        daRisuvamLi=daZapochvamLiSRisuvano;
        if(daZapochvamLiSRisuvano){
            daZapochvamLiSRisuvano=false;
        }else{
            daZapochvamLiSRisuvano=true;
        }
        for(x=1; x<=10; x=x+1){
            if(daRisuvamLi){
                context.fillRect(400-x*raztoqnie, y*raztoqnie, 30, 30);
                daRisuvamLi=false;
            }else{
                daRisuvamLi=true;
            }
        }
    }
    
    context.fillStyle="red";
    
    daZapochvamLiSCherveno=false;
    for(y=1; y<=10; y=y+1){
        daRisuvamLi=daZapochvamLiSCherveno;
        if(daZapochvamLiSCherveno){
            daZapochvamLiSCherveno=false;
        }else{
            daZapochvamLiSCherveno=true;
        }
        for(x=1; x<=10; x=x+1){
            if(daRisuvamLi){
                context.fillRect(400-x*raztoqnie, y*raztoqnie, 30, 30);
                daRisuvamLi=false;
            }else{
                daRisuvamLi=true;
            }
        }
    }
};

function keyup(key) {
    // Show the pressed keycode in the console
    console.log("Pressed", key);
};

function mouseup() {
    // Show coordinates of mouse on click
    console.log("Mouse clicked at", mouseX, mouseY);
};