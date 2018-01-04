var attack_mode=true;
var target;
var nearestHostile;
var nearestMonster;
var near = get_nearest_monster({no_target:true});
var enemys = [
	'chestm',
	'arcticbee',
	'armadillo',
	'bat',
	'bee',
	'booboo',
	'croc',
	'wolfie',
	'dknight2',
	'mvampire',
	'eelemental',
	'greenfairy',
	'bluefairy',
	'redfairy',
	'felemental',
	'frog',
	'ghost',
	'goldenbat',
	'goo',
	'greenjr',
	'bigbird',
	'crabx',
	'cgoo',
	'jr',
	'kitty4',
	'kitty1',
	'kitty2',
	'kitty3',
	'pinkgoo',
	'mole',
	'mrgreen',
	'mrpumpkin',
	'fvampire',
	'mummy',
	'nelemental',
	'phoenix',
	'poisio',
	'minimush',
	'bbpompom',
	'puppy3',
	'puppy2',
	'puppy4',
	'puppy1',
	'rat',
	'jrat',
	'rudolph',
	'xscorpion',
	'gscorpion',
	'scorpion',
	'skeletor',
	'snake',
	'osnake',
	'goblin',
	'snowman',
	'spider',
	'plantoid',
	'squig',
	'squigtoad',
	'stompy',
	'stoneworm',
	'target_a500',
	'target_r500',
	'target_ar500red',
	'target_a750',
	'target_r750',
	'target',
	'target_ar900',
	'crab',
	'tortoise',
	'wabbit',
	'welemental',
	'iceroamer',
	'wolf',
	'boar'
];
i = 0;
z = 0;
y = 0;
var br = parent.document.createElement('br');
var br2 = parent.document.createElement('br');
var br3 = parent.document.createElement('br');
var div = parent.document.createElement('div');
var personalisation = parent.document.createTextNode('Personalisation');
var select = parent.document.createElement('select');
var option1 = parent.document.createElement('option');
var option2 = parent.document.createElement('option');
var option3 = parent.document.createElement('option');
var option4 = parent.document.createElement('option');
var color = parent.document.createElement('input');
var button = parent.document.createElement('button');
var button2 = parent.document.createElement('button');
var alert = parent.document.createTextNode('ON');
var alert2 = parent.document.createTextNode('OFF');
var monsters = parent.document.createTextNode('Monster');
var input = parent.document.createElement('input');
input.setAttribute('type','text');
input.style.marginBottom = '3px';
input.id = 'monster';
button.style.color = '#00FF00';
button.style.backgroundColor = '#000000';
button.style.width = '100px';
button.style.height = '30px';
button.style.marginTop = '5px';
button.addEventListener('click',functions);
button2.style.color = '#00FF00';
button2.style.backgroundColor = '#000000';
button2.style.width = '100px';
button2.style.height = '30px';
button2.style.marginTop = '5px';
button2.addEventListener('click',function(){
	clearInterval(hour);
	clearInterval(minute);
	clearInterval(second);
});
option1.text = 'Text';
option2.text = 'Background';
option3.text = 'Button Background';
option4.text = 'Button Text';
option1.value = 'Text';
option2.value = 'Background';
option3.value = 'Button Background';
option4.value = 'Button Text'
option1.id = 'Text';
option2.id = 'Background';
option3.value = 'Button_Background';
option4.value = 'Button_Text'
select.add(option1, null);
select.add(option2, null);
select.add(option3, null);
select.add(option4, null)
select.style.marginRight = '5px';
color.setAttribute('type','color');
color.setAttribute('id','color');
div.setAttribute('id','Personalisation');
div.style.width = '250px';
div.style.height = '150px';
div.style.backgroundColor = '#000000';
div.style.zIndex = '999';
div.style.position = 'fixed';
div.style.right = '68px';
div.style.bottom = '280px';
div.style.textAlign = 'center';
div.style.color = '#00FF00';
div.style.border = '5px solid gray';
div.style.fontSize = '30px';
div.style.paddingTop = '5px';
button.appendChild(alert);
button2.appendChild(alert2);
div.appendChild(personalisation);
div.appendChild(br);
div.appendChild(select);
div.appendChild(color);
div.appendChild(br2);
div.appendChild(monsters);
div.appendChild(input);
div.appendChild(br3);
div.appendChild(button);
div.appendChild(button2);
parent.document.body.appendChild(div);

////////////////////////////////////////////////////////////

