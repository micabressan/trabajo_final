#include <iostream>
#include <vector>
#include <ctime>
#include <stdio.h>
#include <conio.h>
#include <cstdlib>
#include <Eigen/Dense>
#include <iomanip>
#include <windows.h>
#include <cmath>
#include <map>
#include <set>
#include <fstream>
 
using namespace std;
 
 
int N = 5; // N jest rozmiarem planszy, gdzie plansza składa się z N*2+1 pól (nie jest to stała, będziemy ją prawdopodobnie zwiększać dla kolejnych ekperymentów)
int size = N*2+1 ;
int k = 8; // 3 + 5%6 ; k to liczba grzybów na planszy
int s1 = -N; // s1 jest polem startowym gracza nr1
int s2 = N; // s2 jest polem startowym gracza nr2
int l = 5; // 3 + 2 * (5%4) ; l oznacza liczbę ścian kostki ; ściany mają wartości (-2; -1; 0; 1; 2)
int ile_rownan = (2*N)*(2*N)*2;
double WYNIK;
//typy kostek:
// - równomierna, gdzie rozkład prawdopodobieństw jest równomierny i wynosi (1/5; 1/5; 1/5; 1/5; 1/5)   // - dowolna, gdzie rozkład prawdopodobieństw jest dowolny i wynosi np. (1/10; 2/10; 3/10; 3/10; 1/10)
 
 //MIERZENIE CZASU
 double PCFreq = 0.0;
__int64 CounterStart = 0;
void StartCounter()
{
    LARGE_INTEGER li;
    if(!QueryPerformanceFrequency(&li))
    cout << "QueryPerformanceFrequency failed!\n";
 
     PCFreq = double(li.QuadPart)/1000000.0;
 
    QueryPerformanceCounter(&li);
    CounterStart = li.QuadPart;
}
 
double GetCounter()
{
    LARGE_INTEGER li;
    QueryPerformanceCounter(&li);
    return double(li.QuadPart-CounterStart)/PCFreq;
} 
 
void print(vector< vector<double> > A, vector<double> B) {
    int n = A.size();
    for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++) {
            cout << A[i][j] << "\t";
        }
        cout << "| " << B[i] << "\n";      
    }
    cout << endl;
}

void printFile(vector< vector<double> > A, vector<double> B){
	ofstream myfile;
	myfile.open ("matrix.txt");

	int n = A.size();
    for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++) {
            myfile << A[i][j] << "\t";
        }
        myfile << "| " << B[i] << "\n";      
    }
	myfile << endl;
	
	myfile.close();
}
 
void printSparseMatrix(vector<double> mtx_val, vector<int> mtx_col, vector<int> mtx_nzl)
{
	cout<<"Wartości: ";
 	for(int i = 0; i<mtx_val.size(); i++)
 	{
 		cout<<mtx_val[i]<<" ";
    }
    cout<<endl<<"Kolumny: ";
 	for(int i = 0; i<mtx_col.size(); i++)
 	{
 		cout<<mtx_col[i]<<" ";
    }
    cout<<endl<<"Niezerowe w wierszu: ";
 	for(int i = 0; i<mtx_nzl.size(); i++)
 	{
 		cout<<mtx_nzl[i]<<" ";
    }
    cout<<endl;
} 
 
void fillMatrix(int n, vector< vector<double> > &a, vector<double> &b){
    int i, j;
    cout<<"\nEnter the right hand side constants : \n";
    for(i=0;i<n;i++) {
        cin>>b[i];
    }
                   
    cout<<"\nEnter the coefficients row wise : \n";
    for(i=0;i<n;i++) {
        for(j=0;j<n;j++) {
            cin>>a[i][j];
        }
    }
}
 
 //Tworzenie macierzy rzadkiej
void createSparseMatrix(int n, vector<vector<double> > a, vector<double> b, vector<double> &mtx_val, vector<int> &mtx_col, vector<int> &mtx_nzl)
{
	for(int i = 0; i<n; i++)
	{
		int howManyInRow = 0;
		for(int j = 0; j < n+1; j++)
		{
			if(a[i][j] != 0)
			{
				mtx_val.push_back(a[i][j]);
				mtx_col.push_back(j);	
				howManyInRow++;			
			}
		}
		if(b[i] != 0)
		{
			mtx_val.push_back(b[i]);
			mtx_col.push_back(n);	
			howManyInRow++;	
		}
		mtx_nzl.push_back(howManyInRow);		
	}
} 
 
