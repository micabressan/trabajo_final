module qstest;

import select;

template smaller(T) { auto smaller(T t) { return new delegate bool(T t2) { return eval t2 < t; }; } }
template equal(T) { auto equal(T t) { return new delegate bool(T t2) { return eval t2 == t; }; } }
template greater(T) { auto greater(T t) { return new delegate bool(T t2) { return eval t2 > t; }; } }
template or(T) { auto or(T t) { return new delegate auto(T t2) { auto t = t; return new delegate bool(ParamTypes T x) { return eval t x || t2 x; }; }; } }

template qs(T) {
  T qs(T t) {
    if !t.length return T:null;
    return qs select(t[1..$], (or smaller t[0]) equal t[0]).eval[] ~ t[0] ~ qs select(t[1..$], greater t[0]).eval[];
  }
}

import std.random;

void main() { 
  int[] list;
  using getPRNG 23 for 0..20 list ~= rand() % 100;
  list = qs list;
  writeln "$list";
}
module select;

template select(T) {
  alias steptype = type-of-elem value-of!T[0];
  
  class selectIterator {
    type-of value-of!T[0].iterator iter;
    T[1] test;
    steptype value;
    bool advance() {
      while value <- iter if test value return true;
      return false;
    }
  }
  selectIterator select(T t) {
    auto res = new selectIterator;
    res.iter = type-of res.iter: t[0].iterator;
    res.test = t[1];
    return res;
  }
}