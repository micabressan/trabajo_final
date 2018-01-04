#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <memory.h>
#include <string.h>

//struktura obrazu
struct obraz {
	int szerokosc;
	int wysokosc;
	int glebia;
	int **dane;
	char nazwa[50];
};
//funkcje podstawowe
int czy_zapis_do_pliku() {
	int a=0;
	while (a != 1 && a!=2)
	{
		printf("Czy zapisać obraz do pliku?\n[1] tak\n[2] nie \n");
		scanf("%d", &a);
	} 
	return a;
}
void zapis_do_pliku(struct obraz *zapisywany) {
	char adres[50];
	int i, j;
	FILE *f = NULL;
	printf("Jak chcesz zapisać obraz? Podaj nazwe w formacie [nazwa].pgm\n");
	scanf("%s", adres);
	f = fopen(adres, "w");
	while (f == NULL) {
		printf("\nPodano zdecydowanie zla nazwe! Sprobuj jeszcze raz:\n");
		scanf("%s", adres);
		if ((f = fopen(adres, "w")) == NULL)
			printf("Nie da sie otworzyc pliku!\n");
	}
	if (fprintf(f, "P2\n%d %d \n%d \n", zapisywany->szerokosc, zapisywany->wysokosc, zapisywany->glebia) < 1) {
		printf("\nNie udalo sie zapisac pliku!\n");
		fclose(f);
		return;
	}
	for (i = 0; i < zapisywany->wysokosc; i++) {
		for (j = 0; j < zapisywany->szerokosc; j++)
			if (fprintf(f, "%d ", zapisywany->dane[i][j]) < 1) {
				printf("\nNie udalo sie zapisac pliku!\n");
				fclose(f);
				return;
			}
		fprintf(f, "\n");
	}
	printf("\n-Zapis zakonczony pomyslnie-\n");
	fclose(f);
}
void usun_obraz(struct obraz **tablica, int numer, int ilosc) {
	int i;
	numer = numer - 1;
	for (i = numer; i < ilosc; i++) {
		tablica[i] = tablica[i + 1];
	}
}
int wczytajliczbe(FILE *f) {
	char bufor[10];
	int wartosc;
	char znak;
	while (1) {
		if (fscanf(f, " %s", bufor) != 1) return -1;
		if (sscanf(bufor, "%d", &wartosc) == 1) return wartosc;
		if (bufor[0] == '#') {
			do {
				znak = fgetc(f);
			} while (znak != '\n' && znak >= 0);
		}
	}
}
void zwalnianie_pamieci(struct obraz *wskaznik) {
	int i;
	if (wskaznik == NULL) return;
	{
		if (wskaznik->dane != NULL) {
			for (i = 0; i < wskaznik->wysokosc; ++i) free(wskaznik->dane[i]);
			free(wskaznik->dane);
		}
		free(wskaznik);
		wskaznik = NULL;
	}

}
struct obraz *alokacja_pamieci(int wys, int szer, int gleb) {
	struct obraz *wskaznik;
	int i;
	wskaznik = (struct obraz *) malloc(sizeof(struct obraz));
	if (wskaznik == NULL) return NULL;
	wskaznik->wysokosc = wys;
	wskaznik->szerokosc = szer;
	wskaznik->glebia = gleb;
	wskaznik->dane = (int **)malloc(sizeof(int *) * wys);
	if (wskaznik->dane == NULL) {
		zwalnianie_pamieci(wskaznik);
		return NULL;
	}
	for (i = 0; i < wys; ++i) {
		wskaznik->dane[i] = (int *)calloc(szer, sizeof(int));
		if (wskaznik->dane[i] == NULL) {
			zwalnianie_pamieci(wskaznik);
			return NULL;
		}
	}

	return wskaznik;
}
struct obraz *zaladuj_obraz() {
	struct obraz *wczytywany;
	int i, j;
	char bufor[20];
	char nazwa[100];
	int wysokosc, szerokosc, glebia;
	FILE *f;
	wczytywany = malloc(sizeof(struct obraz));

	f = NULL;

