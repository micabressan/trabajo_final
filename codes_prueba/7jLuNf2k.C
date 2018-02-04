#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc,string argv[])
{
    if(argc != 2)
    {
        printf("Error: type a key\n");
        return 1;
    }

    printf("plaintext: ");
    string s = get_string();

    int k = atoi(argv[1]);

    for(int i = 0, z = strlen(s); i < z; i++)
    {
        if(isalpha(s[i]))
        {
            if (islower(s[i]))
            {
                s[i] = ((s[i] - 'a') + k) % 26 + 'a';
               // printf("%c", s[i] );
            }
            else if(isupper(s[i]))
            {
                s[i] = ((s[i] - 'A') + k) % 26 + 'A';;
                //printf("%c", s[i] );
            }
            else
            {
                //printf("%c", s[i]);
            }


        }
    }

    printf("ciphertext: %s\n", s);
    //printf("%i\n", argc);


}