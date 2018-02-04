#include <stdio.h>
#include <string.h>

#define ROZMIAR_WE		19
#define ROZMIAR_WY		42

unsigned int wypisz_wyrazy(char zdanie[]){
    puts(zdanie);
    unsigned int j;
    char biezacy;
    int separator;

    //
    // Wyswietl poszczegolne wyrazy
    //
    j = 0;
    separator = 0;

    for(int i=0 ; i < strlen(zdanie) ; i++){
        // Pobierz biezacy znak lancucha (na pozycji i)
        biezacy = zdanie[i];
        printf("%c", biezacy);
        // Sprawdz, czy to jest separator
        if (biezacy == ' ') {
            puts("\n");
            j++;
        }

    }
    return j;
}


int main() {
    char wejsciowy[ROZMIAR_WE] = "Ala ma kota i psa.";
    char wyjsciowy[ROZMIAR_WY];
    char *index;

    unsigned int liczba_wyrazow;

// Przekopiuj ciag wejsciowy do ciagu wyjsciowego
    strncpy(wyjsciowy, wejsciowy, ROZMIAR_WE);
// Znajdz pozycje ciagu " i psa", potrzebna do obciecia zdania wejsciowego
    index = strstr(wyjsciowy, " i psa.");

    // Obetnij zdanie wejsciowe - usun ciag " i psa."
        *index = '\0';

        // Dodaj zadany nowy ciag
        const char *dodac = ", psa, krokodyla i hipopotama.";
        strncat(wyjsciowy, dodac, 30);

    // Wyswietl ciagi wejsciowy i wyjsciowy
    printf("Ciag wejsciowy: %s\n", wejsciowy);
    printf("Ciag wyjsciowy: %s\n", wyjsciowy);
    printf("\nWyrazy:\n\n");

    // Wypisz i policz wszystkie wyrazy
    liczba_wyrazow = wypisz_wyrazy(wyjsciowy);

    // Wydrukuj podsumowanie
    printf("\nWszystkich wyrazow: %d\n", liczba_wyrazow);

    return 0;
}