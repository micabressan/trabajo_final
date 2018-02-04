#include <iostream>
#include <vector>

using namespace std;

void Generer4nb (vector <int> TabInt, unsigned sizee) {
    TabInt.resize(sizee);
    for (unsigned i = 0; i < sizee; ++i)
    {
        cout << "entrer la " << i << "eme valeur du tableau : ";
        //cin >> TabInts [i];
        int Val;
        cin >> Val;
        TabInt[i] = Val;
    }
}
void AfficheTabInt (vector <int> TabInt)
{
    for (unsigned i = 0; i < TabInt.size(); ++i)
    {
        cout << TabInt[i] << " ";
    }
}

int main()
{
    vector <int> Grid;

    Generate4nb(Grid, 4);

    AfficheTabInt (Grid);
    return 0;
}