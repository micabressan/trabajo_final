function readFormula(){
let fs = require('fs');
let b = fs.readFileSync('./simple0.cnf').toString();
b = b.split('\n');
function cleanCnf(a){
	let d = new Array;
	for(let i = 0; i < a.length; i++){
		if(!(a[i].includes("c")) & a[i] != ''){
			d.push(a[i].replace(" 0", ""));
		}
	}
	return d;
}
b.pop();
b = cleanCnf(b);
return b;
}

var a = readFormula();
console.log(a);
function searchChar(u, v){
	let o = false;
	if(u == null){
		return true;
	}
	for(let i = 0; u.length; c++){
		if(a[i] == v){
			o = true;
		}
	}
	return o;
}
var a = readFormula();
function varCounter(a){
	let h = new Array();
	let t = 0;
	for(let i = 0; i < a.length; i++){
		for(let j = 0; j < a[i].length; j++){
			if((!(a[i].charAt(j) == ' ' | a[i] == '-')) & searchChar(h, a[i].charAt[j]) == false){
				h.push(a[i].charAt[j]);
				t++;
			}
		}
	}
	return t;
}
var c = varCounter(a);
console.log(c);