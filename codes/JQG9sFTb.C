#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>


//get name
int main(void)
{
    printf("Your name: ");
    string name = get_string();
    printf("\n");

    if (name != NULL)  // check for correctness
    {
       if (islower (name[0]) != ' ')
       {
           printf("%c", toupper(name[0]));
       }
       else
       {
           printf("%c", name[0]);
       }

       for(int i = 0, n = strlen(name); i < n; i++)
       {
           if (name[i] == ' ' && name[i+1] != ' ')
           {
                if (islower (name[i+1]))
                {
                    printf("%c", toupper(name[i+1]));
                }
                else
                {
                    printf("%c", name[i+1]);
                }
            }
        }
    }
    printf("\n");
}