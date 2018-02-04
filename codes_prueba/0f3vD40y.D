/*
 * custom (extendable) functions
 * it is also possible to make custom variable types using operator overloading
 *
 */

import std.stdio;


// this is generic
mixin template extensions () {
  auto opDispatch (string fn, args...) (args arguments) {
      mixin("return " ~ fn ~ "(this, arguments);");
  }
}


// out custom variable
struct myInt {
  
  mixin extensions;
  
  int value = 0;

  myInt customAdd (int value) {
    myInt newInt;
    newInt.value = this.value + value;
    return newInt;
  }
  
}

myInt otherAdd (myInt i, int value) {
  myInt newInt;
  newInt.value = i.value + value;
  return newInt;
}


void main () {
  writeln("start");
  
  myInt i1;
  i1.value = 3;
  writeln(i1.value); // 3
  
  myInt i2 = i1.customAdd(2);
  writeln(i2.value); // 5
  
  myInt i3 = i2.otherAdd(1);
  writeln(i3.value); // 6
  
  writeln("end");
}