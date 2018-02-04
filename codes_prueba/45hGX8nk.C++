#include <iostream>

using namespace std;

int main()
{
    int wys, szer;
    cout<<"Podaj szerokosc: ";
    cin>>szer;
    cout<<"Podaj wysokosc: ";
    cin>>wys;

    for(int i=0; i<szer; i++)
    {
        cout<<"x";
    }
    cout<<endl;
    for(int j=0; j<wys; j++)
    {
        cout<<"x";

        for(int x=0; x<szer-2; x++)
        {
            cout<<" ";
        }
        cout<<"x";
        cout<<endl;
    }
    for(int i=0; i<szer; i++)
    {
        cout<<"x";
    }


    return 0;
}