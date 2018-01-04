#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_SZEROKOSC_LINIJKI 512

struct OBRAZ {
    int x,y,skala;
    int **pixel;
};


struct OBRAZ *Gradient(int,int, int); //funkcja ktora zwraca wskaznik na strukture OBRAZ
struct OBRAZ *Wczytaj(char*);
void Negatyw(struct OBRAZ*);
void Szum(struct OBRAZ*);
void SzumSolIPieprz(struct OBRAZ*);
void Rozjasnienie(struct OBRAZ*);
void Kontrast(struct OBRAZ*);

void Zapis(struct OBRAZ*);
void ZwalnianiePamieci(struct OBRAZ*);
int* Histogram(struct OBRAZ*);
void RysujWykres(int* dane, int l_linii, char *nazwa);
void ZoomUsredniajacy(struct OBRAZ*);
void ZoomMedianowy(struct OBRAZ*);
void Odbicie(struct OBRAZ*);
void menu();
void reverseColumns(int** tab, int r, int c);
void transpose(int** tab, int r, int c);
void Obroc(struct OBRAZ*);
void UsrednijKrawedzie(struct OBRAZ*, int);
void FiltrMedianowy(struct OBRAZ*);
int main () {
    menu();
    return 0;

}

struct OBRAZ *Gradient(int szer, int wys, int szar) {

    struct OBRAZ *wsk_na_str;
    int i, j;

    wsk_na_str = (struct OBRAZ*)malloc(sizeof(struct OBRAZ));

    wsk_na_str->x = szer; //odwolujemy sie do struktury przez wskaznik
    wsk_na_str->y = wys;
    wsk_na_str->skala = szar;

    wsk_na_str->pixel = (int**)calloc(wsk_na_str->x, sizeof(int*)); //alokazja pamieci na element struktury ktory jest tablica
    for(i=0; i<wsk_na_str->x;i++){
        wsk_na_str->pixel[i] = (int*)calloc(wsk_na_str->y, sizeof(int));
    }

    for(i=0; i<wsk_na_str->x;i++) {
        for(j=0;j<wsk_na_str->y;j++){
            wsk_na_str->pixel[i][j]=j;
        }
    }

    return wsk_na_str;
}

void Zapis(struct OBRAZ *do_zapisu) {
    int i, j;
    FILE *wsk;
    char nazwa[256];

    if(do_zapisu == NULL) {
        printf("Nie mozna zapisac pustej struktury.\n");
        return;
    }

    printf("Podaj nazwe pliku do zapisania: ");
    scanf("%s", nazwa);

    wsk = fopen(nazwa ,"w");
    fprintf(wsk,"%s\n","P2");
    fprintf(wsk, "%d %d\n", do_zapisu->x, do_zapisu->y); //wskaznik przyjmuje wartosc jaka zwrocila nam funkcja gradient do maina
    fprintf(wsk, "%d\n", do_zapisu->skala);

    for(j=0; j<do_zapisu->y;j++) {
        for(i=0; i<do_zapisu->x;i++) {
            fprintf(wsk, "%d ", do_zapisu->pixel[j][i]);
        }
        fprintf(wsk,"\n");
    }
    fclose(wsk);
}

struct OBRAZ *Wczytaj(char*nazwa){
    int i, j, tmp;
    struct OBRAZ *wsk_na_str;
    char bufor [MAX_SZEROKOSC_LINIJKI];
    FILE* wsk;

    wsk=fopen(nazwa, "r");

    if(wsk == NULL) {
        printf("Nie udalo sie otworzyc pliku.\n");
        return NULL;
    }

    // wczytanie pierwszej linijki
    fgets(bufor, MAX_SZEROKOSC_LINIJKI, wsk);


    if(!(bufor[0] == 'P' && (bufor[1] == '2' || bufor[1] == '5'))) {
        printf("Zly format pliku");
        return NULL;
    }


    do {
        fgets(bufor, MAX_SZEROKOSC_LINIJKI, wsk);
        if(strchr(bufor, '#')) {
            continue;
        }
        else {
            break;
        }
    }while(1);

    // cofniecie na poczatek poprzedniej linijki
    fseek(wsk, ftell(wsk) - strlen(bufor) - 1,SEEK_SET);

    // alokacja pamieci na strukture
    wsk_na_str =(struct OBRAZ*)malloc(sizeof(struct OBRAZ));

