struct TDA_Radical {
    int indice;
    int radicando;
};

typedef struct TDA_Radical Radical;

#include <iostream>
#include "Raiz.h"

using namespace std;

Radical crear() {
	Radical raiz;
	cout << "Ingrese el valor de indice: ";
    cin >> raiz.indice;
    cout << "Ingrese el valor de radicando: ";
    cin >> raiz.radicando;
    return raiz;
}

int main()
{
  crear();
  return 0;
}