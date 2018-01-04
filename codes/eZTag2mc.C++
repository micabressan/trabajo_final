#include <iostream>
#include <string>
#include <clocale>
 
using namespace std;
 
class Human {
public:
    string name;
    int birth_date;
    Human(string name, int birth_date) {
        this->name = name;
        this->birth_date = birth_date;
    }
    void print() {
        cout << name << " (" << birth_date << ")";
    }
    ~Human() {
    }
};
 
class Text {
public:
    string publisher, name;
    int tirazh;
    Text(string name, string publisher, int count) {
        this->name = name;
        this->publisher = publisher;
        this->tirazh = count;
    }
    virtual void add(Human* h) {
    }
    virtual void print() {
        cout << "Издатель: " << publisher << endl;
        cout << "Тираж: " << tirazh << endl;
    }
    virtual ~Text() {
    }
};
 
class Book : public Text {
public:
    int author_count;
    int year;
    Human** author;
    Book(string name, int year, string publisher, int count) : Text(name, publisher, count) {
        this->year = year;
        this->author = NULL;
        this->author_count = 0;
    }
 
    void add(Human* author_new) {
        if (author_count == 0) {
            author = new Human*[1];
            author[0] = author_new;
            author_count++;
        }
        else {
            author_count++;
            Human** temp = new Human*[author_count];
            for (int i = 0; i < author_count - 1; i++) {
                temp[i] = author[i];
            }
            delete[] author;
            author = new Human*[author_count];
            for (int i = 0; i < author_count - 1; i++) {
                author[i] = temp[i];
            }
            author[author_count - 1] = author_new;
            delete[] temp;
        }
    }
 
    void print() {
        cout << "Название: " << Text::name << endl;
        cout << "Год издания: " << year << endl;
        cout << "Авторы: ";
        if (author_count == 0) {
            cout << endl;
        }
        for (int i = 0; i < author_count; i++) {
            author[i]->print();
            if (i != author_count - 1) {
                cout << ", ";
            }
            else cout << endl;
        }
        Text::print();
    }
 
    ~Book() {
       };
    
};
 
class Journal : public Text {
public:
    int author_count;
    int periodichnost;
    Human** author;
    Journal(string name, int cycle, string publisher, int count) : Text(name, publisher, count) {
        this->periodichnost = cycle;
        this->author = NULL;
        this->author_count = 0;
    }
 
    void add(Human* author_new) {
        if (author_count == 0) {
            author = new Human*[1];
            author[0] = author_new;
            author_count++;
        }
        else {
            author_count++;
            Human** temp = new Human*[author_count];
            for (int i = 0; i < author_count - 1; i++) {
                temp[i] = author[i];
            }
            delete[] author;
            author = new Human*[author_count];
            for (int i = 0; i < author_count - 1; i++) {
                author[i] = temp[i];
            }
            author[author_count - 1] = author_new;
            delete[] temp;
        }
    }
 
    void print() {
        cout << "Название: " << name << endl;
        cout << "Периодичность издания: " << periodichnost << endl;
        cout << "Редколлегия: ";
        if (author_count == 0) {
            cout << endl;
        }
        for (int i = 0; i < author_count; i++) {
            author[i]->print();
            if (i != author_count - 1) {
                cout << ", ";
            }
            else cout << endl;
        }
        Text::print();
    }
    ~Journal() {
        };
};
 
int main() {
    setlocale(0, "");
    Text** publication = new Text*[3];
    Human* tolstoi = new Human("Лев Толстой", 1799);
    Human* julus = new Human("Дьулус Петрович", 1998);
    Human* sardaana = new Human("Сардаана Васильевна", 1999);
    Human* john_sins = new Human("Джон Синс", 1985);
    Human* piper = new Human("Пайпер Перри", 1991);
 
    publication[0] = new Book("Война и мир", 1800, "ПИТЕР", 500);
    publication[0]->add(tolstoi);
    publication[0]->print();
    cout << endl;
 
    publication[1] = new Journal("Вестник СВФУ", 12, "Пресс-центр СВФУ", 300);
    publication[1]->add(julus);
    publication[1]->add(sardaana);
    publication[1]->print();
    cout << endl;
 
    publication[2] = new Journal("Nature", 24, "National Geographic Publisher", 15000);
    publication[2]->add(john_sins);
    publication[2]->add(piper);
    publication[2]->print();
    cout << endl;
 
    for (int i = 0; i < 3; i++) {
        delete publication[i];
    }
    delete publication;
    delete tolstoi;
    delete julus;
    delete sardaana;
    delete john_sins;
    delete piper;
}