    // wczytanie szerokosci wysokosci i skali do struktury
    fscanf(wsk, "%d%d%d", &wsk_na_str->x, &wsk_na_str->y, &wsk_na_str->skala);
    printf("Informacje o pliku: x=%d y=%d skala=%d\n", wsk_na_str->x, wsk_na_str->y, wsk_na_str->skala);


    wsk_na_str->pixel=(int**)calloc(wsk_na_str->y, sizeof(int*));
    for(i=0; i<wsk_na_str->x;i++){
        wsk_na_str->pixel[i] = (int*)calloc(wsk_na_str->x, sizeof(int));
    }

    for(j=0; j<wsk_na_str->y; j++){
        for(i=0; i<wsk_na_str->x; i++){
            fscanf(wsk, "%d", &wsk_na_str->pixel[j][i]);
        }
    }

    fclose(wsk);
    return wsk_na_str;
}



void ZwalnianiePamieci (struct OBRAZ* obraz) {
    int i;
    for(i=0; i <obraz->y; i++)
    {
        free(obraz->pixel[i]);

    }
    free(obraz->pixel);
    free(obraz);
}


void Szum(struct OBRAZ* obraz) {
    int i, j, tmp, wspolczynnik;
    // rysowanie

    if(obraz == NULL) {
        printf("Nie mozna zaszumic obrazu, obraz == NULL.\n");
        return;
    }

    printf("Podaj wspolczynnik zaszumienia [0-%d]: ", obraz->skala);
    scanf("%d", &wspolczynnik);

    if(wspolczynnik == 0) {
        return;
    }

    if(wspolczynnik > obraz->skala) {
        printf("Zbyt duzy wspolczynnik, ustawiam na %d\n", obraz->skala);
        wspolczynnik = obraz->skala;
    }

    printf("Generuje szum dla obrazu x=%d y=%d skala=%d\n", obraz->x, obraz->y, obraz->skala);
    for(i=0; i<obraz->y;i++)
    {
        for(j=0; j<obraz->x; j++)
        {
            tmp = rand() % wspolczynnik;
            if(obraz->pixel[i][j] + tmp > obraz->skala) {
                obraz->pixel[i][j] = obraz->skala;
            }
            else {
                obraz->pixel[i][j] = obraz->pixel[i][j] + tmp;
            }
        }
    }
}

void Negatyw(struct OBRAZ* obraz_we){
    int i, j;

    if(obraz_we == NULL) {
        printf("Nie mozna zrobic negatywu, obraz == NULL.\n");
        return;
    }
    for(i = 0; i < obraz_we->y; i++) {
        for(j = 0; j < obraz_we->x; j++) {
            obraz_we->pixel[i][j] = obraz_we->skala - obraz_we->pixel[i][j];
        }
    }
}

void Kontrast(struct OBRAZ* obraz) {
    int i, j, wartosc;

    if(obraz == NULL) {
        printf("Nie mozna zmienic kontrastu, obraz == NULL.\n");
        return;
    }

    printf("Podaj wartosc kontrastu: ");
    scanf("%d", &wartosc);

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            // rozjasnienie
            if(obraz->pixel[i][j] > obraz->skala/2) {
                if(obraz->pixel[i][j] + wartosc > obraz->skala) {
                    obraz->pixel[i][j] = obraz->skala;
                }
                else {
                    obraz->pixel[i][j] += wartosc;
                }
            }
            else { // sciemnie
                if(obraz->pixel[i][j] - wartosc < 0) {
                    obraz->pixel[i][j] = 0;
                } else {
                    obraz->pixel[i][j] -= wartosc;
                }
            }
        }
    }

}

void Rozjasnienie(struct OBRAZ* obraz) {
    int i, j, wartosc;

    if(obraz == NULL) {
        printf("Nie mozna rozjasnic, obraz == NULL.\n");
        return;
    }


    printf("Podaj wartosc rozjasnienia: ");
    scanf("%d", &wartosc);

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            if(obraz->pixel[i][j] + wartosc > obraz->skala) {
                obraz->pixel[i][j] = obraz->skala;
            } else if(obraz->pixel[i][j] + wartosc < 0) {
                obraz->pixel[i][j] = 0;
            } else {
                obraz->pixel[i][j] += wartosc;
            }
        }
    }
}
int* Histogram(struct OBRAZ* obraz) {
    int* tab;
    int i, j;

    tab = (int*)calloc(obraz->skala, sizeof(int));

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            tab[obraz->pixel[i][j]]++;
        }
    }


    return tab;
}