var br = parent.document.createElement('br');
var div2 = parent.document.createElement('div');
var information = parent.document.createTextNode('Information');
var span = parent.document.createElement('span');
var running = parent.document.createTextNode('Running: ');
var spanhours = parent.document.createElement('span');
var spanminutes = parent.document.createElement('span');
var spanseconds = parent.document.createElement('span');
var hours = parent.document.createTextNode('00:');
var minutes = parent.document.createTextNode('00:');
var seconds = parent.document.createTextNode('00');
span.setAttribute('id','spann');
spanhours.setAttribute('id','spanhours');
spanminutes.setAttribute('id','spanminutes');
spanseconds.setAttribute('id','spanseconds');
div2.setAttribute('id','Informations');
div2.style.width = '250px';
div2.style.height = '150px';
div2.style.backgroundColor = '#000000';
div2.style.zIndex = '999';
div2.style.position = 'fixed';
div2.style.right = '68px';
div2.style.bottom = '445px';
div2.style.textAlign = 'center';
div2.style.color = '#00FF00';
div2.style.border = '5px solid gray';
div2.style.fontSize = '30px';
div2.style.paddingTop = '5px';
div2.appendChild(information);
div2.appendChild(br);
div2.appendChild(running);
div2.appendChild(spanhours);
div2.appendChild(spanminutes);
div2.appendChild(spanseconds);
spanhours.appendChild(hours);
spanminutes.appendChild(minutes);
spanseconds.appendChild(seconds);
div2.appendChild(span);
parent.document.body.appendChild(div2);
circle();

setInterval(function(){
 	target = get_targeted_monster();
	//nearestHostile = get_nearest_hostile({exclude:['Wizard','Protos','Gensei','SixSix','Symphony','nightwatch','mojothecat','mojohthecat3','mojopriest','Death','iamanoob','Foaly','SpadarFaar','Maela','Meadow','Brutus','Garth','nobodyhere','nobodythat','nobodutanks','mark','nexusnull','Trexnamedtud','Trexnamedted','Pluet','Plu2','Pluu','Paloo','nobodymerch','belo101','Fuzure','Fuzure1','Appaa','Phoenix','Khaizer','Sawanstor','OWN4GE','Zaqowity','Scythe','Laxus'],friendship:false});
},1000/1000);

function circle(){
	draw_circle(character.real_x,character.real_y,character.range,1,0xFF0000);
}

setInterval(function hp(){
	
	if(character.hp <= character.max_hp - 200){use(0);}
	else if(character.hp <= character.max_hp - 400){use(2), use_skill('burst',nearestHostile);}
	if(character.mp <= character.max_mp - 300){use(1);}
	else if(character.mp <= character.max_mp - 500){use(3);}
	
	loot();
	
},1000/3); //Loops every 0.33 seconds


setInterval(function attacking(){
	if(!attack_mode || is_moving(character)) return;
	
if(nearestHostile == null)
{
    if(!target && nearestMonster != null)
    {
        target = nearestMonster;
        change_target(target);
    }
}
	if(can_attack(target))
	{
		attack(target);
	}
	else{
	change_target(null);
	}
},1000/1000);

function on_draw(){
	if(is_moving(character)){
	clear_drawings();
	circle();
	}
}
function hour(){
setInterval(function hours(){
	spanhours.innerHTML = y++;
	if(spanhours.innerHTML<9){
		spanhours.innerHTML = "0"+y+":";
	}
	else if(spanhours.innerHTML>=9 && spanhours.innerHTML<59){
		spanhours.innerHTML = y+":";
	}
	else if(spanhours.innerHTML>=59){
			spanhours.innerHTML = "00:";
		y = 0;
	}
},60000*60);
};
function minute(){
setInterval(function minutes(){
	spanminutes.innerHTML = z++;
	if(spanminutes.innerHTML<9){
		spanminutes.innerHTML = "0"+z+":";
	}
	else if(spanminutes.innerHTML>=9 && spanminutes.innerHTML<59){
		spanminutes.innerHTML = z+":";
	}
	else if(spanminutes.innerHTML>=59){
			spanminutes.innerHTML = "00:";
		z = 0;
	}
},1000*60);
};
function second(){
setInterval(function seconds(){
	spanseconds.innerHTML = i++;
	if(spanseconds.innerHTML<9){
		spanseconds.innerHTML = "0"+i;
	}
	else if(spanseconds.innerHTML>=9 && spanseconds.innerHTML<59){
		spanseconds.innerHTML = i;
	}
	else if(spanseconds.innerHTML>=59){
			spanseconds.innerHTML = "00";
		i = 0;
	}
},1000);
};
function check(){
var colors = parent.document.querySelector('#color').value;
var monsterr = parent.document.querySelector('#monster').value;
	if(option1.selected==true){
		div.style.color = colors;
	}
	else if(option2.selected==true){
		div.style.backgroundColor = colors;
	}
	else if(option3.selected==true){
		button.style.backgroundColor = colors;
	}
	else if(option4.selected==true){
		button.style.color = colors;
	}
	
	if(monsterr==""){
setInterval(function monsterrr(){nearestMonster = get_nearest_monster({no_target:true});},1000/1000);
			set_message("Monster: nearest");
	}
	else if(!(enemys.indexOf(monsterr) != -1)){
setInterval(function monsterrr(){nearestMonster = get_nearest_monster({no_target:true});},1000/1000);
		set_message("Put correct name");
	}
	else if(monsterr!=""){
			setInterval(function monsterrr(){nearestMonster = get_nearest_monster({no_target:true,type:monsterr});},1000/1000);
			set_message("Monster: "+monsterr);
	}
};
function functions(){
	check();
	second();
	minute();
	hour();
}
setInterval(function colors(){
		var colors = parent.document.querySelector('#color').value;
		var monsterr = parent.document.querySelector('#monster').value;
},100);