// to-do: optimization for sparse matrix
void GaussPartial(int n, vector<double> x, vector< vector<double> > a, vector<double> b){
    cout << "\nGAUSS PARTIAL";
    for(int p = 0; p < n; p++){
        // find pivot row and swap
        int max = p; // indeks najwiekszego
        for(int i = p+1; i < n; i++){
            if(abs(a[i][p]) > abs(a[max][p]))
                max = i;
        }
 
        a[p].swap(a[max]);
        swap(b[p], b[max]);
   
 
        // pivot within A and B
        for(int i = p+1; i < n; i++){
            double alpha = a[i][p]/a[p][p];
            b[i] = b[i] - (alpha * b[p]);
 
            for(int j = p; j < n; j++){
                a[i][j] = a[i][j] - (alpha * a[p][j]);
            }
        }
    }
 
    for(int i = n - 1; i >= 0; i--){
        double sum = 0;
        for(int j = i+1; j < n; j++){
            sum += a[i][j] * x[j];
        }
        x[i] = (b[i] - sum)/a[i][i];
    }

	WYNIK = x[0];
		
    cout<<"\nThe Solution is : \n";
    for(int i=0;i<n;i++) {
        cout<<"\nx("<<i<<") = "<<x[i]<<"\n";
    }
	cout << "====================\n";  
	//getch();	
}
 
 void GaussPartialSparseMatrix(int n, vector<double> x, vector< vector<double> > a, vector<double> b){
    cout << "\nGAUSS PARTIAL FOR SPARSE MATRIX";
    for(int p = 0; p < n; p++){
        // find pivot row and swap
        int max = p; // indeks najwiekszego
        for(int i = p+1; i < n; i++){
            if(abs(a[i][p]) > abs(a[max][p]))
                max = i;
        }
 
        a[p].swap(a[max]);
        swap(b[p], b[max]);
   
 
        // pivot within A and B
        for(int i = p+1; i < n; i++){
        	//jesli wyzerowany, nie trzeba go zerowac
        	if(a[p][p] == 0)
        	{
        		cout << "zeroed";
        		break;
			}
        	
            double alpha = a[i][p]/a[p][p];
            b[i] = b[i] - (alpha * b[p]);
 
            for(int j = p; j < n; j++){
                a[i][j] = a[i][j] - (alpha * a[p][j]);
            }
        }
    }
 
    for(int i = n - 1; i >= 0; i--){
        double sum = 0;
        for(int j = i+1; j < n; j++){
            sum += a[i][j] * x[j];
        }
        x[i] = (b[i] - sum)/a[i][i];
    }
 
	WYNIK = x[0];
    cout<<"\nThe Solution is : \n";
    for(int i=0;i<n;i++) {
        cout<<"\nx("<<i<<") = "<<x[i]<<"\n";
    }
    cout << "====================\n";    
    //getch();
}
 
//based on http://www.dreamincode.net/forums/topic/94775-jacobi-iterative-method/
void jacobiMethod(int n, vector<double> x, vector< vector<double> > a, vector<double> b)
{
    cout << "\nJACOBI METHOD";
    vector<double> line(n+1, 0);
    vector< vector<double> > A(n, line);
    double big,temp,relerror,sum;
    float e;
    int i,j,maxit,itr;
    char ch;
    for(i=0;i<n;i++)
    {
        for(j=0;j<n+1;j++)
        {
            if(j != n)
                A[i][j] = a[i][j];
            else
                A[i][j] = b[i];
        }
    }
   // printf("\n\nEnter relative error and number of iteration ::  \n");
    //scanf("%f%d",&e,&maxit);
    e = 0.0001;
    maxit = 100;
    for(i=0;i<n;i++)
        x[i]=0;
    for(itr=1;itr<=maxit;itr++)
    {
        big=0;
        for(i=0;i<n;i++)
        {
            sum=0;
            for(j=0;j<n;j++)
             {
               if(i!=j)
                  sum=sum+A[i][j]*x[j];
            }
            temp=(A[i][n]-sum)/A[i][i];
            relerror=fabs((x[i]-temp)/temp);
            if(relerror>big)
               big=relerror;
            x[i]=temp;
        }
        if(big<=e && itr == maxit)
        {      
            printf("Converges to a solution in %d iterations\n",itr);
            cout<<"\nThe Solution is : \n";
            for(i=0;i<n;i++)
            {
                cout<<"\nx("<<i<<") = "<<x[i]<<"\n";
            }
            cout << "====================\n";    
            //getch();
        }
 
    }
  //printf("does not converge in %d iteration \n",maxit);
}
 
