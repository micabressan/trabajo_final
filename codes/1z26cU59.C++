/*Создать абстрактный класс CVehicle. На его основе реализовать классы CPlane, ССаг и CShip. Классы должны иметь возможность:
­	задавать и получать координаты,
­	параметры средств передвижения (цена, скорость, год выпуска).
­	Для самолета должна быть определена высота,
­	для самолета и корабля — количество пассажиров.
­	Для корабля — порт приписки.
Написать программу, создающую список объектов этих классов в динамической памяти. Программа должна содержать меню, позволяющее осуществить проверку всех методов классов.

 */
#include <iostream>
#include <vector>
#include<cstring>

using namespace std;
class CVehicle {
private: int x, y, year;
           float price, speed;
public:
CVehicle(int x,int y, int year, float price, float speed){ //constructor CVehicle
    this->x = x; this->y = y;
    this->year = year;
    this->price = price;
    this->speed = speed;
}
void get_parametr() {
    cout << "Введите координаты: ";
    cin >> x >> y;
    cout << "Coordinats:"<< this->x << " " << this->y << endl;
    cout << "Year" << this->year << endl;
    cout << "Price" << this->price << endl;
    cout << "Speed" << this->speed << endl;
}
};
class CPlane : public CVehicle {
private: unsigned high; unsigned number_of_pasangers;
public:
    CPlane(int x,  //constructor CPlane
        int y,
        int year,
        float price,
        float speed,
        unsigned high,
        unsigned number_of_pasangers
        ):CVehicle( x,y,year,price,speed) {
        this->high = high;
        this->number_of_pasangers = number_of_pasangers;
}
    void get_high(int high) {
        cout << "High of a plain is: " << this->high;
    }
};
class CCar:public CVehicle {
private:
public:
CCar(int x,  //constructor CCar
     int y,
     int year,
     float price,
     float speed
    ):CVehicle(x, y, year, price, speed) {}
~CCar(){};
};

class CShip :public CVehicle {
private: unsigned number_of_pasangers;
         char name_of_port[7];

public:
    CShip(int x,  //constructor CShip
        int y,
        int year,
        float price,
        float speed,
        unsigned number_of_pasangers,
        char* name_of_port
    ) :CVehicle(x, y, year, price, speed) {
        strcpy(this->name_of_port,name_of_port);
        this->number_of_pasangers = number_of_pasangers;
    }
    void get_number_of_pasangers(int number_of_pasangers) {
        cout << "Number of passangers: " << this->number_of_pasangers;
    }
};
int main(int argc, char* argv[])
{
    CPlane *plain = new CPlane(15, 18, 1997, 100000, 350.4, 10000, 169);
    plain->get_parametr();
    CCar *car = new CCar(17, 13, 1993, 250000.3, 60);
    CShip *ship = new CShip(35,45,2005,300000,100.4,356,"Port_1");

    return 0;
}