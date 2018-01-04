var a = 0,
    text = "";
for (var i = 0; i < 9; i++) {
   for (var j = 0; j < 9; j++) {
    a++;
   if (a > 9) {
    a = a - 9; 
   }
    text += a + " ";
   }
console.log(text);
   text = ""
   a++
}