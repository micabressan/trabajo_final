var scores, currentScore, game, activePlayer, previousRolls, double, goal;

start();
goal = $('#score-limit').val();

$('.btn-roll').on('click', function(){
    if (game){
 $('.dice').show();
 $('.dice-2').show();
 var dice =  Math.floor(Math.random() * 6) + 1;
 var dice2 = Math.floor(Math.random() * 6) + 1;
 $('.dice').attr('src','dice-' + dice + ".png");
 $('.dice-2').attr('src','dice-' + dice2 + ".png");
 if ((dice === 6 || dice2 === 6) && previousRolls.indexOf(6) > -1){
     scores[activePlayer] = 0;
     currentScore = 0;
     $('#current-' + activePlayer).text(currentScore);
     $('#score-' + activePlayer).text(scores[activePlayer]);
     next();
 }
 if (dice !== 1 && dice2 !== 1){
     currentScore += dice + dice2;
     $('#current-' + activePlayer).text(currentScore);
     previousRolls = [dice, dice2];     
 }else{
     next();
 }}
});

$('.btn-hold').on('click', function(){
    if (game) {
   scores[activePlayer] += currentScore;
   $('#score-' + activePlayer).text(scores[activePlayer]);
   
   if (scores[activePlayer] >= goal){
      $('#name-' + activePlayer).text('Winner');
      $('.player-' + activePlayer + '-panel').addClass('winner');
      game = false;
   }else{
      next();  
   }}
 
});
$('.btn-new').on('click', start);


function next(){   
     currentScore = 0;
     $('#current-' + activePlayer).text(currentScore); 
     activePlayer === 0 ? activePlayer = 1 : activePlayer = 0;
     $('.panel').toggleClass('active');    
}


function start(){
    scores = [0,0];
    currentScore = 0;
    game = true;
    activePlayer = 0;
    $('#current-0').text(currentScore);
    $('#current-1').text(currentScore);
    $('#score-0').text('0');
    $('#score-1').text('0');
    $('#name-0').text('Player 1');
    $('#name-0').text('Player 2');
    $('.panel').removeClass('winner');
    $('.dice').hide();
    $('.dice-2').hide();
}