var computerchoice = Math.random();
var banned = ["nil", "MrBean", "brotchen"];
var jscommands = [["alert", "prompt", "confirm"], ["function", "var"], ["for", "do", "while"], ["if", "else", "switch", "case", "?", ":"]]; //these two vars are used by commands.
var HackChat = require('./hackchat.js');
var chat = new HackChat();
var channelName = 'programming'; //former botDev
var botName = 'StamBot#mamamia'; //former hackbot
var channel = chat.join(channelName, botName);
var funfacts = ["While Idi Amin was the leader of Uganda, hundreds of thousands of people died or had their lives destroyed just because their leader was paranoid. Idi Amin, after the tanzanian invasion, escaped towards Libya and died in Saudi Arabia by heart attack in 2003. No one ever punished him.",
           "The effects of crippling depression can include a persistent but overwhelming pain in the chest and the urge to kill oneself.",
           "In 1986, a single man was stranded on an island when the container ship he was captaining sunk. While alone, he became so depressed that he tied rocks to his feet and jumped into the ocean to drown himself. "
           , "In concentration camps, Jews were tortured by cutting off their scrotum and jamming it down their throat. This effectively cut off their air supply until they died of suffocation.", 
           "Some child workers in Asia work so hard that their fingers are ground down to bloody stumps.", 
           "One of the best ways to commit suicide is by train. The train conductor has no control over whether or no you die, but the blame is ultimately placed on him and he has to live the rest of his life in guilt knowing that he killed a man.", 
           "During the potato famine in Ireland, people were so hungry that they were forced to eat their own children alive. The children would kick and scream, but in the end their flesh helped their parents live on.", 
           "Right now, there are children in Ethiopia who will never eat in the entirety of their short lives. They live with an undying pain in their abdomen from the horrible hunger.", 
           "While in the gas cambers, Jews experienced a crippling pain in their chest. This pain could go on for hours. Because of this, many innocent Jews committed suicide before they could be killed by their Nazi rulers.", 
           "In the last 5 years, ISIS has killed thousands of innocent, unsuspecting civilians. These poor people are taken from their homes and family and tortured for days on end until their death.",
           "Recently, two 10-year-olds took a baby from its parents with no reason. Thy tortured it badly: They took its penis off, they sticked batteries in its ass and nose and other creepy stuff. In the end, they threw it to the trail rails and it was killed. The one 10-year-old committed suicide and the other one will soon get out of jail.",
           "Recently, in Greece, some Albanian moron choked his 4-year-old daughter, cut her into pieces and cooked them. Then he threw them randomly in different place in Athens. At least he got caught."]; //funfact command.
