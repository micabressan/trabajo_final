/*
By Ahmed Shawky @lnxg33k
Use-After-Free (UAF) Go vs C

// C implementation

#include<stdio.h>
int* badPtr(int x) {
  int* y = &x;
  return y;
}

void main() {
  int* x = badPtr(1);
  badPtr(2);
  printf("%d", *x);
}
*/

package main

// badPtr is a function that will return a pointer to int
func badPtr(x int) *int {
	y := &x // u of type *int, points to x
	return y
}

func main() {
	x := badPtr(1)
	badPtr(2)
	println(*x)
}