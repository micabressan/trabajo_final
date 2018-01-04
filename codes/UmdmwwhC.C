#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ncities;
typedef struct
{
    /* Mai jos am declarat variabilele reprezentative pt. o zona din Laponia in aceasta ordine:
    numele orasului destinatie, tipul jucariilor create, numarul jucariilor, directia de deplasare */
    char city_name[99];
    char toy[99];
    int ntoys;
    char dir;
} regiune;
regiune laponia[100][100];
typedef struct
{
    //structura memoreaza numele unei jucarii si cantitatea ei.
    char toy_name[99];
    int ntoy;
} toys;

typedef struct
{
    char city_name[99];
    int dif_toys;
    toys all_toys[99];
} cities;
cities city[100];

regiune citire_regiune()
{
    regiune laponia;

    scanf("%s %s", laponia.city_name, laponia.toy);
    scanf(" %d", &laponia.ntoys);
    scanf(" %c", &laponia.dir);
    return laponia;
}
void calc_next (int *next_x, int *next_y, char dir)
{
    if(dir == 'U') *next_x = *next_x - 1;
    if(dir == 'D') *next_x = *next_x + 1;
    if(dir == 'L') *next_y = *next_y - 1;
    if(dir == 'R') *next_y = *next_y + 1;
}

void add_gift (char city_name[99], char toy[99])
{
    int i,j;
    for(i = 0; i < ncities; i++)
        if(strcmp(city[i].city_name, city_name)==0)
        {
            int ok=1;
            for ( j = 0; j < city[i].dif_toys; j++)
                if( strcmp( city[i].all_toys[j].toy_name, toy)==0)
                {
                    city[i].all_toys[j].ntoy++;
                    ok=0;
                }
            if(ok)
            {

                strcpy(city[i].all_toys[city[i].dif_toys].toy_name, toy);
                city[i].all_toys[city[i].dif_toys].ntoy=1;
                city[i].dif_toys++;
            }
            break;
        }
}
void add_city(char city_name[99])
{
    int i, ok=1;
    for(i = 0; i < ncities; i++)
        if(strcmp(city_name, city[i].city_name)==0) ok=0;
    if(ok)
    {
        strcpy(city[ncities].city_name, city_name );
        city[ncities].dif_toys=0;
        ++ncities;
    }
}
void sort_city()
{
    int ok = 1, i;
    do
    {
        ok = 0;
        for(i = 0; i < ncities - 1; i++)
            if(strcmp(city[i].city_name, city[i+1].city_name) > 0)
            {
                ok = 1;
                cities aux;
                aux = city[i];
                city[i] = city[i+1];
                city[i+1]=aux;
            }
    }while(ok);
}
void sort_toy()
{
    int i, j;
    for(i = 0; i < ncities; i++)
    {
        int ok = 1;
        do
        {
            ok=0;
            for(j = 0; j < city[i].dif_toys - 1; j++)
            {
                if(city[i].all_toys[j].ntoy < city[i].all_toys[j+1].ntoy)
                {
                    toys aux;
                    aux = city[i].all_toys[j];
                    city[i].all_toys[j] = city[i].all_toys[j+1];
                    city[i].all_toys[j+1] = aux;
                    ok=1;
                }
                else if(city[i].all_toys[j].ntoy == city[i].all_toys[j+1].ntoy )
                    if (strcmp(city[i].all_toys[j].toy_name, city[i].all_toys[j+1].toy_name) > 0)
                    {
                        toys aux;
                        aux = city[i].all_toys[j];
                        city[i].all_toys[j] = city[i].all_toys[j+1];
                        city[i].all_toys[j+1] = aux;
                        ok=1;
                    }

            }
        }
        while(ok);
    }
}
int main()
{

    /*variabilele n si m reprezinta dimensiunile laponiei, x si y coordonatele
    punctului in care se afla Mos Craciun,steps nr. de pasi ramasi, toomuch devine
    1 daca Mos Craciun se blocheaza in zapada*/
    int n, m, x, y, steps, steps_init, toomuch = 0, i, j, gifts_gathered=0;

    //citire si memorarea oraselor diferite

    scanf("%d%d%d%d%d", &n, &m, &x, &y, &steps_init);
    steps = steps_init;
    for(i = 0; i < n; i++)
        for(j = 0; j < m; j++)
        {
            //citim informatiile despre o regiune
            laponia[i][j]=citire_regiune();
            add_city(laponia[i][j].city_name);
        }

    while(x >= 0 && y >= 0 && steps >= 0 && x < n && y < m)
    {
        if(laponia[x][y].ntoys>0)
        {
            add_gift(laponia[x][y].city_name, laponia[x][y].toy);
            --laponia[x][y].ntoys;
            ++gifts_gathered;
        }
        int next_x=x, next_y=y;
        calc_next(&next_x, &next_y, laponia[x][y].dir);
        --steps;
        x=next_x;
        y=next_y;
    }
    sort_city();
    sort_toy();
    if((x < 0 || y < 0 || x >= n || y >= m)&&steps >=0) toomuch = 1;
    if(toomuch)
        printf("TOO MUCH SNOW !\n");
    printf("%d\n", steps_init - steps-1);
    printf("%d\n", gifts_gathered);
    for(i = 0; i < ncities; i++)
    {
        if(city[i].dif_toys>0)
	{	printf("%s:\n",city[i].city_name);
        	for(j=0; j < city[i].dif_toys; j++)
           		printf("  %d %s\n", city[i].all_toys[j].ntoy,city[i].all_toys[j].toy_name);
	}
    }

    return 0;
}