void RysujWykres(int* dane, int l_linii, char *nazwa)
{
    FILE *Wsk_do_pliku;
    int i;

    Wsk_do_pliku = fopen(nazwa, "w");

    fprintf(Wsk_do_pliku, "<html>\n");
    fprintf(Wsk_do_pliku, "<head>\n");
    fprintf(Wsk_do_pliku, "<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>\n");
    fprintf(Wsk_do_pliku, "<script type=\"text/javascript\">\n");
    fprintf(Wsk_do_pliku, "google.load(\"visualization\", \"1\", {packages:[\"corechart\"]});\n");
    fprintf(Wsk_do_pliku, "google.setOnLoadCallback(drawChart);\n");
    fprintf(Wsk_do_pliku, "function drawChart() {\n");
    fprintf(Wsk_do_pliku, "var data = google.visualization.arrayToDataTable([\n");
    fprintf(Wsk_do_pliku, "['wartosc']");

    //
    for (i = 0; i<l_linii; i++)
    {
        fprintf(Wsk_do_pliku, ",\n[%d]", dane[i]);   //przekazanie danych na wykres
    }

    //
    fprintf(Wsk_do_pliku, "\n]);\n");

    fprintf(Wsk_do_pliku, "var options = {\n");
    fprintf(Wsk_do_pliku, "title: 'rozklad Gaussa'\n");
    fprintf(Wsk_do_pliku, "};\n");
    fprintf(Wsk_do_pliku, "var chart = new google.visualization.LineChart(document.getElementById('chart_div'));\n");
    fprintf(Wsk_do_pliku, "chart.draw(data, {\n");
    fprintf(Wsk_do_pliku, "colors: ['red']\n");
    fprintf(Wsk_do_pliku, "}\n");
    fprintf(Wsk_do_pliku, ");\n");
    fprintf(Wsk_do_pliku, "}\n");
    fprintf(Wsk_do_pliku, "</script>\n");
    fprintf(Wsk_do_pliku, "</head>\n");
    fprintf(Wsk_do_pliku, "<body>\n");
    fprintf(Wsk_do_pliku, "<div id=\"chart_div\" style=\"width: 1280px; height: 720px;\"></div>\n");
    fprintf(Wsk_do_pliku, "</body>\n");
    fprintf(Wsk_do_pliku, "</html>\n");

    fclose(Wsk_do_pliku);

}
void menu() {
    char nazwa[256];
    int wybor;

    struct OBRAZ* aktualnyObraz;

    do {
        printf("Podaj nazwe pliku do wczytania: ");
        scanf("%s", nazwa);

        aktualnyObraz = Wczytaj(nazwa);

        if (aktualnyObraz == NULL) {
            continue;
        }
        else {
            break;
        }

    } while(1);

    do {
        printf("1) Negatyw \n2) Szum \n3) Rozjasnianie \n4) Kontrast \n5) Zapisz \n6) Histogram \n7) Zoom Sredni \n8) Zoom medianowy \n9) Odbicie \n10) Obrot \n11) Szum sol i pieprz \n12) Filtr Medianowy \n13) Wyjscie\n");
        scanf("%d", &wybor);

        switch(wybor) {
            case 1:
                Negatyw(aktualnyObraz);
                break;
            case 2:
                Szum(aktualnyObraz);
                break;
            case 3:
                Rozjasnienie(aktualnyObraz);
                break;
            case 4:
                Kontrast(aktualnyObraz);
                break;
            case 5:
                Zapis(aktualnyObraz);
                break;
            case 6:
                RysujWykres(Histogram(aktualnyObraz), aktualnyObraz->skala, "histogram.html");
                break;
            case 7:
                ZoomUsredniajacy(aktualnyObraz);
                break;
            case 8:
                ZoomMedianowy(aktualnyObraz);
                break;
            case 9:
                Odbicie(aktualnyObraz);
                break;
            case 10:
                Obroc(aktualnyObraz);
                break;
            case 11:
                SzumSolIPieprz(aktualnyObraz);
                break;
            case 12:
                FiltrMedianowy(aktualnyObraz);
                break;
            case 13:
                break;
            default:
                printf("Brak takiej opcji.\n");
        }

    } while(wybor != 13);

}

