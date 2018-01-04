#include <stdio.h>
#include <stdlib.h>

typedef struct ListaItem
{
    int dana;
    ListaItem *nastepny;
    ListaItem *poprzedni;
} tListaItem;

typedef struct Lista
{
    tListaItem *glowa;
    tListaItem *ogon;
    int ile_elementow;
} tLista;

void DodajDoListy(tLista *lista, int nowa_dana)
{
    if (!lista->glowa)
    {
        lista->glowa=(tListaItem *)malloc(sizeof(tListaItem));
        lista->glowa->nastepny=NULL;
        lista->glowa->poprzedni=NULL;
        lista->glowa->dana=nowa_dana;
        lista->ogon=lista->glowa;
        lista->ile_elementow=1;
    }
    else
    {
        lista->ogon->nastepny=(tListaItem *)malloc(sizeof(tListaItem));
        lista->ogon->nastepny->nastepny=NULL;
        lista->ogon->nastepny->poprzedni=lista->ogon;
        lista->ogon->nastepny->dana=nowa_dana;
        lista->ogon=lista->ogon->nastepny;
        lista->ile_elementow++;
    }
}

void DodajDoListyNaPoczatek(tLista *lista, int nowa_dana)
{
    if (!lista->glowa)
    {
        lista->glowa=(tListaItem *)malloc(sizeof(tListaItem));
        lista->glowa->nastepny=NULL;
        lista->glowa->poprzedni=NULL;
        lista->glowa->dana=nowa_dana;
        lista->ogon=lista->glowa;
        lista->ile_elementow=1;
    }
    else
    {
        lista->glowa->poprzedni=(tListaItem *)malloc(sizeof(tListaItem));
        lista->glowa->poprzedni->nastepny=lista->glowa;
        lista->glowa->poprzedni->poprzedni=NULL;
        lista->glowa->poprzedni->dana=nowa_dana;
        lista->glowa=lista->glowa->poprzedni;
        lista->ile_elementow++;
    }
}

void WypiszListe(tLista *lista)
{
    tListaItem *tmp=lista->glowa;
    int element=0;
    while (tmp)
    {
        printf("Element %d = %d\n",element++,tmp->dana);
        tmp=tmp->nastepny;
    }
    printf("Lista ma %d elementow\n",lista->ile_elementow);
}

void UsunElement(tLista *lista, tListaItem *element)
{
    tListaItem *tmp=lista->glowa;
    if (!element || !(lista->glowa)) return;
    if (tmp==element)
    {
        lista->glowa=tmp->nastepny;
        if (tmp->nastepny)
        tmp->nastepny->poprzedni=NULL;
        else
        lista->ogon=NULL;
        free(element);
        lista->ile_elementow--;
        return;
    }
    while ( tmp )
    {
        if (tmp==element)
        {
            if (!tmp->nastepny)
            {
                tmp->poprzedni->nastepny=NULL;
                lista->ogon=tmp->poprzedni;
            }
            else
            {
                tmp->poprzedni->nastepny=tmp->nastepny;
                tmp->nastepny->poprzedni=tmp->poprzedni;
            }
            free(element);
            lista->ile_elementow--;
            break;
        }
        tmp=tmp->nastepny;
    }
}
void UsunWszystkie(tLista *lista)
{
    tListaItem *tmp;
    while (lista->glowa)
    {
        tmp=lista->glowa;
        lista->glowa=lista->glowa->nastepny;
        free(tmp);
    }
    lista->ogon=lista->glowa;
    lista->ile_elementow=0;
}






#include <stdio.h>
#include <stdlib.h>
#define N 50

struct osoba
{
    char *nazwisko;
    char *imie;
};

void dane(struct osoba *str)
{
    printf("Nazwisko: %s\n", str->nazwisko);
    printf("Imie: %s\n", str->imie);
}

int main()
{
    struct osoba *ws_osoba = (struct osoba*)malloc(sizeof(*ws_osoba));
    ws_osoba->nazwisko = (char*)malloc(sizeof(*(ws_osoba->nazwisko)));
    ws_osoba->imie = (char*)malloc(sizeof(*(ws_osoba->imie)));

    printf("Prosze wprowadzic nazwisko: ");
    scanf("%s", ws_osoba->nazwisko);
    printf("Prosze wprowadzic imie: ");
    scanf("%s", ws_osoba->imie);
    printf("Adres struktury:%d\nAdres pola nazwisko: %d\nAdres pola imie: %d\n", ws_osoba, ws_osoba->nazwisko, ws_osoba->imie);

    printf("\nZawartosc struktury: \n");
    dane(ws_osoba);
    free(ws_osoba);

    return 0;
}