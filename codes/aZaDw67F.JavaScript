var a = 5,
    text = "",
    zwezda = "*",
    space = " ";
// pyrvi red
for (var j = 0; j < a - 1; j++) {
    text += space;
}
text += zwezda;
console.log(text);

// sredni redove
for (var j = 1; j < a - 1; j++) {
    text = "";
    for (var i = 0; i < (a - 1) - j; i++) {
        text += space;
    }
    var text2 = "";
    for (var i = 1; i < j; i++) {
        text2 += space;
    }
    console.log(text + zwezda + text2 + space + text2 + zwezda);
}
// posleden red
text = "";
for (var j = 0; j < a - 1; j++) {
    text += zwezda;
}
text += zwezda;
for (var j = 0; j < a - 1; j++) {
    text += zwezda;
}
console.log(text);