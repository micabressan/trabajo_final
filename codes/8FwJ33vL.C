#include <stdio.h>
#include <stdlib.h>
struct osoba
{
    char *nazwisko;
    char *imie;
} *ws_osoba;
int main()
{
    char n[50],i[50];
    ws_osoba=calloc(2,sizeof(struct osoba));
    printf("Podaj nazwisko: \n");
    ws_osoba->nazwisko = gets(n);
    printf("Podaj imie: \n");
    ws_osoba->imie = gets (i);
    printf("Adres struktury: %d\n",&ws_osoba);
    printf("Nazwisko i imie szczesciarza: %s\n%s",ws_osoba->nazwisko,
           ws_osoba->imie);
    free(ws_osoba);
    return 0;
}