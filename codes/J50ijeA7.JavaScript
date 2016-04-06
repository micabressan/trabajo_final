var isDone:boolean = false; //boolean

var height: number = 6; //float

var name : string = "bob"; // string
name = 'alice';
//name = 3; //error in compile

//Array 
var list:number[] = [1,2,3];
//Array generic 
var list2:Array<number> = [1,2,3];


//enum
enum Color {Red, Green, Blue};
var c: Color = Color.Green;

//enum with our own numbers
enum Color2 {Red = 1, Green = 2, Blue = 4};
var c2: Color2 = Color2.Green;

//Dynamic value. Can come from 3rd party/old API / just regular JS
var notSure: any = 4;
notSure = "maybe a string instead";
notSure = false; // okay, definitely a boolean
notSure = {};
notSure.g = 2;
notSure.g = 'ab';

//The 'any' type is a powerful way to work with existing JavaScript, allowing you to gradually opt-in and opt-out of type-checking during compilation.
//Any in a list
var list3:any[] = [1, true, "free"];
list3[1] = 100;


//void

function warnUser(): void {
    alert("This is my warning message");
}
 

var button = document.createElement('button');
button.textContent = list[1].toString();
button.onclick = warnUser;
document.body.appendChild(button);