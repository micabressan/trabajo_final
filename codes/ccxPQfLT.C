#include <stdio.h>
#include <stdlib.h>
int main()
{
    FILE* ulaz;
    char znak, ime[50];
    int broj_redova = 0, broj_znakova = 0, broj_rijeci = 0, razmak = 1;
    int br_cifara = 0; br_samoglasnika = 0; br_velSlova = 0;
    printf("Unesite ime datoteke: ");
    scanf("%s", ime);
    ulaz = fopen(ime, "r");
    if(ulaz == NULL)
    {
        printf("Greska prilikom otvaranja datoteke '%s'! \n", ime);
        exit(1);
    }
    while((znak = fgetc(ulaz)) != EOF)
    {
        /* Ako je znak novi red, povecaj broj linija za jedan */
        if(znak == '\n')
            broj_redova++;
        /* Da li je znak razmak? */
        if(znak == ' ' || znak == '\n' || znak == '\t')
        {
            razmak = 1;
        }
        else
        {
            /* Ako je prethodni znak bio razmak, a ovaj nije,
            povecaj broj rijeci za jedan */
            broj_znakova++;
            if(razmak == 1)
                broj_rijeci++;
            razmak = 0;
        }
        if(znak >= '0' && znak <= '9')
            br_cifara++;
        if(znak >= 'A' && znak <= 'Z')
            br_velSlova++;
        if(znak == 'A' || znak == 'E' || znak == 'I' || znak == 'O' || znak =='U' 
           || znak == 'a' || znak == 'e' || znak == 'i' || znak == 'o' || znak == 'u')
            br_samoglasnika++;
    }
    if(broj_znakova != 0)
        broj_redova++;
    printf("Broj redova: %d \n", broj_redova);
    printf("Broj rijeci: %d \n", broj_rijeci);
    printf("Broj znakova: %d \n", broj_znakova);
    printf("Broj samoglasnika: %d \n", br_samoglasnika);
    printf("Broj velikih slova: %d \n", br_velSlova);
    printf("Broj cifara: %d \n", br_cifara);
        fclose(ulaz);
    return 0;
}