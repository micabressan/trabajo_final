function main(button){
  var display = document.getElementById("demo")
  var valOfDisplay = display.innerHTML
  var buttonValue = button.value
  
  if (buttonValue == ' = '){
    var equation = valOfDisplay;
    
    if(equation)
      display.innerHTML = eval(equation);
  } else {
    display.innerHTML += buttonValue;
  }
  }