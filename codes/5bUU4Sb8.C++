#include <iostream>
#include <cstdlib>
#include <ctime>

bool czyBylaWylosowana( int iLiczba, int tab[], int ile )
{
    if( ile <= 0 )
         return false;
    
    int i = 0;
    do
    {
        if( tab[ i ] == iLiczba )
             return true;
        
        i++;
    } while( i < ile );
    
    return false;
}

int wylosuj()
{
    return( rand() % 10 ) + 1;
}

int main()
{
    srand( time( 0 ) );
    int wylosowane[ 5 ];
    int wylosowanych = 0;
    do
    {
        int liczba = wylosuj();
        if( czyBylaWylosowana( liczba, wylosowane, wylosowanych ) == false )
        {
            wylosowane[ wylosowanych ] = liczba;
            wylosowanych++;
        } //if
    } while( wylosowanych < 5 );
    
    wylosowanych = 0;
    do
    {
        std::cout << wylosowane[ wylosowanych ] << std::endl;
        wylosowanych++;
    } while( wylosowanych < 5 );
    
    return 0;
}