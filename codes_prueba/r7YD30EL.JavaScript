1 <input type=checkbox id="number1" onclick="updateProperties();">
2 <input type=checkbox id="number2" onclick="updateProperties();">
3 <input type=checkbox id="number3" onclick="updateProperties();">
4 <input type=checkbox id="number4" onclick="updateProperties();">
5 <input type=checkbox id="number5" onclick="updateProperties();">
6 <input type=checkbox id="number6" onclick="updateProperties();">
7 <input type=checkbox id="number7" onclick="updateProperties();">
8 <input type=checkbox id="number8" onclick="updateProperties();">
9 <input type=checkbox id="number9" onclick="updateProperties();" checked="true">
<br>mnożenie <input type=checkbox id="multiply" onclick="updateProperties();" checked="true">
<br>dzielenie <input type=checkbox id="divide" onclick="updateProperties();">
<br>Czas: <input type="text" id="timeLimit" style="width: 30px;height: 20px;" autocomplete="false">
<br><br><input type="button" id="button"value="Start" onclick="buttonPressed();">
<center>
<b id="timeLeft"></b>
<br>
<b id="correct"></b>
<br>
<b id="equation"></b>
 <input type="text" id="answer" onkeyup="checkAnswer();">

</center>




<script type=text/javascript>
var intervalHolder
var timeLimit;
var validated = false;
var started = false;
var first = 0;
var second = 0;
var answer = 0;
var correct = 0;
var operation = "";
numbers = [9];

function checkAnswer()
{
	if(started == true)
	{
		var gAnswer = document.getElementById("answer").value;
		if(gAnswer == answer)
		{
			correct++;
			document.getElementById("correct").innerHTML="Poprawnie: "+correct;
			generate();
		}
		else{console.log(first+" * "+second+" = "+gAnswer+" ---- wrong");};
	};
}

function generate()
{
	validated = false;
	if(started == true)
	{
		var limit = 0;
		while(validated == false)
		{
			limit++;
			if(limit>100){validated = true;};
			first = Math.floor((Math.random() * 10) + 0);
			second = Math.floor((Math.random() * 10) + 0);
			
			console.log(first +" * "+ second);
			for(var i=0; i<numbers.length;i++)
			{
				if((numbers[i]==second))
				{
					validated = true;
					}else{console.log("not validated");};
			};
		};

		var oper;
		oper = Math.floor((Math.random() * 10) + 0);
		if((oper>5) && (document.getElementById("divide").checked))
		{
		console.log("divide");
			operation = "÷";
			answer = first*second;
			var tempfirst = first;
			first = answer;
			answer = tempfirst;
		}else{
			if(document.getElementById("multiply").checked)
			{
			console.log("else_if_multiply");
				operation = "*";
				oper = Math.floor((Math.random() * 2) + 0);
				console.log("oper: "+oper);
				if(oper>0)
				{
					var tempsecond = second;
					second = first;
					first = tempsecond;
				};
				answer = first*second;
			}else{
				console.log("else_else_divide");
				operation = "÷";
				answer = first*second;
				var tempfirst = first;
				first = answer;
				answer = tempfirst;
				
			};
		};
		document.getElementById("equation").innerHTML = first + " " + operation + " " + second + " = ";
		document.getElementById("answer").value = "";
	};
	
	
}

function updateProperties()
{
numbers = [];
if(document.getElementById("number1").checked){numbers=numbers+[1];};
if(document.getElementById("number2").checked){numbers=numbers+[2];};
if(document.getElementById("number3").checked){numbers=numbers+[3];};
if(document.getElementById("number4").checked){numbers=numbers+[4];};
if(document.getElementById("number5").checked){numbers=numbers+[5];};
if(document.getElementById("number6").checked){numbers=numbers+[6];};
if(document.getElementById("number7").checked){numbers=numbers+[7];};
if(document.getElementById("number8").checked){numbers=numbers+[8];};
if(document.getElementById("number9").checked){numbers=numbers+[9];};
}
function buttonPressed()
{
	if(document.getElementById("button").value=="Start")
	{
	console.log("start");
		document.getElementById("button").value="Stop";
		var selectedTime = document.getElementById("timeLimit").value;
		timeLimit = selectedTime*60;
		selectedTime = selectedTime*60*1000;
		document.getElementById("timeLeft").innerHTML = "Pozostało: " +timeLimit+"s";
		console.log(selectedTime);
		//var t = setTimeout(function() {endTime();}, selectedTime);
		intervalHolder = setInterval(interval,1000);
		started = true;
		correct = 0;
		document.getElementById("correct").innerHTML="Poprawnie: "+correct;
		generate();
	}else{
	console.log("stop");
		document.getElementById("button").value="Start";
		setTimeout(clearr,0);
	}
}
function getTimeLeft()
{
var minutes = timeLimit%60;
if(minutes>0){
	var seconds = timeLimit-(minutes*60);
	}
	else{
	var seconds = timeLimit-(minutes*60);
	};
return minutes+"min "+seconds+"sec";
}
function endTime()
{console.log("endTime");
clearInterval(intervalHolder);
answer="-111";
started = false
document.getElementById("equation").innerHTML = "";
document.getElementById("timeLeft").innerHTML = "koniec czasu";
		document.getElementById("answer").value = "";
		document.getElementById("button").value="Start";

}
function interval()
{
	timeLimit = timeLimit - 1;
	console.log(timeLimit);
	document.getElementById("timeLeft").innerHTML = "Pozostało: " +timeLimit+"s";
	if(timeLimit<0)
	{
		clearInterval(intervalHolder);
		document.getElementById("timeLeft").innerHTML = "koniec czasu";
		endTime();
	};

}
function clearr()
{
answer="-111";
clearInterval(intervalHolder);
console.log("clearr");
document.getElementById("timeLeft").innerHTML = "koniec czasu";
document.getElementById("equation").innerHTML = " ";
		document.getElementById("answer").value = "";
		document.getElementById("button").value="Start";
}
//generate();
</script>