#include <iostream>

using namespace std;

void func();

void end();

int main()
{
	func();
	end();
	return 0;
}

class clss{
	public:
	int num()
	{
		cout<<"Enter a number: ";
		cin>>n;
		return n;
	}
	
	private:
		int n;
};

void func()
{
	clss obj;
	cout<<"Your number is "<<obj.num()<<".";
}

void end()
{
	cout<<endl;
	system("pause");
}