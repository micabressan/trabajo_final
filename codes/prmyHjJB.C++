#include<iostream>
using namespace std;
int a, b, c;

void main()
{//A תוכנית לקליטת שלושה מספרים ופליטת הגדול מביניהם
cout <<"enter three numbers";
cin >> a;
cin>>b;
cin>>c;
if (a>b&&a>c)
cout << a ;
else { 
	if(b>a && b>c)
cout << b;
else {cout <<c;}

}}