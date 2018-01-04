#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <memory.h>

int stepsTaken(int fromNumber) {
  int steps = 0;
  int fromY = 0;
  int fromX = 0;
  double sideOfArray = ceil(sqrt(fromNumber));
  bool sidesAreEven = (unsigned long)sideOfArray % 2 == 0;
  int targetSquareX = sidesAreEven ? (sideOfArray / 2) - 1 : floor(sideOfArray / 2);
  int targetSquareY = floor(sideOfArray / 2);

  int maxNumberInArr = sideOfArray * sideOfArray;
  int currentNumber = maxNumberInArr;
  bool targetFound = false;

  for (int x = 0; x < sideOfArray ; x++) { /*Check row for number*/
    if (currentNumber == fromNumber) {
      fromY = sideOfArray - 1;
      fromX = sideOfArray - 1 - x;
      targetFound = true;
      break;
    } 
    currentNumber -= 1;
  }

  if (!targetFound) {
      for (int y = 1; y < sideOfArray - 1; y++) { /* Else check column for number*/
        if (currentNumber == fromNumber) {
          fromY = sideOfArray - 1;
          fromX = sideOfArray - 1 - y;
          break;
        }
        currentNumber -= 1;
      }
  }

  steps = abs(targetSquareX - fromX) + abs(targetSquareY - fromY);
  printf("steps, %d\n", steps);
  
  return steps;
}


int main() {
  int steps = stepsTaken(347991);

  printf("steps taken: %d", steps);

  return 0;
}