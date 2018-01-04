for ( var i = 0; i < scores.length; i++) {
   for(var j = 0; j < scores.length - 1; j++) {
       if(scores[j + 1] > scores[j]){
          var temp = scores[j+1];
          scores[j + 1] = scores[j];
          scores[j] = temp;
}
}
}