:raphael_investigating_forest_2
  js FarmObjectManager.restoreMapTrees();
  + FarmObjectManager.updateMapEvents();

  switch hideFollowers ON
  $ create villager('Raphael', 1, 10, right);
  + change speed('Player', 3.5);
  + change speed('Raphael', 3.5);

  wait 40
  $ turn('Player', left)
  wait 10
  Player "Let's leave the cachaça somewhere around here and see if he shows up."
  Raphael "Leave it to me."

  wait 10
  $ turn('Player', right)
  wait 10
  $ move('Player', 7, 10, up);
  + move('Raphael', 9, 10, up)

  wait for Player
  $ move('Player', 7, 7, right)
  
  wait for Raphael
  $ move('Raphael', 9, 7, left)

  wait for Raphael
  wait for Player

  wait 10
  js window.cachacaEvent = $gameMap.createStaticIconEventAt(275, 8, 7, 0, true);

  $ move('Raphael', 10, 7, up);
  wait 5
  $ move('Player', 6, 7, up);

  wait for Raphael
  $ move('Raphael', 10, 5, left);
  
  wait for Player
  $ move('Player', 6, 5, right);

  wait for Raphael
  $ move('Raphael', 9, 5, down);

  wait for Player
  $ move('Player', 7, 5, down);
  
  wait for Raphael
  wait for Player

  wait 20
  Raphael "Now we wait."
  wait 30

  js AudioManager.fadeOutBgm(1);

  $ create villager('Curupira', 32, 8, left);
  + change speed('Curupira', 4.5);
  + change speed('Raphael', 4.5);
  + change speed('Player', 4.5);
  + move('Curupira', 8, 8, up);
  wait for Curupira

  wait 20
  Curupira "<wait>What is it that I see?<wait><wait><BR>A bottle of cachaça to drink!<wait><wait><BR>How dumb can they be?<wait><wait><BR>Much more than they think."

  wait 20
  $ move('Raphael', 10, 5, down);
  wait 5
  $ move('Player', 6, 6, down);
  $ move('Raphael', 10, 6, down);

  wait 15
  Curupira "<!:async>"
  $ jump('Curupira')
  wait 10
  $ jump('Curupira')
  wait 10

  wait for Player

  Curupira "<wait>The dumb ones were hidden.<wait><wait><BR>Try to catch me they will.<wait><wait><BR>In this forest forbidden.<wait><wait><BR>I won't stay still."
  js AudioManager.playBgmName('competition');
  wait 10
  $ jump('Curupira')
  wait for Curupira

  $ move('Curupira', 19, 8, down);
  
  wait 30

  $ move('Raphael', 19, 7, down)
  wait 5
  $ move('Player', 15, 7, down)
  
  wait for Curupira
  $ move('Curupira', 19, 12, left);
  
  wait for Raphael
  $ move('Raphael', 19, 12, left);

  wait for Curupira
  $ move('Curupira', 14, 12, up);

  wait for Raphael
  $ move('Raphael', 14, 12, up);

  wait for Curupira
  $ move('Curupira', 14, 9, right);

  wait for Raphael
  $ move('Raphael', 14, 9, right);

  wait for Curupira
  $ move('Curupira', 18, 9, down);

  wait for Raphael
  $ move('Raphael', 18, 9, down);

  wait for Curupira
  $ move('Curupira', 18, 11, left);

  wait for Curupira
  $ move('Curupira', 15, 11, up);

  wait for Raphael
  $ change speed('Raphael', 4.1)
  $ move('Raphael', 18, 11, left);
  

  wait for Curupira
  $ move('Curupira', 15, 9, right);

  wait for Raphael
  $ change speed('Raphael', 4.5)
  $ move('Raphael', 15, 11, up);
  wait for Curupira
  $ move('Curupira', 17, 9, down);
  wait for Raphael
  $ move('Raphael', 15, 9, right);
  wait for Curupira
  $ move('Curupira', 17, 11, left);
  wait for Raphael
  $ move('Raphael', 17, 9, down);
  wait for Curupira
  $ move('Curupira', 15, 11, up);
  wait for Raphael
  $ move('Raphael', 17, 11, left);
  wait for Curupira
  $ move('Curupira', 15, 9, right);

  wait for Raphael
  $ move('Raphael', 15, 11, up);
  wait for Curupira
  $ move('Curupira', 17, 9, down);
  wait for Raphael
  $ move('Raphael', 15, 9, right);
  wait for Curupira
  $ move('Curupira', 17, 11, left);
  wait for Raphael
  $ move('Raphael', 17, 9, down);
  wait for Curupira
  $ move('Curupira', 15, 11, up);
  wait for Raphael
  $ move('Raphael', 17, 11, left);
  wait for Curupira
  $ move('Curupira', 15, 9, right);

  wait for Raphael
  $ move('Raphael', 15, 11, up);
  wait for Curupira
  $ move('Curupira', 17, 9, down);
  wait for Raphael
  $ move('Raphael', 15, 9, right);
  wait for Curupira
  $ move('Curupira', 17, 11, left);

  $ move('Player', 15, 9, down);

  wait for Raphael
  $ move('Raphael', 17, 9, down);
  wait for Curupira
  $ move('Curupira', 15, 11, up);
  wait for Raphael
  $ move('Raphael', 17, 11, left);
  wait for Curupira
  $ move('Curupira', 15, 10, up);
  wait for Raphael
  $ move('Raphael', 15, 11, up);

  Curupira "<!:async>"
  $ jump('Curupira')
  wait 15
  $ jump('Curupira')
  wait 10

  js AudioManager.fadeOutBgm(1);

  $ turn('Curupira', down)
  wait 10
  $ jump('Curupira')
  wait 15
  $ jump('Curupira')
  wait 10

  $ turn('Curupira', up)
  wait 10

  $ restore speed('Player')

  wait 30
  Curupira "<wait>Humans were fast<wait><wait><BR>But Curupira has magic<wait><wait><BR>State what you want<wait><wait><BR>Or your fate will be tragic."

  js $gameMap.autoplay();
  wait 15

  Player "We just want to ask you why you put a spell on this forest."
  Curupira "<wait>When animals are mating<wait><wait><BR>Young ones will spawn<wait><wait><BR>If birdbrains come hunting<wait><wait><BR>Their families are done."
  Raphael "So you did this to protect the animals for mating season?"
  Player "That's understandable."
  Raphael "And when do you think you'll be able to lift this spell?"

  js if TimeManager.totalDays < 62
    Curupira "<wait>When the leaves turn yellow<wait><wait><BR>When the grapes become blue<wait><wait><BR>Young animals are mellow<wait><wait><BR>I'll lift it for you."
    Raphael "When the leaves turn yellow?"
    Player "And the grapes become blue. Do you mean in autumn?"
    Raphael "I guess we will have to wait until then."
  else
    Curupira "<wait>Animals have grown<wait><wait><BR>The new birds are flying<wait><wait><BR>The old spell is gone<wait><wait><BR>I swear I'm not lying."
    Raphael "So the animals have already grown. Does this mean we can cross the forest now?"
    Player "That is great. Thank you, Curupira."
    switch forestSpellLifted ON
  end

  Curupira "<wait>Curupira is done here<wait><wait><BR>Take cachaça and leave<wait><wait><BR>If humans hunt animals<wait><wait><BR>A curse I'll conceive."
  switch talkedToCurupira ON

  $ move('Curupira', 8, 10, up)
  wait 20
  $ turn('Player', left);
  + turn('Raphael', left);

  wait for Curupira
  $ move('Curupira', 8, 8, up)
  wait for Curupira
  wait 20
  js window.cachacaEvent.erase();
  wait 20
  $ move('Curupira', 13, 8, right)
  wait for Curupira
  $ turn('Player', up);
  + turn('Raphael', up);
  $ move('Curupira', 18, 8, right)
  wait for Curupira
  $ turn('Player', right);
  + turn('Raphael', right);
  $ move('Curupira', 32, 8, right)
  wait for Curupira
  remove curupira

  wait 30

  $ turn('Player', down);
  + turn('Raphael', up);

  wait 30
  Raphael "I guess we are done here."
  Player "Yeah, let's go back."
  
  wait 30

  $ move('Player', 0, 9, left);
  + move('Raphael', 0, 11, left);
  + change speed('Player', 3);
  + change speed('Raphael', 3);

  wait 60

  fade out
  wait 30
  switch hideFollowers OFF
  js $gamePlayer.reserveTransfer(Maps.FOREST_W, 30, 10, Direction.LEFT, 0, true);

  wait 1
  end cutscene
  fade in

  js RelationshipManager.markCharacterAsKnown('Curupira')
  complete curupira-task-5