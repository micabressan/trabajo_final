char **tworzenie_planszy(char **t, int x, int y)
{
    int i=0, j=0;
    t = (char **)malloc(x*sizeof(char *));
    for(i=0; i<x; i++)
    {
        t[i] = (char *)malloc(y*sizeof(char ));
    }

    for(i=0; i<x; i++)
    {
        for(j=0; j<y; j++)
            t[i][j] = 'x';
    }
    return t;
}

void wypisz_tablice(char *l, char **t, int x, int y)
{
    int i=0, j=0, k=1;
    printf("     ");
    for(i=0; i<y; i++)
    {
        printf("%c    ", l[i]);
    }
    printf("\n");
    for(i=0; i<x; i++)
    {
        if(k<10)
            printf("%d   ", k);
        else
            printf("%d  ", k);
        for(j=0; j<y; j++)
            printf("|%c|  ", *(*(t+i)+j));
        printf("\n");
        k++;
    }
}

void ustawianie_1(char **p_1, int z, int a, int b)
{
    char c, d=0;
    int i, j, l=0, m=0, f;
    for(i=0; i<z; i++)
    {
        printf("Twoj %d trojmasztowiec\n", i+1);
        for(j=0; j<3; j++)
        {
            printf("Podaj numer na jakim chcesz ustawic swoj statek:");
            if(j==0)
            sprawdzenie(p_1, a, b, &d, &m, 0, 0);
            else
            sprawdzenie(p_1, a, b, &d, &m, 1, 1);
        }
    }
}

void ustawianie_2(char **p_1, int y, int a, int b)
{
    char c, d;
    int i, j, l=0, m, f;
    for(i=0; i<y; i++)
    {
        printf("Twoj %d dwumasztowiec\n", i+1);
        for(j=0; j<2; j++)
        {
            printf("Podaj numer na jakim chcesz ustawic swoj statek:");
            if(j==0)
            sprawdzenie(p_1, a, b, &d, &m, 0, 1);
            else
            sprawdzenie(p_1, a, b, &d, &m, 1, 1);
        }

    }
}

void ustawianie_3(char **p_1, int x, int a, int b)
{
    char c, d=0;
    int i, j, l=0, m=0, f;
    for(i=0; i<x; i++)
    {
        printf("Twoj %d jednomasztowiec\n", i+1);
        for(j=0; j<1; j++)
        {
            printf("Podaj numer na jakim chcesz ustawic swoj statek:");
            if(j==0)
            sprawdzenie(p_1, a, b, &d, &m, 0, 1);
            else
            sprawdzenie(p_1, a, b, &d, &m, 1, 1);
        }

    }
}

void sprawdzenie(char **p_1, int b, int a, char *d, int *m, int f, int r)
{
    char c, q;
    int l, k=0, h=0;
    while(1)
        {
            scanf("%c%d", &c, &l);
            while(getchar()!='\n');
            if(c-'A'<0 || c-'A'>b || l<1 || l>a)
            {
                printf("Poza zakresem planszy\nPodaj inne pole:");
                continue;
            }

            if(p_1[l-1][c-'A']=='Y')
            {
                printf("Na tym polu juz masz statek\nPodaj inne pole:");
                continue;
            }
            if(f==1)
            {
                if((c!=*d && l!=*m-1) || (c!=*d+1 && l!=*m) || (c!=*d && l!=*m+1) || (c!=*d-1 && l!=*m))
                {
					printf("Zle ustawiony statek1\nPodaj inne pole:");
                    continue;
                }
            }
            if(r==1)
            {
                //sprawdzenie2(p_1, a, b, l-1, c-'A', &k, *m, *d);
            }
            if(k==1)
            {
               printf("Zle ustawiony statek\nPodaj inne pole:");
               continue;
               k=0;
            }
            if(r==1);
            p_1[l-1][c-'A']='Y';
            *d=c-'A';
            *m=l-1;
            q=c-'A';
            h=l-1;
            obstawienie(p_1, a, b, l-1, c-'A');
            break;

        }
}