	while (f == NULL) {
		printf("Podaj nazwe pliku w formacie [nazwa].pgm \n");
		//scanf("%s", wczytywany->nazwa);
		scanf("%s", nazwa);
		f = fopen(nazwa, "r");
		strcpy(wczytywany->nazwa, nazwa);
		while (bufor[0] != 'P' || bufor[1] != '2') {
			while (f == NULL) {
				printf("\nNie udalo sie wczytac pliku \"%s\"\nPodaj odpowiednio nazwe pliku\n", nazwa);
				scanf("%s", wczytywany->nazwa);
				//(wczytywany)->nazwa = nazwa;
				f = fopen(nazwa, "r");
			}
			fscanf(f, "%s", bufor);
			if (bufor[0] != 'P' || bufor[1] != '2') {
				printf("\n\nBledna nazwa pliku\n");
				fclose(f);
			}

			szerokosc = wczytajliczbe(f);
			wysokosc = wczytajliczbe(f);
			glebia = wczytajliczbe(f);
			//wczytywany = alokacja_pamieci(wysokosc, szerokosc, glebia);
			wczytywany->szerokosc = szerokosc;
			wczytywany->wysokosc = wysokosc;
			wczytywany->glebia = glebia;

			wczytywany->dane = (int **)malloc(sizeof(int *) * wysokosc);

			for (int i = 0; i < wysokosc; i++) {
				wczytywany->dane[i] = malloc(szerokosc * sizeof(int));
			}

			for (i = 0; i < (*wczytywany).wysokosc; i++) {
				for (j = 0; j < (*wczytywany).szerokosc; j++) {
					(*wczytywany).dane[i][j] = wczytajliczbe(f);
				}
			}
		}
		fclose(f);
	}
	return wczytywany;
}
int porownaj_int(const void *a, const void *b) {
	if (*(int *)a > *(int *)b)
		return 1;
	if (*(int *)a == *(int *)b)
		return 0;
	else
		return -1;
}
//operacje na obrazach
struct obraz *obracanie_90(struct obraz *wczytywany) {
	int i, j;
	struct obraz *nowy;
	int szer, wys;
	char *naz = calloc(50, sizeof(char));

	szer = wczytywany->wysokosc;
	wys = wczytywany->szerokosc;
	naz = wczytywany->nazwa;

	nowy = alokacja_pamieci(wys, szer, wczytywany->glebia);

	strcpy(nowy->nazwa, naz);

	for (i = 0; i < wys; ++i) {
		for (j = 0; j < szer; ++j) {
			nowy->dane[i][j] = wczytywany->dane[szer - j - 1][i];
		}
	}
	//zwalnianie_pamieci(wczytywany);
	return nowy;
}
struct obraz *odbity_w_pionie(struct obraz *wczytywany) {
	int i;
	int j;
	struct obraz *nowy;
	int szerokosc, wysokosc;
	szerokosc = wczytywany->szerokosc;
	wysokosc = wczytywany->wysokosc;

	nowy = alokacja_pamieci(wysokosc, szerokosc, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);
	if (nowy == NULL) {
		printf("Nie udalo sie odbic. :(\n");
		return 0;
	}
	for (i = 0; i < wysokosc; ++i) {
		for (j = 0; j < szerokosc; ++j) {
			nowy->dane[i][j] = wczytywany->dane[wysokosc - i - 1][j];
		}

	}
	return nowy;

}
struct obraz *odbity_w_poziomie(struct obraz *wczytywany) {
	int i;
	int j;
	struct obraz *nowy;
	int szerokosc, wysokosc;
	szerokosc = wczytywany->szerokosc;
	wysokosc = wczytywany->wysokosc;

	nowy = alokacja_pamieci(wysokosc, szerokosc, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);
	if (nowy == NULL) {
		printf("Nie udalo sie odbic. :(\n");
		return 0;
	}
	for (i = 0; i < wysokosc; ++i) {
		for (j = 0; j < szerokosc; ++j) {
			nowy->dane[i][j] = wczytywany->dane[i][szerokosc - j - 1];
		}
	}

