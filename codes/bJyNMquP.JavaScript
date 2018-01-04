const Discord = require("discord.js");
const client = new Discord.Client();

/*States*****************
0 = Waiting for request**
1 = Waiting for players**
2 = Waiting for responses
3 = Waiting for votes****
4 = Ending**************/

const playersNeeded = 2;
const timeout = 10;

var curState = 0;

//The number of players should always be equal to the number of scores
var players = [];
var responses = [];
var score = [];

var questions = ["An international tribunal has found ______ guilty of ______.","And I would have gotten away with it, too, if it hadn’t been for ______!","Dear Sir or Madam, We regret to inform you that the Office of ______ has denied your request for ______.","He who controls ______ controls the world.","I learned the hard way that you can’t cheer up a grieving friend with ______.","In a pinch, ______ can be a suitable substitute for ______.","In his new self-produced album, Kanye West raps over the sounds of ______.","In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated ______.","In Rome, there are whisperings that the Vatican has a secret room devoted to ______.","In the distant future, historians will agree that ______ marked the beginning of America’s decline.","Michael Bay’s new three-hour action epic pits ______ against ______.","My plan for world domination begins with ______.","Next season on Man vs, Wild, Bear Grylls must survive the depths of the Amazon with only ______ and his wits."];
var curQuestion = 0;
//The channel where the bot will act
var boundChannel;

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});

var messageSent;

function startPhase(){
  curState = 3;
  boundChannel.send("GET READY FOR A RUMBLEEEEEEEEE!!!!!!!");
}

function sendQuestions(){
  curQuestion = Math.floor(Math.random() * questions.length);
  for(var i = 0; i < players.length;i++){
    players[i].send(questions[curQuestion]);
  }
  setTimeout(() => {startPhase();},timeout * 1000);
}

function checkPlayers(){
  if(players.length >= playersNeeded){
    boundChannel.send("Game is ready!");
    sendQuestions();
    curState = 2;
  }else{
    boundChannel.send("Not enough players.");
    boundChannel.send("Game will start if there are " + playersNeeded + " within the next "+timeout+" seconds.");
    setTimeout(() => { checkPlayers(); },timeout * 1000);
  }
}

client.on('message', msg => {

  /*Main Seperation*********************************
  'text' are messages send to a guild***************
  'dm' are messages sent by DM to the bot account.*/

  if(msg.channel.type == "text"){
    switch(curState){
      //Waiting for request
      case 0:
        //Start game command
        if(msg.content === "->start"){
          //Making sure everythis is clear
          players = []
          score = []
          responses = [];
          //Adding the player to the match
          players.push(msg.author);
          score.push(0);
          responses.push("");
          //Setting the game channel
          boundChannel = msg.channel;
          boundChannel.send(msg.author + " has started a game! Join now!");
          boundChannel.send(players.length + " players have joined!");
          //Advancing to the next phase
          curState = 1;
          setTimeout(() => { checkPlayers(); },timeout * 1000);
          break;
        }
        case 1:
          if(msg.content === "->join"){
            if(players.indexOf(msg.author) == -1){
              players.push(msg.author);
              score.push(0);
              boundChannel.send(msg.author + " just joined!");
              boundChannel.send(players.length + " players have joined!");
            }else{
              msg.reply("you are already in-game.");
            }
          }
          break;
    }
  }

  if(msg.channel.type == "dm"){
    if(players.indexOf(msg.author) != -1){
      switch(curState){
        case 2:
          responses[players.indexOf(msg.author)]
        break;
      }
    }
  }
});

client.login('Mzk2MzMyNjUxMTg4OTc3NjY3.DS1wRA.C1z_xRi094Ayj0Qeud5epi8SuQI');