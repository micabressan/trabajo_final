#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 * ---
 * Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
 **/
int main()
{
    int lightX; // the X position of the light of power
    int lightY; // the Y position of the light of power
    int initialTX; // Thor's starting X position
    int initialTY; // Thor's starting Y position
    scanf("%d%d%d%d", &lightX, &lightY, &initialTX, &initialTY);

    // game loop
    while (1) {
        int remainingTurns;
        scanf("%d", &remainingTurns);
        if((initialTX<lightX) && (initialTY<lightY))
                {
            
                printf("SE\n"); // A single line providing the move to be made: N NE E SE S SW W or NW
                 }
        else if ((initialTX=lightX) && (initialTY<lightY))
            {
            
              printf("S\n"); 
            }
        else if ((initialTX>lightX) && (initialTY=lightY)){
            printf("W\n");
        }
        else if ((initialTX=lightX) && (initialTY>lightY))
            {
            
              printf("N\n"); 
            }
        else if ((initialTX<lightX) && (initialTY>lightY))
            {
            
              printf("NE\n"); 
            }
        
       else if ((initialTX<lightX) && (initialTY=lightY))
            {
            
              printf("E\n"); 
            }
       else if ((initialTX>lightX) && (initialTY<lightY))
            {
            
              printf("SW\n"); 
            }
        else ((initialTX>lightX) && (initialTY>lightY))
            {
             printf("NW\n"); 
            }
    }
        
        

    return 0;
}