//Interface

//1. simple example
function printLabel(labelledObj: {label: string}) {
  console.log(labelledObj.label);
}

//the object got more properties, but the function will check just the label
var myObj = {size: 10, label: "Size 10 Object"};
printLabel(myObj);

//2. same example, now with interface declaration 

interface LabelledValue {
  label: string;
}
//using the declared interface
function printLabel2(labelledObj: LabelledValue) {
  console.log(labelledObj.label);
}
//no need to declare the object as the interface. Just to have the same attributes
var myObj2 = {size: 10, label: "Size 10 Object"};
printLabel2(myObj2);

//3. Optional properties - not all of the properties need to be implemented
interface SquareConfig {
  color?: string;
  width?: number;
}

function createSquare(config: SquareConfig): {color: string; area: number} {
  var newSquare = {color: "white", area: 100};
  if (config.color) {
    newSquare.color = config.color;
  }
  if (config.width) {
    newSquare.area = config.width * config.width;
  }
  return newSquare;
}

var mySquare = createSquare({color: "black"});

//4. interface for function types
//the signature. This function receives 2 strings and return boolean
interface SearchFunc {
  (source: string, subString: string): boolean;
}
var mySearch: SearchFunc;
//the name of the parameter doesn't have to match. We can name them a and b instead of source and substring
mySearch = function(source: string, subString: string) {
  var result = source.search(subString);
  if (result == -1) {
    return false;
  }
  else {
    return true;
  }
}
//5. Array interface
//we declare the type of index, and the type of items
interface StringArray {
  [index: number]: string;
}

var myArray: StringArray;
myArray = ["Bob", "Fred"];


//force properties to be as the index
interface Dictionary {
  [index: string]: string;
  length: number;    // error, the type of 'length' is not a subtype of the indexer
} 

//6. Implement an interface
interface ClockInterface {
    currentTime: Date;
}

class Clock implements ClockInterface  {
    currentTime: Date;
    constructor(h: number, m: number) { }
}

//implement with methods
interface ClockInterface {
    currentTime: Date;
    setTime(d: Date);
}

class Clock implements ClockInterface  {
    currentTime: Date;
    setTime(d: Date) {
        this.currentTime = d;
    }
    constructor(h: number, m: number) { }
}


//7. Extending interface

interface Shape {
    color: string;
}

interface Square extends Shape {
    sideLength: number;
}


var square = <Square>{};
square.color = "blue";
square.sideLength = 10;



//multiple extend
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}

var square = <Square>{};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;

//8. Hybrid type
//This type for example works as a function and as an object
interface Counter {
    (start: number): string;
    interval: number;
    reset(): void;
}

var c: Counter;
c(10);
c.reset();
c.interval = 5.0;


var button = document.createElement('button');
button.textContent = "alert";
button.onclick = function(){
	printLabel(myObj);
};
document.body.appendChild(button);