float median(int n, int x[]) {
    int temp;
    int i, j;

    for(i=0; i<n-1; i++) {
        for(j=i+1; j<n; j++) {
            if(x[j] < x[i]) {
                // swap elements
                temp = x[i];
                x[i] = x[j];
                x[j] = temp;
            }
        }
    }

    if(n%2==0) {
        return((x[n/2] + x[n/2 - 1]) / 2.0);
    } else {
        // else return the element in the middle
        return x[n/2];
    }
}
float mean(int m, int a[]) {
    int sum=0, i;
    for(i=0; i<m; i++)
        sum+=a[i];
    return((float)sum/m);
}
void UsrednijKrawedzie(struct OBRAZ* obraz, int wsp) {
    int i;
    // usrednienie gornej krawedzi
    for(i = 1; i < obraz->x-1; i+=wsp) {
        obraz->pixel[0][i] = ((obraz->pixel[0][i-1] + obraz->pixel[0][i+1])/2);
    }
    // usrednienie dolnej krawedzi
    for(i = 1; i < obraz->x-1; i+=wsp) {
        obraz->pixel[obraz->y-1][i] = ((obraz->pixel[obraz->y-1][i-1] + obraz->pixel[obraz->y-1][i+1])/2);
    }
    // usrednienie lewej krawedzi
    for(i = 1; i < obraz->y-1; i+=wsp) {
        obraz->pixel[i][0] = ((obraz->pixel[i-1][0] + obraz->pixel[i+1][0])/2);
    }

    // usrednienie prawej krawedzi
    for(i = 1; i < obraz->y-1; i+=wsp) {
        obraz->pixel[i][obraz->x-1] = ((obraz->pixel[i-1][obraz->x-1] + obraz->pixel[i+1][obraz->x-1])/2);
    }
}
struct OBRAZ* Alokuj(int x, int y, int skala) {
    int i;
    struct OBRAZ* nowy;

    nowy = (struct OBRAZ*)calloc(1, sizeof(struct OBRAZ));

    nowy->skala = nowy->skala;
    nowy->x = x;
    nowy->y = y;



    nowy->pixel = (int**)calloc(nowy->y, sizeof(int*));

    for(i = 0; i < nowy->y; i++) {
        nowy->pixel[i] = (int*)calloc(nowy->x, sizeof(int));
    }

    return nowy;
}
void ZoomUsredniajacy(struct OBRAZ* obraz) {
    int przyblizenie, i, j;
    int probki[4];

    struct OBRAZ* nowy;


    przyblizenie = 2;
    nowy = Alokuj(obraz->x*przyblizenie, obraz->y*przyblizenie, obraz->skala);

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            nowy->pixel[i*przyblizenie][j*przyblizenie] = obraz->pixel[i][j];
        }
    }


    UsrednijKrawedzie(obraz, przyblizenie);
    // na krzyz
    for(i = 1; i < nowy->y-1; i+=przyblizenie) {
        for(j = 1; j < nowy->x-1; j+=przyblizenie) {
            probki[0] = nowy->pixel[i-1][j-1];
            probki[1] = nowy->pixel[i-1][j+1];
            probki[2] = nowy->pixel[i+1][j-1];
            probki[3] = nowy->pixel[i+1][j+1];
            nowy->pixel[i][j] = (int)mean(4, probki);
        }
    }

    // na plus
    for(i = 1; i < nowy->y-1; i+=przyblizenie) {
        for (j = 2; j < nowy->x - 1; j += przyblizenie) {
            probki[0] = nowy->pixel[i - 1][j];
            probki[1] = nowy->pixel[i + 1][j];
            probki[2] = nowy->pixel[i][j - 1];
            probki[3] = nowy->pixel[i][j + 1];
            nowy->pixel[i][j] = (int) mean(4, probki);
        }
    }
    // na plus
    for(i = 2; i < nowy->y-1; i+=przyblizenie) {
        for(j = 1; j < nowy->x-1; j+=przyblizenie) {
            probki[0] = nowy->pixel[i-1][j];
            probki[1] = nowy->pixel[i+1][j];
            probki[2] = nowy->pixel[i][j-1];
            probki[3] = nowy->pixel[i][j+1];
            nowy->pixel[i][j] = (int)mean(4, probki);
        }
    }
    ZwalnianiePamieci(obraz);
    *obraz = *nowy;
}