	return nowy;
}
struct obraz *negatyw(struct obraz *wczytywany) {
	int i, j;
	struct obraz *nowy;
	int szer, wys;
	szer = wczytywany->szerokosc;
	wys = wczytywany->wysokosc;
	nowy = alokacja_pamieci(wys, szer, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);
	for (i = 0; i < wys; ++i) {
		for (j = 0; j < szer; ++j) {
			nowy->dane[i][j] = (wczytywany->glebia - wczytywany->dane[i][j]);
		}
	}
	return nowy;
}
struct obraz *progowanie(struct obraz *wczytywany, int prog) {
	int i, j;
	struct obraz *nowy;
	int szerokosc, wysokosc;
	if (wczytywany->glebia == 1) return wczytywany;
	szerokosc = wczytywany->szerokosc;
	wysokosc = wczytywany->wysokosc;

	nowy = alokacja_pamieci(wysokosc, szerokosc, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);
	if (nowy == NULL) {
		printf("Nie udalo sie sprogowac. :(\n");
		return 0;
	}
	for (i = 0; i < wysokosc; ++i) {
		for (j = 0; j < szerokosc; ++j) {
			if ((wczytywany->dane[i][j]) > prog)
				nowy->dane[i][j] = wczytywany->glebia;

			else
				nowy->dane[i][j] = 0;

		}
	}

	return nowy;

}
struct obraz *zaszumianie_pieprz_i_sol(struct obraz *wczytywany, int procent) {
	double i;
	double j;
	struct obraz *nowy;
	double szer, wys;
	szer = wczytywany->szerokosc;
	wys = wczytywany->wysokosc;
	nowy = alokacja_pamieci(wys, szer, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);
	int szum1;
	int szum2;
	srand(time(0));
	for (i = 0; i < wys; ++i) {
		for (j = 0; j < szer; ++j) {
			nowy->dane[(int)i][(int)j] = wczytywany->dane[(int)i][(int)j];
		}
	}

	for (i = 0; i < procent * szer * wys / 100; i++) {
		szum1 = rand() % ((int)wys - 1);
		szum2 = rand() % ((int)szer - 1);
		if (szum1 % 2 == 0) {
			nowy->dane[szum1][szum2] = 0;
		}
		else nowy->dane[szum1][szum2] = 255;
		i++;
	}

	return nowy;
}
struct obraz *filtr_medianowy(struct obraz *wczytywany) {
	int wysokosc = 0, szerokosc = 0;
	int i = 0, j = 0;// k = 0, l = 0, m = 0;
	struct obraz *nowy;
	int tab_tym[9]; // tablica do filtru medianowego 3x3
	wysokosc = (*wczytywany).wysokosc;
	szerokosc = (*wczytywany).szerokosc;
	nowy = alokacja_pamieci(wysokosc, szerokosc, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);


	for (i = 1; i < wysokosc - 1; ++i) {
		for (j = 1; j < szerokosc - 1; ++j) {
			tab_tym[0] = (*wczytywany).dane[i - 1][j - 1];
			tab_tym[1] = (*wczytywany).dane[i - 1][j];
			tab_tym[2] = (*wczytywany).dane[i - 1][j + 1];
			tab_tym[3] = (*wczytywany).dane[i][j - 1];
			tab_tym[4] = (*wczytywany).dane[i][j];
			tab_tym[5] = (*wczytywany).dane[i][j + 1];
			tab_tym[6] = (*wczytywany).dane[i + 1][j - 1];
			tab_tym[7] = (*wczytywany).dane[i + 1][j];
			tab_tym[8] = (*wczytywany).dane[i + 1][j + 1];

			qsort(tab_tym, 9, sizeof(*tab_tym), porownaj_int);
			(*wczytywany).dane[i][j] = tab_tym[4];
			(*nowy).dane[i][j] = tab_tym[4];
			printf("-%d - %d \n", (*wczytywany).dane[i][j], (*nowy).dane[i][j]);
		}
	}
	printf("FILTR MEDIANOWY JEST OK");
	return nowy;
}
struct obraz *filtr_Gaussa(struct obraz *wczytywany)
{
	int wysokosc = 0, szerokosc = 0;
	int i = 0, j = 0;
	int tab_tym[9];
	int srednia = 0;
	struct obraz *nowy;
	wysokosc = (*wczytywany).wysokosc;
	szerokosc = (*wczytywany).szerokosc;
	nowy = alokacja_pamieci(wysokosc, szerokosc, wczytywany->glebia);
	strcpy(nowy->nazwa, wczytywany->nazwa);

