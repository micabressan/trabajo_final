#include <iostream>
#include <cstring>
#include <vector>
#include <cstdlib>
#include <cassert>
#include "templates.h"


#define cout(x) cout << (x) << endl
#define PRINT(x) cout << (#x) << " = " << (x) << endl

using namespace std;

class Flugzeug
{
private:
    //const unsigned int nr;
    char *typ;
    unsigned int sitze;
    static int serienNr;

public:
    Flugzeug(const char *typ, unsigned int sitze);      //Allg. Konstruktor
    Flugzeug(Flugzeug const &other);                    //Kopierkonstruktor
    ~Flugzeug();                                        //Destruktor

    Flugzeug &operator=(Flugzeug const &other);         //überladene Zuweisung
                                                        //nr bleibt allerdings

    unsigned int getNr() const;             //lesender Zugriff auf nr
    void setTyp(char const *t);             //schreibender Zugriff auf Typ
    char *getTyp() const;                   //lesender Zugriff auf Typ
    void setSitze(unsigned int sitze);      //schreibender Zugriff auf sitze
    unsigned int getSitze() const;          //lesender Zugriff auf sitze

    bool operator==(Flugzeug const &other); //gleiche Anzahl an Sitzen
    bool operator<(Flugzeug const &other);  //bedeutet weniger Sitze

    static int getSerienNr();
};

//Überladener Ausgabeoperator, schreibt alle privaten Attribute auf out
ostream& operator<<(ostream &out, Flugzeug const &f);

//Duplizierung von char-Strings
char* strdupnew(const char* s);


/*
Nummer 1
*/
int Flugzeug::serienNr = 4700;

int main()
{
    Flugzeug k("Ofen", 50);
    PRINT(k.getTyp());
    PRINT(k.getSitze());

    cout << endl;
    Flugzeug a("Herd", 100);
    PRINT(a.getTyp());
    PRINT(a.getSitze());

    cout << endl;
    Flugzeug z(k);
    PRINT(z.getTyp());
    PRINT(z.getSitze());

    cout << endl;
    Flugzeug copy("Gans", 2);
    copy = copy;
    PRINT(copy.getTyp());
    PRINT(copy.getSitze());

    cout << endl;
    cout << endl;

    PRINT(k == a);
    PRINT(k < a);

    cout << endl;
    cout << endl;

    cout << a << endl;

    return 0;
}


//IMPLEMENTIERUNG
char* strdupnew(const char* s)
{
    char* neu = new char[strlen(s) + 1];
    strcpy(neu, s);
    return neu;
}

/*
Allgemeiner Konstruktor
*/
Flugzeug::Flugzeug(const char* typ, unsigned int sitze)
{
    this->typ = strdupnew(typ);
    this->sitze = sitze;
}

/*
Kopierkonstruktor
*/
Flugzeug::Flugzeug(Flugzeug const &other)
{
    this->typ = strdupnew(other.typ);
    this->sitze = other.sitze;
}

/*
Destruktor
*/
Flugzeug::~Flugzeug()
{
    delete [] typ;
}

/*
überladene Zuweisung
*/
Flugzeug& Flugzeug::operator=(Flugzeug const &other)
{
    if(this != &other)
    {
        //Alte Daten deallokieren
        delete [] typ;

        //Neue Daten duplizieren
        this->typ = strdupnew(other.typ);
        this->sitze = other.sitze;
    }

    return *this;
}


/*
lesender Zugriff auf nr
*/
/*unsigned int Flugzeug::getNr() const
{
    return this->nr;
}*/

/*
schreibender Zugriff auf den Typ
*/
void Flugzeug::setTyp(char const *t)
{
    delete [] typ;
    this->typ = strdupnew(t);
}

/*
lesender Zugriff auf den Typ
*/
char* Flugzeug::getTyp() const
{
    return typ;
}


/*
schreibender Zugriff auf sitze
*/
void Flugzeug::setSitze(unsigned int sitze)
{
    this->sitze = sitze;
}


/*
lesender Zugriff auf sitze
*/
unsigned int Flugzeug::getSitze() const
{
    return sitze;
}

/*
lesender Zugriff auf SerienNr
*/
int Flugzeug::getSerienNr()
{
    return serienNr;
}

/*
== und < Überladungen
*/

bool Flugzeug::operator==(Flugzeug const &other)
{
    return this->sitze == other.sitze;
}

bool Flugzeug::operator<(Flugzeug const &other)
{
    return this->sitze < other.sitze;
}

/*
<< überladung
*/
ostream& operator<<(ostream &out, Flugzeug const &f)
{
    return out << "Typ: " << f.getTyp() << "\n"
               << "Sitze: " << f.getSitze();
}