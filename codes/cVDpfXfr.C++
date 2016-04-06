#include<iostream>
using namespace std;

void Inverse(char [] , char []);
void Check(char [],char[]);

int main()
{
	char Number1[6] , Number2[6];
	cout << "Enter number from 5 bit : ";
	cin >> Number1;
	Inverse(Number1,Number2);
	Check(Number1 , Number2);
    system("pause");
    return 0;
}

// دالة لقلب الرقم
void Inverse(char Number1[] , char Number2[])
{
	for(int a=0,b=4;a<5;a++,b--)
		Number2[a] = Number1[b] ;
}








// دالة للتحقق من قراءة الرقم من الطرفين
void Check(char Number1[],char Number2[])
{
	bool Result = true;
for(int a=0;a<5;a++)
	if( Number1[a] != Number2[a] )
	{
		Result = false;
		break;
	}
	if(Result == true)
		cout << "The number is same read from right and left\n";
	else
		cout << "The number is not same read from right and left\n";

}