void ZoomMedianowy(struct OBRAZ* obraz) {
    int przyblizenie = 2, i, j;
    int probki[4];

    struct OBRAZ* nowy;

    nowy = Alokuj(obraz->x*przyblizenie, obraz->y*przyblizenie, obraz->skala);

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            nowy->pixel[i*przyblizenie][j*przyblizenie] = obraz->pixel[i][j];
        }
    }


    UsrednijKrawedzie(obraz, przyblizenie);
    // na krzyz
    for(i = 1; i < nowy->y-1; i+=przyblizenie) {
        for(j = 1; j < nowy->x-1; j+=przyblizenie) {
            probki[0] = nowy->pixel[i-1][j-1];
            probki[1] = nowy->pixel[i-1][j+1];
            probki[2] = nowy->pixel[i+1][j-1];
            probki[3] = nowy->pixel[i+1][j+1];
            nowy->pixel[i][j] = (int)median(4, probki);
        }
    }

    // na plus
    for(i = 1; i < nowy->y-1; i+=przyblizenie) {
        for(j = 2; j < nowy->x-1; j+=przyblizenie) {
            probki[0] = (int)0.5*nowy->pixel[i-1][j];
            probki[1] = (int)0.5*nowy->pixel[i+1][j];
            probki[2] = nowy->pixel[i][j-1];
            probki[3] = nowy->pixel[i][j+1];
            nowy->pixel[i][j] = (int)median(4, probki);
        }
    }
    // na plus
    for(i = 2; i < nowy->y-1; i+=przyblizenie) {
        for(j = 1; j < nowy->x-1; j+=przyblizenie) {
            probki[0] = (int)0.5*nowy->pixel[i-1][j];
            probki[1] = (int)0.5*nowy->pixel[i+1][j];
            probki[2] = nowy->pixel[i][j-1];
            probki[3] = nowy->pixel[i][j+1];
            nowy->pixel[i][j] = (int)mean(4, probki);
        }
    }
    ZwalnianiePamieci(obraz);
    *obraz = *nowy;
}
void Odbicie(struct OBRAZ* obraz) {
    int i, j, tmp;

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x/2; j++) {
            tmp = obraz->pixel[i][j];
            obraz->pixel[i][j] = obraz->pixel[i][obraz->x - j - 1];
            obraz->pixel[i][obraz->x - j - 1] = tmp;
        }
    }
}


void transposeObraz(struct OBRAZ* obraz) {

    int i, j;
    struct OBRAZ* nowy;

    nowy = (struct OBRAZ*) calloc(1, sizeof(struct OBRAZ));
    nowy->x = obraz->y;
    nowy->y = obraz->x;


    printf("new x %d y %d\n", nowy->x, nowy->y);
    nowy->pixel = (int**)calloc(nowy->y, sizeof(int*));

    for(i = 0; i < nowy->y; i++) {
        nowy->pixel[i] = (int*)calloc(nowy->x, sizeof(int));
    }

    for(i = 0; i < nowy->y; i++) {
        for(j = 0; j < nowy->x; j++) {
            nowy->pixel[i][j] = obraz->pixel[j][i];
        }
    }
    *obraz = *nowy;
}

void Obroc(struct OBRAZ* obraz) {

    int i, k;

    printf("Podaj ilosc obrotow: ");
    scanf("%d", &k);

    for(i = 0; i < k; i++) {
        transposeObraz(obraz);
        Odbicie(obraz);
    }
}
void SzumSolIPieprz(struct OBRAZ* obraz) {
    int i, j, wspolczynnik;

    srand(time(0));

    printf("Podaj wspolczynnik zaszumienia [1-100]: ");

    wspolczynnik = 100 - wspolczynnik;

    scanf("%d", &wspolczynnik);

    for(i = 0; i < obraz->y; i++) {
        for(j = 0; j < obraz->x; j++) {
            if(rand() % wspolczynnik == 0) {
                if(rand() % 2 == 0) {
                    obraz->pixel[i][j] = obraz->skala;
                } else {
                    obraz->pixel[i][j] = 0;
                }
            }
        }
    }
}

void FiltrMedianowy(struct OBRAZ* obraz) {
    int probki[9];
    int i, j;

    
    for(i = 1; i < obraz->y-1; i++) {
        for(j = 1; j < obraz->x-1; j++) {
            probki[0] = obraz->pixel[i+1][j-1];
            probki[1] = obraz->pixel[i+1][j];
            probki[2] = obraz->pixel[i+1][j+1];
            probki[3] = obraz->pixel[i][j-1];
            probki[4] = obraz->pixel[i][j];
            probki[5] = obraz->pixel[i][j+1];
            probki[6] = obraz->pixel[i-1][j-1];
            probki[7] = obraz->pixel[i-1][j];
            probki[8] = obraz->pixel[i-1][j+1];

            obraz->pixel[i][j] = (int)median(9, probki);
        }
    }
}