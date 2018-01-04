#include <stdio.h>
#include <math.h>

#ifndef DEBUG
#define DEBUG(...)printf(__VA_ARGS__)
#endif

int main() {
  
  int a, b, i, j, temp, brojac;
  brojac = 0;
  
  scanf("%d %d", &a, &b);
  
  if (a > b)
  {
    temp = a;
    a = b;
    b = temp;
  }
  
  for (i = b; i > a; i--)
  {
    for (j = 1; j <= i; j++)
    {
      if (i % j == 0)
      {
      brojac++;
      }
    }
    if (brojac == 2)
    {
      printf("%d\n", i);
    }
    brojac = 0;
  }
  
  if ((a == 1)||(a == 0))
  {
    printf("1");
  }

  return 0;
}