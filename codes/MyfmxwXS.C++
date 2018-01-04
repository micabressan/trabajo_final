#include <iostream>
#include <cmath>
using namespace std;

unsigned long int findBit(unsigned long int number) {
    unsigned long int ans = 0;
    while (number >= pow(2, ans)) {
        ++ans;
    }
    return ans;
}

int main() {
    unsigned long int number, numberCopy, maxNumber;
    cin >> number;
    numberCopy = number;
    maxNumber = number;
    unsigned long int k = findBit(number);
    if (numberCopy % 2 == 1) {
        numberCopy += pow(2, k);
    }
    numberCopy = numberCopy >> 1;
    while (numberCopy != number) {
        if (maxNumber < numberCopy) {
            maxNumber = numberCopy;
        }
        if (numberCopy % 2 == 1) {
            numberCopy += pow(2, k);
        }
        numberCopy = numberCopy >> 1;
    }
    cout << maxNumber << "\n";
}