	for (i = 1; i < wysokosc - 1; ++i)
	{
		for (j = 1; j < szerokosc - 1; ++j)
		{
			tab_tym[0] = (*wczytywany).dane[i - 1][j - 1];
			tab_tym[1] = (*wczytywany).dane[i - 1][j];
			tab_tym[2] = (*wczytywany).dane[i - 1][j + 1];
			tab_tym[3] = (*wczytywany).dane[i][j - 1];
			tab_tym[4] = (*wczytywany).dane[i][j];
			tab_tym[5] = (*wczytywany).dane[i][j + 1];
			tab_tym[6] = (*wczytywany).dane[i + 1][j - 1];
			tab_tym[7] = (*wczytywany).dane[i + 1][j];
			tab_tym[8] = (*wczytywany).dane[i + 1][j + 1];
			srednia = (tab_tym[0] * 1 + tab_tym[1] * 2 + tab_tym[2] * 1 + tab_tym[3] * 2 + tab_tym[4] * 4 + tab_tym[5] * 2 + tab_tym[6] * 1 + tab_tym[7] * 2 + tab_tym[8] * 1) / (16);
			(*wczytywany).dane[i][j] = srednia;
			(*nowy).dane[i][j] = srednia;
		}
	}
	return nowy;
}
int histogram(struct obraz *wczytywany) {
	FILE *histogram;
	int i, j, k;
	int szer, wys, glebia;
	int *tablica;
	int licznik = 0;
	tablica = calloc((wczytywany->glebia + 1), sizeof(int));
	histogram = fopen("histogram.csv", "w");
	szer = wczytywany->szerokosc;
	wys = wczytywany->wysokosc;
	glebia = wczytywany->glebia;
	for (i = 0; i < wys; ++i) {
		for (j = 0; j < szer; ++j) {
			licznik = wczytywany->dane[i][j];
			tablica[licznik]++;
		}
	}
	for (k = 0; k < wczytywany->glebia + 1; k++) {
		printf("%d\n", tablica[k]);
		fprintf(histogram, "%d \n", tablica[k]);
	}
	printf("Zapisano do pliku histogram.csv \n");
	fclose(histogram);
}

