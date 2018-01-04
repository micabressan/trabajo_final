#include <iostream>

using namespace std;

class Student {
protected:
    string fullName, faculty;
    int course, minMark;
public:
    Student(const string &n, const string &f, int c, int m)
    {
        fullName = n;
        faculty = f;
        course = c;
        minMark = m;
    }

    void information()
    {
        cout << fullName << ", " << faculty << ", " << course
             << ", " << minMark << ", " << scholarship() << '\n';
    }
    virtual void improvement()
    {
        course += minMark / 3;
    }

    virtual int scholarship()
    {
        switch (minMark){
            case 4:
                return 200;
            case 5:
                return 300;
            default:
                return 0;
        }
    }
};

class Contractor : public Student {
private:
    bool contract;
public:
    Contractor(const string &n, const string &f, int c, int m, bool a) : Student(n, f, c ,m)
    {
        contract = a;
    }

    void improvement()
    {
        course += minMark / 3 & contract;
    }

    int scholarship()
    {
        return 0;
    }
};

int main() {
    setlocale(LC_ALL, "Rus");
    Student *man;
    man = new Student("Груздев Марк", "ПММ", 2, 5);
    man->information(); man->improvement(); man->information();
    man = new Contractor("Иванов Иван", "ПММ", 2, 4, false);
    man->information(); man->improvement(); man->information();
    man = new Contractor("Петров Петр", "ПММ", 2, 3, true);
    man->information(); man->improvement(); man->information();
    system("pause");
    return 0;
}