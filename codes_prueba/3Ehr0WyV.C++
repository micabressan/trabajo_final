#include <iostream>

using namespace std;

int main()
{
    int a = 'A';
    int counter_1=0;
    char wrd[100];
    cin.getline(wrd,100);
    int amount [26];
    char alphabet [26];
    int currentLetter = 0;
    int counter = 65;
    while (wrd[counter_1] > 0) {
        if (wrd[counter_1]>= 'a'&& wrd[counter_1]<='z') {
            wrd[counter_1]=wrd[counter_1]-32;
        }
        counter_1++;
    }
    counter_1=0;
    while (counter_1 < 26)
    {
        alphabet[counter_1]=counter;

        counter++;
        counter_1++;


    }
    counter=0;
    while (counter < 26)
        {
            amount[counter]=0;
            counter++;
        }
        counter=0;
    while (counter <=25)
    {
        while (wrd[currentLetter] > 0)
        {
            if (wrd[currentLetter] == a)
                amount[counter] ++;
            currentLetter++;
        }
        currentLetter=0;
        counter++;
        a++;
    }
     counter_1=0;
    int counter_2=0;
   while (25 > counter_1)
    {
        while (25>counter_2)
        {
            if (amount[counter_2] < amount[counter_2+1])
            {
                a = amount[counter_2];
                amount[counter_2] = amount[counter_2+1];
                amount[counter_2+1]= a;
                a = alphabet[counter_2];
                alphabet[counter_2] = alphabet[counter_2+1];
                alphabet[counter_2+1]= a;

            }
            counter_2++;
        }
        counter_2=0;
        counter_1++;
    }
    while (26 > counter_2)
    {
    if (amount[counter_2] != 0)
        {
        cout << amount[counter_2];
        
        cout << alphabet[counter_2]<< endl;
        counter_2++;
        }
    }
}