//based on http://www.sanfoundry.com/cpp-program-implement-gauss-seidel-method/
void gaussSeidelMethod(int n, vector<double> x, vector< vector<double> > a, vector<double> b){
    cout << "\nGAUSS-SEIDEL METHOD";
    int i,j,m;
    vector<double> y(n,0);
    //cout << "\nEnter the number of iterations : ";
    //cin >> m;
    m=100;
    while (m > 0)
    {
        for (i = 0; i < n; i++)
        {
            y[i] = (b[i] / a[i][i]);
            for (j = 0; j < n; j++)
            {
                if (j == i)
                    continue;
                y[i] = y[i] - ((a[i][j] / a[i][i]) * x[j]);
                x[i] = y[i];
            }
            // printf("x%d = %f    ", i + 1, y[i]);
        }
        // cout << "\n";
        m--;
    }
 
	WYNIK = x[0];
	
    cout<<"\nThe Solution is : \n";
    for(i=0;i<n;i++) {
        cout<<"\nx("<<i<<") = "<<x[i]<<"\n";
    }
    cout << "====================\n";  
    //getch();
}
 
double fRand(double fMin, double fMax)
{
    double f = (double)rand() / RAND_MAX;
    return fMin + f * (fMax - fMin);
}
 
int fRand(int max)
{
   
    int range = max*2;
    int number = rand()%range - max;
    return number;
}
 
