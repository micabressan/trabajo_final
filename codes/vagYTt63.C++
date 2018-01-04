#include <iostream>
#include <string>
#include <clocale>
 
using namespace std;
 
class Human;
 
class Book {
public:
    string name;
    int year;
    friend Human;
    Book() {
        name = "default_name";
        year = 1970;
    }
    Book(string name, int year) {
        this->name = name;
        this->year = year;
    }
    ~Book() {
    }
};
 
class Human {
public:
    string name;
    int age;
    Human() {
        name = "default_name";
        age = 0;
    }
    Human(string name, int age) {
        this->name = name;
        this->age = age;
    }
    void say(string s) {
        cout << name << " говорит " << s;
    }
    void read_book(Book& book) {
        say("прочитал книгу ");
        cout << book.name << endl;
    }
 
    ~Human() {
    }
};
 
class Pevets: public Human {
public:
    Pevets(string name, int age): Human(name, age) {
 
    }
    void say(string s) {
        cout << name << " напевает " << s;
    }
};
 
int main() {
    setlocale(0, "");
 
    Pevets mot("МОТ", 45);
    mot.say("миллионы песен\n");
 
    Book book("Колобок", 1900);
    mot.read_book(book);
}