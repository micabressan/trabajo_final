(function() {
  var OBJ_SIZE_5_CNT = 0;
  var OBJ_SIZE_10_CNT = 0;
  var OBJ_SIZE_20_CNT = 0;
  var OBJ_SIZE_30_CNT = 0;
  var OBJ_SIZE_50_CNT = 0;

  function position(object) {
    $(object).animate({
      left:(Math.round((Math.random()*($('body').width()-100))/50)*50)+30,
      top:(Math.round((Math.random()*($('body').height()-50))/50)*50)},0
    )} //Declares function which sets random position of given object.

    position(document.getElementById('target'));

  $('#target').click(function() {
    var score = parseInt($('#score').text());
    if (score === 100) {
      resetCounters();
      return;
    }
    // create random to determine size of 1 of 5 balls
    var ballObj = createObj();
    $('#target').css({"width": ballObj.size, "height": ballObj.size});
    // set new position
    position($('#target'));
    //optional display score: can limit to 100
    $('#score').text(score + 1);
  });

  function createObj(size) {
    var newRandom = Math.floor((Math.random() * 5) + 1);
    var objProperties = returnObjProperties(newRandom);
    if (objProperties.cnt > 20) {
      newRandom = Math.floor((Math.random() * 5) + 1);
      return createObj(newRandom);
    }
    return objProperties;
  }

  function resetCounters() {
    OBJ_SIZE_5_CNT = 0;
    OBJ_SIZE_10_CNT = 0;
    OBJ_SIZE_20_CNT = 0;
    OBJ_SIZE_30_CNT = 0;
    OBJ_SIZE_50_CNT = 0;
  }


  function returnObjProperties(input){
    var size;
    var cnt;

    switch (input) {
      case 1:
        size = 5;
        cnt = OBJ_SIZE_5_CNT += 1;
        break;
      case 2:
        size = 10;
        cnt = OBJ_SIZE_10_CNT += 1;
        break;
      case 3:
        size = 20;
        cnt = OBJ_SIZE_20_CNT += 1;
        break;
      case 4:
        size = 30;
        cnt = OBJ_SIZE_30_CNT += 1;
        break;
      case 5:
        size = 50;
        cnt = OBJ_SIZE_50_CNT += 1;
        break;
      default:
        size = 50;
        cnt = OBJ_SIZE_50_CNT += 1;
        break;
    }

    return {
      size: size,
      cnt: cnt
    }
  }
})();