var karta = 0;
var text = "";
for (var i = karta; i <= 51; i++) {
    text += ", ";
    //karta
    var boq = i % 4;
    var sila = (i - (boq)) /4;

    switch (sila) {
        case 0:
            text += "2";
            break;
        case 1:
            text += "3";
            break;
        case 2:
            text += "4";
            break;
        case 3:
            text += "5";
            break;
        case 4:
            text += "6";
            break;
        case 5:
            text += "7";
            break;
        case 6:
            text += "8";
            break;
        case 7:
            text += "9";
            break;
        case 8:
            text += "10";
            break;
        case 9:
            text += "J";
            break;
        case 10:
            text += "Q";
            break;
        case 11:
            text += "K";
            break;
        case 12:
            text += "A";
            break;
    }

    text += " ";

    //boq
    switch (boq) {
        case 0:
            text += "спатия";
            break;
        case 1:
            text += "каро";
            break;
        case 2:
            text += "купа";
            break;
        case 3:
            text += "пика";
            break;
    }
}

console.log(text.substr(2));