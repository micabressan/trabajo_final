
import std.stdio;
import std.traits;

template pointerTargetRecursive(T : T*) {
  static if (!isPointer!T)
    alias T pointerTargetRecursive;
  else
    alias pointerTargetRecursive!T pointerTargetRecursive;
}

pointerTargetRecursive!T concreteValue (T) (T pointer) if (isPointer!T) {
  return  concreteValue(*pointer);
}

T concreteValue (T) (T value) if (!isPointer!T) {
  return value;
}

void main () {
  writeln("start");
  
  int i = 5;
  int* p = &i;
  int** pp = &p;
  int*** ppp = &pp;
  int**** pppp = &ppp;
  int***** ppppp = &pppp;
  
  writeln(concreteValue(i)); // 5
  writeln(concreteValue(p)); // 5
  writeln(concreteValue(pp)); // 5
  writeln(concreteValue(ppp)); // 5
  writeln(concreteValue(pppp)); // 5
  writeln(concreteValue(ppppp)); // 5
  
  writeln("end");
}