void fillMushroomArrayWithRandomPositions(int *mushroomsPositions)
{
    cout<<"Ustalam pozycje grzybow \n";  
	srand( time( NULL ) );
   	int arrayPosition = 0;
   	bool allMushroomsPlaced = false;
   	bool noRedundanceFound = true;
   	int iteracje = 0;
   	do
   	{      
       	iteracje++;
       	int random = fRand(N);
       	noRedundanceFound = true;
       	for(int i = 0; i <= arrayPosition; i++)
       	{
           	if (random == mushroomsPositions[i])
           	{
               	noRedundanceFound = false; 
               	i = arrayPosition + 1;     
           	}                                  
      	 }
       	if(noRedundanceFound)
       	{
          mushroomsPositions[arrayPosition] = random;
           	arrayPosition++;
           	if(arrayPosition >= k)
               	allMushroomsPlaced = true;
        }              
   	} while(!allMushroomsPlaced);
    cout<<"Iteracje: \n"<<iteracje<< "\n";   
}
 
 void monteCarloTest(map<int, bool> mushrooms)
 {
 	int wins = 0;
	int tests = 100000; //liczba testow Monte Carlo
	
	for(int i = 0; i < tests; i++) 
	{
		map<int, bool> gameFields = mushrooms; //dla kazdego pojedynczego testu musimy uzyc tego samego zestawu grzybow
		int pos1 = s1;
		int mushrooms1 = 0; //liczba grzybow zebranych przez gracza 1
		int pos2 = s2;
		int mushrooms2 = 0;
		int player = 1;
		int finishedFirst = 0; //oznacza kto doszedl jako pierwszy na mete (1 - gracz 1, 2 - gracz 2)
		while(pos1 != 0 || pos2 != 0)
		{	
			//dla kosci -1 1
			/*		
			int dice = rand()%2; 			
			if(dice == 0)
			{
				dice = -1;
			} */
			
			//dla naszej kosci
			int dice = fRand(l/2);
			
			int corrector = 0; //korektor pól, aby nie wyjść poza planszee
			if(player == 1) //ruch gracza 1 
			{
				pos1 += dice;
				if(pos1 > s2)
				{
					corrector = pos1 - s2;
					pos1 = s1 + corrector-1;
				}
				if(pos1 < s1)
				{
					corrector = -pos1 + s1;
					pos1 = s2 - corrector + 1;
				}
				if (gameFields[pos1] == true)
				{
					mushrooms1++;
					gameFields[pos1] = false;
				}
				if(finishedFirst == 0 && pos1 == 0)
					finishedFirst = 1;
			}
			else //ruch gracza 2
			{
				pos2 -= dice;	
				if(pos2 > s2)
				{
					corrector = pos2 - s2;
					pos2 = s1 + corrector-1;
				}
				if(pos2 < s1)
				{
					corrector = -pos2 + s1;
					pos2 = s2 - corrector + 1;
				}
				if (gameFields[pos2] == true)
				{
					mushrooms2++;
					gameFields[pos2] = false;
				}
				if(finishedFirst == 0 && pos2 == 0)
					finishedFirst = 2;
			}
			player = (player % 2) + 1;		
		}
		
		if(mushrooms1 > mushrooms2)
		{			
			wins++;
			cout << "won by mushrooms: wins = " << wins << endl;
		}
		else if(mushrooms2 > mushrooms1)
			cout << "lost by mushrooms: wins = " << wins << endl;
		else
		{
			if(finishedFirst == 1)
			{
				wins++;
				cout << "won by finished first: wins = " << wins << endl;
			}
			else
			{
				cout << "lost by finished last: wins = " << wins << endl;
			}
		}
	}
	double score = (double)wins/(double)tests;
	cout << endl << "Prawdopodobienstwo Monte Carlo: "<< score << endl;
 }

 // functions & structures for generating probability matrix
 struct P{
    int player, x, y, wsp, g1, g2;
    P(){};
    P(int p, int x_, int y_, int wsp_){
        player = p;
        x = x_;
        y = y_;
        wsp = wsp_;

        // will see if it's important
        g1 = 0;
        g2 = 0;
    }

    P(int p, int x_, int y_, int wsp_, int g_1, int g_2){
        player = p;
        x = x_;
        y = y_;
        wsp = wsp_;

        // will see if it's important
        g1 = g_1;
        g2 = g_2;
    }

    void print(){
        char buffer[50];
        snprintf(buffer, 50, "P%d(%d, %d)(%d)[%d, %d]", player, x, y,wsp,g1,g2);
        printf("%-20s",buffer);
    }

    string compare(){
        char buffer[50];
        snprintf(buffer, 50, "%d%d%d", player, x, y);
        return buffer;
    }

    int status(){
        if(x == 0){
            if(g1 > g2){
                return 1; // 1 wygral
            } else if(g1 < g2){
                return 0; // 2 wygral
            } else {
                return 1; // takie same 1 wygral
            }
        } 
        else if(y == 0){
            if(g1 > g2){
                return 1; // 1 wygral
            } else if(g1 < g2){
                return 0; // 2 wygral
            } else {
                return 0; // takie same 2 wygral
            }
        }
        else{
            return -1; // gra toczy sie dalej
        }
    }
};


 void fillPlansza(vector<int> &p, int n){
    int number = -n;
    for(int i = 0; i < 2*n+1; i++){
        p[i] = number++;
    }
}

int mod(int a, int b) { return (a % b + b) % b; }

int indexOf(vector<int> p, int n){
    for(int i = 0; i < p.size(); i++){
        if(p[i]==n) return i;
    }
    return -1;
}

