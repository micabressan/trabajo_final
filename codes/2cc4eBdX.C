/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <time.h>
#include <stdlib.h>
#include <stdio.h>

int
main ()
{
  int guess;
  int attempts = 5;
  int num = rand () % 20 + 1;
  srand (time (NULL));
  printf
    ("I'm going to make up a number from 1 to 20. Guess it in 5 attempts.\n");
  while (attempts > 0)
    {
      attempts--;
      scanf ("%d", &guess);
      printf ("You entered %d\n", guess);
      if (guess > num)
	printf ("Nope, my number is less than that.\n");
      if (guess < num)
	printf ("Nope, my number is bigger than that.\n");
      if (guess == num)
	break;
    }

  if (guess == num)
    {
      printf ("Horaay! You got it right\n");
    }
  else
    {
      printf ("Nope, it was %d\n", num);
    }


  return 0;
}