function al(arrayname) { //al means array loop.
    for(var i = 0; i < arrayname.length; i++) {
      out(arrayname[i]);
    }
} 
var banned = ["nil", "MrBean"];
function out(text) { //too bored to write channel.sendMessage().
  channel.sendMessage(text)
}
chat.on("chat", function(session, nick, text) {
  if (nick != botName) {
    if (text[0] == " " && banned.indexOf(Nick) == -1) {
      var cmd = text.substr(1).split(" ")[0];
      switch(cmd) {
        case 'terms':
          if(nick == "stamsarger") {
            out('If you use this bot, you accept these terms. I have the right to ban you whenever I want, even if you have not done anything wrong. Also, if you use the spam command multiple times, you are responsible for what happens next.');
          }
          break;
        case 'theworldshardestgame':
          out('I can\'t even get past the 6th stage >< http://www.addictinggames.com/action-games/theworldshardestgame.jsp');
          break;
        case 'screw':
          var screwhits = [];
          for(var looping = 7; looping <= text.length; looping++){
            screwhits.push(text[looping]);
          }
          screwhits = screwhits.join('');
          if(screwhits.length === 0){
            out('Pick a name to screw.');
          } else {
              out('SCREW YOU, ' + screwhits + "! YOU'RE AN ASSHOLE!");
          }
          break;
        case "hello":
          out("Hello. I $like$ you. Know what I mean? ;)");
          break;
        case 'shutup':
          out("I hope that you die. $You$ shut up, sick bastard.")
          break;
        case 'rock':
          if(computerchoice <= 0.5) {
            out("Paper. Paper wins!")
          } else {
            out("Scissors. Rock wins!")
          }
          break;
        case 'paper':
          if(computerchoice <= 0.5) {
            out("Rock. Paper wins!")
          } else {
            out("Scissors. Scissors wins!")
          }
          break;
        case 'scissors':
          if(computerchoice <= 0.5) {
            out("Rock. Rock wins!")
          } else {
            out("Paper. Scissors wins!")
          }
          break;
        case 'help':
          out("$Yeah,$ $you$ $do$ $need$ $help.$ $There$ $is$ $the$ $commands$ $command,$ $moron.$")
          break;
        case 'commands': //some morons cant understand what I mean with "Add a space (' ') before:". Fucking idiots...
          out("Add a space (' ') before: theworldshardestgame, screw, jscommand, jscommands, funfact, bloodsipper, yolo, siri, stamsarger, learntocode, anonymous, source, fuck, bang, french, greek, rockpaperandscissors, cookie, bacon, afk, spam, about, help, commands, rock, paper, scissors, shutup, hello.")
          break;
        case 'about':
          out('I\'m stamsarger\'s cruel bot. I\'m still under development.')
          break;
        case 'afk': //I had a for loop here, but I took it away
          out("Go get fucked, dye yourself blue and jump to the see. I DON'T GIVE A FUCK IF YOU ARE AFK. GET OUT. NOW. GET OUT.")
          break;
        case 'cookie':
          var towhom = [];
          for(var loopper = 8; loopper <= text.length; loopper++){
            towhom.push(text[loopper]);
          }
          towhom = towhom.join('');
          out(nick + " gives " + towhom + ' some cookies.'); 
          break;
        case 'bacon': //I mean the food, not the user bacon.
          out("Fuck bacon.");
          break;
        case 'rockpaperandscissors': //totally useless command
          out("What do you choose? rock,  paper,  scissors.");
          break;
        case ' ':
          var shitnjughjnmjnbmkmnjgbvhmn = 1;
          break;
        case 'greek':
          out("Γεια. Πάμε ?gr.") // means "Hello. Lez go to ?gr."
          break;
        case 'french': //means "I don't think there are many French here, but you can go to ?fr."
          out("Je crois qu'il n'y a pas beaucoup de Francais ici, mais tu peux aller a ?fr.")
          break;
        case 'fuck':
          out("I like it when you are miserable.");
          break;
        case 'bang': //reaallllyyyyy.
          out('Congrats, dude! You finally banged a woman. Nothing to be ashamed of.')
          break;
        case 'source': //even though this is open source.
          out('Open-source apps are idiotic crap.')
          break;
        case 'anonymous': //some new guy might even fall for that shit.
          out('We are anonymous. We are legion. We do not forgive, we do not forget. Expect us.');
          break;
        case 'learntocode': //yo.
          out("Try http://codecademy.com and http://udemy.com. They're both awesome. For a text editor, I recommend using Sublime Text 2, Programmer's Notepad (if your main language is English) or Atom. The best JavaScript browser is Microsoft Edge, alternatively you can use Chrome. They handle JS the best.")
          break;
        case 'stamsarger': //:p
          out('HEEEEEYYYYYY STAAAAAAMMMMMMM I NEED YAAAAAA');
          break;
        case 'siri':
          var sirihits = [];
          for(var siri = 0; siri < text.length; siri++) {
            if(text[siri] == "h" || "H" || "c" || "C") {
              for(var sirihelp = siri; sirihelp < (text.length - siri); sirihelp++) {
                sirihits.push(text[sirihelp]);
                if(sirihits.length === "help".length || "commands".length) {
                  sirihelp = text.length - 1;
                }
              }
            } else {
              for(var sirijs = siri; sirijs <= (text.length - siri); sirijs++){
                sirihits.push(text[sirijs]);
                if(sirijs.length == "jscommands".length || "jscommand".length || "js".length){
                  sirijs = text.length - 1;
                }
              }
            }
          }
          sirihits = sirihits.join("");
          sirihits = sirihits.toLowerCase();
          if(sirihits.length == 0){
            out('Wrong usage of the command. Your command wasn\'t found or you\'re just stupid.')
          }
          if(sirihits == "help" || "commands") {
            out("Add a space (' ') before: screw, jscommand, jscommands, funfact, bloodsipper, yolo, siri, stamsarger, learntocode, anonymous, source, fuck, bang, french, greek, rockpaperandscissors, cookie, bacon, afk, spam, about, help, commands, rock, paper, scissors, shutup, hello.");
          } else if(sirihits == "js" || "jscommands" || "jscommand"){
            out('You can use  jscommand to see a js command.');
          }
          break;
        case 'yolo':
          out('$Y$ou $O$nly $L$ive $O$nce');
          break;
        case 'funfact': //thanks to Jax for writting them all apart from the last one, which is mine.
          var choosefact = Math.random() * 12;
            if(choosefact <= 1) {
              out(funfacts[0])
            } else if(choosefact <= 2) {
              out(funfacts[1]) 
            } else if(choosefact <= 3) {
              out(funfacts[2])
            } else if(choosefact <= 4) {
              out(funfacts[3])
            } else if(choosefact <= 5) {
              out(funfacts[4])
            } else if(choosefact <= 6) {
              out(funfacts[5])
            } else if(choosefact <= 7) {
              out(funfacts[6])
            } else if(choosefact <= 8) {
              out(funfacts[7])
            } else if(choosefact <= 9) {
              out(funfacts[8])
            } else if(choosefact <= 10) {
              out(funfacts[9])
            } else if(choosefact <= 11) {
              out(funfacts[10])
            } else {
              out(funfacts[11])
            }
          break;
        case 'jscommand': //this kinda makes me js expert, doesn't it?
          var jschoose = Math.random();
          if(jschoose <= 0.25) {
            jschoose = 1;
            jschoose = Math.random();
            if(jschoose <= 0.33){
              out('Notifying commands. A nice JavaScript command is alert(). It asks the user whether they want to do something, or it notifies them.');
            } else if(jschoose <= 0.66){
              out('Notifying commands. A nice JavaScript command is prompt(). It asks the user something, and it expects an answer. Depending on the answer, some other alert()s and prompt()s will show up.');

            } else {
              out('Notifying commands. A nice JavaScript command is confirm(). It is the same as alert().');
            }
          } else if(jschoose <= 0.5){
            jschoose = 1;
            jschoose = Math.random();
            if(jschoose <= 0.5){
              out('Keywords. A nice JavaScript keyword is function. It declares functions, so that you won\'t need to write the same code again. It works like this: ');
              out('function example(parameter1, parameter2) { //do this }')
            } else{
              out('Keywords. A nice JavaScript keyword is var. It declares variables that store a value. It could be anything from the data types.')
            }
          } else if(jschoose <= 0.75){
            jschoose = 1;
            jschoose = Math.random();
            if(jschoose <= 0.33){
              out('Loops. While loops are really powerful. They can do whatever for loops do with another syntax. Furthermore, they\'re awesome if you wanna loop and you dunno when to stop. while(condition) { // do this }. Be careful! The condition must change in the while loop or else you\'ll get an infinite loop.')
            } else if(jschoose <= 0.66){
              out('Loops. Do/while loops are the same as while loops, however they make sure these things happen before the loop starts. do { //stuff } while(condition)');

            } else {
              out('Loops. For loops are much more powerful and flexible than the other loops. Their syntax is harder to learn. You can also nest for loops. for(var i = 0; i <= 8; i += 1) { document.write("sup")} will output "sup" eight times.')
            }
          } else {
            jschoose = 1;
            jschoose = Math.random();
            if(jschoose <= 0.33) {
              out('Conditionals. ?: are called ternary. They are short if statements. E.g.: var isItTrue = 10 > 100 ? "yes" : "no" document.write(isItTrue) outputs \'no\'.')
            } else if(jschoose <= 0.66) {
              out('Conditionals. Switch statements are da best if you have a lot of conditions and you don\'t wanna write so much. They are good for variables asking for input. eg: var a = prompt("What\'s your favorite room?") switch(a) { case "bedroom": //do this break; case "kitchen": alert("Mine too!") break; default: alert("Awesome!")}')
            } else {
              out('Conditionals. This is the master: If/else if/else statements are the most powerful and used conditionals. For instance: if(condition) { // do this } else if(2nd condition) { // stuff } else { // otherwise, do this }')
            }
          }
          break;
        case 'jscommands':
          al(jscommands); //i have a feeling that I'll use this function a lot.
          break;
        default:
          out('Yeah, you wrote ' + cmd + ', so? Does that make a difference to your life?');
      }
    }
  }
});