void generateProbability(map<int,bool> grzyby, vector< vector<double> > &matrix, vector<double> &b, vector<double> rozklad, bool wyswietlaj){
	  // l - ilosc scian kostki
    // n - maksymalne pole
    set<string> repetition;
    bool found; 
    int n = N; // mozna zmieniac
    int w = size; //wielkosc planszy
    vector<int> kostka(l, 0);

	kostka[0] = -2; kostka[1] = -1; kostka[2] = 0; kostka[3] = 1; kostka[4] = 2; // l = 5;
    vector<int> plansza(w, 0);
    fillPlansza(plansza, n);


    int ile_rownan = (2*n)*(2*n)*2;
    double prob = 1.0/l;

    map<string, int> repMap;
    map<string, int>::iterator it;
    pair<map<string,int>::iterator, bool> result;
    

    // Wektory do przechowywania prawdopodobienstw
    vector<P> line(l+1, P());
    vector< vector<P> > test(ile_rownan, line);
    // wartosci poczatkowe
    int x = -n, y = n, player = 1, wsp=0, dod = -1;


    // WYPELENIANIE PIERWSZEGO WIERSZA
    // grzyby dla pierwszych pol
    // if(grzyby[-n])
    //     firstG1++;
    // if(grzyby[n])
    //     firstG2++;

    test[0][0] = P(player, x, y, wsp); 
    result = repMap.insert(pair<string, int>(test[0][0].compare(), wsp++));
    repetition.insert(test[0][0].compare());
    x = indexOf(plansza, x);
    y = indexOf(plansza, y);
    player = player%2 + 1;    
    for(int i = 1; i < l+1; i++){
        int tempX = x, tempY = y;
        int tempG1 = 0, tempG2 = 0;   
        dod = kostka[i-1];     
        player == 2 ? tempX += dod : tempY+= dod;
        if(player == 1){
            if(grzyby[plansza[mod(tempY,w)]]){
                tempG2++;
            }
        }
        if(player == 2){
            if(grzyby[plansza[mod(tempX,w)]]){
                tempG1++;
            }
        }
        // prepareX_Y(n, x, y, &tempX, &tempY, dod);
        test[0][i] = P(player, plansza[mod(tempX, w)], plansza[mod(tempY, w)], wsp, tempG1, tempG2);
        if(plansza[tempX] == 0 || plansza[tempY] == 0){
            test[0][i].wsp = -1;
            wsp--;
        }
        result = repMap.insert(pair<string, int>(test[0][i].compare(), wsp++));   
    }
    // KONIEC WYPELNIANIA PIERWSZEGO WIERSZA

    int r = 0; // wiersz
    int c = 1; // kolumna
    int temp_wsp;
    int i;
    int g1, g2;

    for(i = 1; i < ile_rownan ; i++){
        // zczytanie skladnika z poprzedniego rownania
        // tu mamy problem dla wiekszych kostek
        x = test[r][c].x;
        y = test[r][c].y;
        player = test[r][c].player;
        temp_wsp = test[r][c].wsp;
        g1 = test[r][c].g1;
        g2 = test[r][c].g2;
        // cout << "i: " << i << " r->[ " << r << ", " << c << "]" << endl;  
        if(r == i) break;      
        // dzieki temu uzyskujemy wszyskie prawdopodobienstwa nie omijemy zadnego
        c = c%l + 1;
        if (c == 1) r++;


        test[i][0] = P(player, x, y, temp_wsp, g1, g2);
        found = repetition.count(test[i][0].compare());

        
        // found = findInFirstColumn(test, i); // sprawdzenie czy nie liczylismy juz tego prawdopodobienstwa
        if(found == 1 || (test[i][0].x == 0 || test[i][0].y == 0)){
            i--;
            continue;
        } else {
            repetition.insert(test[i][0].compare());
        }    
    
        x = indexOf(plansza, x);
        y = indexOf(plansza, y);
        player = player%2 + 1;   

        for(int j = 1; j < l+1; j++){
            int tempX = x, tempY = y;
            int tempG1 = g1, tempG2 = g2;
            dod = kostka[j-1];
            player == 2 ? tempX += dod : tempY+= dod;
            //przekroczyl mete
            if(player == 1){
                // if(abs(plansza[mod(tempY,w)]) != n && plansza[mod(tempY,w)] == -plansza[y])
                //     tempY = indexOf(plansza, 0);
                if(grzyby[plansza[mod(tempY,w)]]){
                    tempG2++;
                }
            } 
            
            if(player == 2){
                // if(abs(plansza[mod(tempX,w)]) != n && plansza[mod(tempX,w)] == -plansza[x])
                //     tempX = indexOf(plansza, 0);
                if(grzyby[plansza[mod(tempX,w)]]){
                    tempG1++;
                }
            }
                
            bool znaleziony = false;
            // wstawiony player
            test[i][j] = P(player, plansza[mod(tempX, w)], plansza[mod(tempY,w)], wsp, tempG1, tempG2);
            
            result = repMap.insert(pair<string, int>(test[i][j].compare(), wsp));
            if(result.second == 0){
                it = repMap.find(test[i][j].compare());
                test[i][j].wsp = it->second;
                znaleziony = true;
                wsp--;
            }

            if(plansza[mod(tempX,w)] == 0 || plansza[mod(tempY,w)] == 0){
                test[i][j].wsp = -1;
                if (!znaleziony) wsp--;
            }
            wsp++;
        }
    }
    ile_rownan = i;

	if(wyswietlaj){
		// Wygenerowane
		for(int i = 0; i < ile_rownan; i++){
			printf("%d: ", i+1);
			for(int j = 0; j < l+1; j++){
				
				if( j!= 0 && j!= 1 ) cout << " + ";
				test[i][j].print();
				if(j == 0) cout << " = ";
			}
			cout << endl;
		}
	}



    // Przenoszenie prawdopodobienstw do macierzy
    int stan; 
	
	for(int i = 0; i < ile_rownan; i++){
        for(int j = 0; j < l + 1; j++){
            stan = test[i][j].status();
            if(i == test[i][j].wsp){
                matrix[i][test[i][j].wsp] = 1;                
            } else if(stan == -1) {
                matrix[i][test[i][j].wsp] = -rozklad[j-1];  
                // cout << "STILL : " << j-1 << " : " << rozklad[j - 1] << endl;                              
            } else if(stan == 1){
                // cout << "WON : "<<  j-1 << " : " << rozklad[j - 1] << endl;                              
                
                b[i] += rozklad[j-1];
            } 
        }
    }
 }
 