void sprawdzenie2(char **p_1, int a, int b, int i, int j, int *k, int *m, char *d)
{
    while(1)
    {
        if(i-1>-1 && i-1<10 && j>-1 && j<10 && p_1[i-1][j]!=p_1[*m][*d] && p_1[i-1][j]=='Y')
            {
                *k=1;
                break;
            }
        if(i-1>-1 && i-1<10 && j-1>-1 && j-1<10 && p_1[i-1][j-1]!=p_1[*m][*d] && p_1[i-1][j-1]=='Y')
            {
                *k=1;
                break;
            }
        if(i-1>-1 && i-1<10 && j+1>-1 && j+1<10 && p_1[i-1][j+1]!=p_1[*m][*d] && p_1[i-1][j+1]=='Y')
            {
                *k=1;
                break;
            }
        if(i>-1 && i<10 && j-1>-1 && j-1<10 && p_1[i][j-1]!=p_1[*m][*d] && p_1[i][j-1]=='Y')
            {
                *k=1;
                break;
            }
        if(i>-1 && i<10 && j+1>-1 && j+1<10 && p_1[i][j+1]!=p_1[*m][*d] && p_1[i][j+1]=='Y')
            {
                *k=1;
                break;
            }
        if(i+1>-1 && i+1<10 && j>-1 && j<10 && p_1[i+1][j]!=p_1[*m][*d] && p_1[i+1][j]=='Y')
            {
                *k=1;
                break;
            }
        if(i+1>-1 && i+1<10 && j+1>-1 && j+1<10 && p_1[i+1][j+1]!=p_1[*m][*d] && p_1[i+1][j+1]=='Y')
            {
                *k=1;
                break;
            }
        if(i+1>-1 && i+1<10 && j+1>-1 && j-1<10 && p_1[i+1][j-1]!=p_1[*m][*d] && p_1[i+1][j-1]=='Y')
            {
                *k=1;
                break;
            }
        break;
    }
}

void obstawienie(char **p_1, int a, int b, int i, char j)
{
    if(i-1>-1 && i-1<10 && j>-1 && j<10 && p_1[i-1][j]!='Y')
        p_1[i-1][j]='D';
    if(i-1>-1 && i-1<10 && j-1>-1 && j-1<10 && p_1[i-1][j-1]!='Y')
        p_1[i-1][j-1]='D';
    if(i-1>-1 && i-1<10 && j+1>-1 && j+1<10 && p_1[i-1][j+1]!='Y')
        p_1[i-1][j+1]='D';
    if(i>-1 && i<10 && j-1>-1 && j-1<10 && p_1[i][j-1]!='Y')
        p_1[i][j-1]='D';
    if(i>-1 && i<10 && j+1>-1 && j+1<10 && p_1[i][j+1]!='Y')
        p_1[i][j+1]='D';
    if(i+1>-1 && i+1<10 && j>-1 && j<10 && p_1[i+1][j]!='Y')
        p_1[i+1][j]='D';
    if(i+1>-1 && i+1<10 && j+1>-1 && j+1<10 && p_1[i+1][j+1]!='Y')
        p_1[i+1][j+1]='D';
    if(i+1>-1 && i+1<10 && j+1>-1 && j-1<10 && p_1[i+1][j-1]!='Y')
        p_1[i+1][j-1]='D';
}

void D_T(char **p_1, int a, int b)
{
    int i, j;
    for(i=0; i<a; i++)
    {
        for(j=0; j<b; j++)
        {
            if(p_1[i][j]=='D')
                p_1[i][j]='T';
        }
    }
}

void komputer(char **k_1, int a, int b)
{
    int i, j;
    i=rand() % 9;
    j=rand() % 9;
    k_1[i][j]='Y';




}