#include <fstream>
#include <iostream>
#include <string>

using namespace std;

int main()

{
    string input;
    cout << "Enter somtething:";
    getline(cin, input);

    ofstream outfile("textoutput.txt");
    outfile << input << endl;

    outfile.close();
}