int main()
{  
	vector<double> x(5, 0), b(5,0);
	double elapsed;
	/* OLD TESTS

 	//Testowa macierz zeby przyspieszyc sobie prace  i nie musiec wpisywac :p
 	vector< vector<double> > a = {{1,-0.5,-0.5,0,0,0,0,0,0,0,0,0,0,0,0,0},
		 {0,1,0,-0.5,-0.5,0,0,0,0,0,0,0,0,0,0,0},
		 {0,0,1,0,0,-0.5,-0.5,0,0,0,0,0,0,0,0,0},
		 {0,0,0,1,0,0,0,-0.5,-0.5,0,0,0,0,0,0,0},
		 {0,0,0,0,1,0,0,0,0,-0.5,-0.5,0,0,0,0,0},
		 {0,0,0,0,0,1,0,0,-0.5,0,0,0,0,0,0,0},
		 {0,0,0,0,0,0,1,0,0,0,-0.5,0,0,0,0,0},
		 {0,0,0,0,0,0,0,1,0,0,0,-0.5,0,0,0,0},
		 {-0.5,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
		 {0,0,0,0,0,0,0,0,0,1,0,-0.5,-0.5,0,0,0},
		 {-0.5,0,0,0,0,0,0,0,0,0,1,0,0,-0.5,0,0},
		 {0,-0.5,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
		 {0,0,0,0,0,0,0,0,0,0,0,0,1,0,-0.5,0},
		 {0,0,0,0,0,0,0,0,0,0,0,0,0,1,-0.5,-0.5},
		 {0,0,0,0,-0.5,0,0,0,0,0,0,0,0,0,1,0},
		 {0,0,0,0,0,0,-0.5,0,0,0,0,0,0,0,0,1}};
    b = {0, 0, 0, 0, 0, 0.5, 0.5, 0, 0, 0, 0, 0.5, 0.5, 0, 0, 0};
 	
    //fillMatrix(n, a, b);  
    cout << "==============\n";
    print(a,b);
    cout << "==============";
    getchar();
   
 	//macierz rzadka
 	cout << "\n==============\nMACIERZ RZADKA\n";
 	vector<double> mtx_val;     // kolejne NIEZEROWE wartości z wczytanej macierzy
	vector<int> mtx_col;     // pozycje (kolumny) kolejnych el. niezer. z powyzszego wektora
	vector<int> mtx_nzl;     // liczba elementów niezerowych w kolejnych wierszach
 	createSparseMatrix(N, a, b, mtx_val, mtx_col, mtx_nzl);
	 printSparseMatrix(mtx_val, mtx_col, mtx_nzl);
	 getchar();
    
    //TEST 1
    double elapsed;
    StartCounter();
    jacobiMethod(N, x, a, b);
    elapsed = GetCounter();
	cout << "Jacobi time test 1: " << elapsed << endl;
	getchar();
	
    
    StartCounter();
    gaussSeidelMethod(N, x, a, b);
    elapsed = GetCounter();
	cout << "Seidel time test 1: " << elapsed << endl;
	getchar();
	
    
    StartCounter();
    GaussPartial(N, x, a, b);
    elapsed = GetCounter();
	cout << "Gauss time test 1: " << elapsed << endl;
	getchar();
    
    StartCounter();
 	GaussPartialSparseMatrix(N, x, a, b);
 	elapsed = GetCounter();
	cout << "Gauss sparse time test 1: " << elapsed << endl;
	getchar();
	
   END OF OLD TESTS */

    //Grzybobranie-------------------------------------  
    //Ustalanie pozycji grzybów
    int mushrCount; 	
	if(k>=size) //jesli grzybow jest wiecej lub rowno niz pól na planszy to kazde pole ma po 1 grzybie
   		mushrCount = size;		   	
	else
		mushrCount = k;
		
	int mushroomsPositions[mushrCount]; //tablica pozycji rozmieszczenia grzybów (trzeba wylosować te pozycje z rozkładem równomiernym, czyli 1/(size)) ; 1 grzyb na 1 pozycję!!!
   
    if(mushrCount != k)
    {
    	int place = s1;
    	for(int i = 0; i < size; i++)
    	{
    		mushroomsPositions[i] = place;
    		place++;
		}
	}
    else
    {
    	//wypelnianie tablicy pozycji niemozliwymi pozycjami w celu dalszego jej wypelnienia juz prawdziwymi pozycjami losowymi
    	for(int i = 0; i < k; i++)
        	mushroomsPositions[i] = N+1;
       
    	//losowanie pozycji grzybow
    	fillMushroomArrayWithRandomPositions(mushroomsPositions);
	}
    cout<<"Wylosowane pozycje: \n";
    for(int i = 0; i < mushrCount; i++)
        cout<<mushroomsPositions[i]<<" ";
    
    map<int, bool> gameFields; //zamienimy tablice na mape pol, true jesli grzyb
    for(int i = s1; i<=s2; i++)
    {
    	gameFields[i] = false;
	}
	for(int i = 0; i < mushrCount; i++)
	{
		gameFields[mushroomsPositions[i]] = true;
	}


    getch();
    //Metoda monte-Carlo:
	monteCarloTest(gameFields);   // zmienilem na 100 000 zeby nie czekac za dlugo
	getch();
	// Generowanie prawdopodobientw
	// macierze

	// prawdopodobienstwa kostki
	vector<double> rozklad_rowny(l, (1.0/l));
	vector <double> rozklad = {15.0/100, 30.0/100, 10.0/100, 30.0/100, 15.0/100};
	
	vector<double> genB(ile_rownan, 0);
    vector<double> line2(ile_rownan, 0);
	vector< vector<double> > genA(ile_rownan, line2);
	vector<double> genX(ile_rownan, 0);
		//gamefields mapa z grzybami
	generateProbability(gameFields, genA, genB, rozklad, false);


	StartCounter();
	GaussPartialSparseMatrix(ile_rownan, genX, genA, genB);
	elapsed = GetCounter();
	cout <<"Prawdopodobienstwo na wygrana pierwszego gracza wynosi: " << WYNIK << endl;		
	cout << "Seidel time test 1: " << elapsed << endl;
	getchar();

	// StartCounter();
	// gaussSeidelMethod(ile_rownan, genX, genA, genB);
	// elapsed = GetCounter();
	// cout <<"Prawdopodobienstwo na wygrana pierwszego gracza wynosi: " << WYNIK << endl;		
	// cout << "Seidel time test 1: " << elapsed << endl;
	// getchar();
	

	// drukowanie macierzy do pliku
	printFile(genA,genB);
}