int main() {

	struct obraz *wczytywany;
	struct obraz *ptr = NULL;
	struct obraz **tab;

	int i;						//potrzebne do wyswietlenia obrazow w tablicy
	int licznik_obrazow = 0;	//potrzebne do zliczania obrazow w tablicy
	int pomocnicza;				//potrzebna do niektorych operacji na obrazach
	int pierwszy_wybor=0;		//menu operacji na tablicy obrazów
	int drugi_wybor;			//menu operacji na danym obrazie
	int numer_obrazu;

	tab = calloc(100, sizeof(struct obraz *));
	wczytywany = (struct obraz *) malloc(sizeof(struct obraz)); 

	printf("Witam w programie Przetwarzanie obrazow!\nNajpierw dokonaj pierwszego zaladowania obrazu PGM - bez niego nie przejdziemy dalej.\n");
	printf("Oto liki dostepne w folderze projektowym. Wybierz jeden z nich.\n");
	system("dir *.pgm");
	printf("\n");

	tab[0] = zaladuj_obraz();	//ladowanie pierwszego obrazu
	licznik_obrazow = 1;

	do {
		printf("\nOto lista dostepnych obrazow:\n");
		for (i = 0; i < licznik_obrazow; i++) {
			printf("[%d] %s\n", i + 1, tab[i]->nazwa);
		}

		while (pierwszy_wybor != 1 && pierwszy_wybor != 2 && pierwszy_wybor != 3) {
			printf("\nMozliwe dzialania:\n[1] wczytaj kolejny obraz\n[2] usun obraz\n[3] operuj na obrazie\nPodaj numer polecenia\n");
			scanf("%d", &pierwszy_wybor);
		}

		switch (pierwszy_wybor) { //menu operacji na tablicy obrazow
			case 1:
				tab[licznik_obrazow] = zaladuj_obraz();
				licznik_obrazow++;
				break;

			case 2:
				do {
					printf("Podaj numer obrazu ktory chcesz usunac\n");
					scanf("%d", &numer_obrazu);
				} while (numer_obrazu < 1 || numer_obrazu > licznik_obrazow);
				usun_obraz(tab, numer_obrazu, licznik_obrazow);
				licznik_obrazow--;
				break;

			case 3:
				printf("Wybierz obraz z listy dostepnych\n");
				int wybor;
				scanf("%d", &wybor);
				ptr = (tab[wybor - 1]);

				do {
					printf("\nMozliwe działania:\n[1] obroc obraz o 90stopni*k\n[2] odbij obraz wzgledem osi\n[3] zastosuj negatyw\n[4] zastosuj progowanie\n[5] dodaj filtr pieprz i sol\n[6] zastosuj filtr medianowy\n[7] zastosuj filtr Gaussa\n[8] generuj histogram do pliku CSV\n[9] powrot do menu z tablica obrazow\n Podaj numer polecenia:\n");
					scanf("%d", &drugi_wybor);

					switch (drugi_wybor) {
						case 1:  //obroc obraz
							printf("O jaka wielokrotnosc 90 stopni chcesz obrocic obraz? Podaj k\n");
							scanf("%d", &pomocnicza);
							if (pomocnicza % 4 == 0) {

							}
							else {
								if (pomocnicza % 3 == 0) {
									ptr = obracanie_90(ptr);
									ptr = obracanie_90(ptr);
									ptr = obracanie_90(ptr);
								}
								else {
									if (pomocnicza % 2 == 0 && pomocnicza % 4 != 0) {
										ptr = obracanie_90(ptr);
										ptr = obracanie_90(ptr);
									}
									else ptr = obracanie_90(ptr);
								}
							}

							if (ptr == 0) printf("Cos poszlo nie tak");
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 2:  //odbij obraz
							printf("\nJak odbic obraz?\n[1] wzgledem osi pionowej\n[2] wzgledem osi poziomej\n");
							scanf("%d", &pomocnicza);

							while (pomocnicza != 1 && pomocnicza != 2) {
								printf("\nPodano bledne dane. Sprobuj jeszcze raz!\n");
								scanf("%d", &pomocnicza);
							}

							if (pomocnicza == 1) {
								ptr = odbity_w_pionie(ptr);
							}
							else ptr = odbity_w_poziomie(ptr);

							if (ptr == 0) printf("Cos poszlo nie tak");
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 3:  //negatyw
							ptr = negatyw(ptr);
							if (ptr == 0) printf("Cos poszlo nie tak");
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 4: //progowanie
							printf("\nGlebia zaladowanego obrazu wynosi %d\nJaki prog chcesz ustawic? Musi byc on w zakresie 0-%d\n", ptr->glebia, ptr->glebia);
							scanf("%d", &pomocnicza);

							while (pomocnicza <0 || pomocnicza > ptr->glebia) {
								printf("\nPodano bledne dane. Sprobuj jeszcze raz!\n");
								scanf("%d", &pomocnicza);
							}

							ptr = progowanie(ptr, pomocnicza);
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 5: //pieprz i sol
							printf("\nJaki procent obrazu chcesz zaszumic?\n");
							scanf("%d", &pomocnicza);

							while (pomocnicza <0 || pomocnicza > 100) {
								printf("\nPodano bledne dane. Sprobuj jeszcze raz!\n");
								scanf("%d", &pomocnicza);
							}

							ptr = zaszumianie_pieprz_i_sol(ptr, pomocnicza);
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 6: //filtr medianowy
							ptr = filtr_medianowy(ptr);
							if (ptr == 0) printf("Cos poszlo nie tak");
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 7: //filtr Gaussa
							ptr = filtr_Gaussa(ptr);
							if (ptr == 0) printf("Cos poszlo nie tak");
							if (czy_zapis_do_pliku() == 1) zapis_do_pliku(ptr);
							break;

						case 8: //generowanie histogramu do .csv
							histogram(ptr);
							printf("Dane zapisano do pliku histogram.csv \n");

						case 9: //powrot do menu operacji na tablicy obrazow
							break;

						default:
							printf("Nie ma takiej opcji. Wybierz jedna z dostepnych ponizej \n");
					}
				} while (drugi_wybor != 10);
			default:
				break;
		}
	} while (pierwszy_wybor != 4);
	return 0;
}