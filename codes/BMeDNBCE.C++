#include <iostream>
#include <string>
#include <stdio.h>
#include <vector>

using namespace std;

void multiply(string num1, string num2){
	vector<int> answer(num1.size() + num2.size(), 0);
	for (int i = num1.size()-1; i>=0; i--){
		for(int j = num2.size() - 1; j >= 0; j--){
			answer[i+j+1] += (num2[j]-'0')*(num1[i]-'0');
		}
	}

	for(int i=num1.size()+num2.size(); i>=0; i--){
		if(answer[i]>=10){
			answer[i-1]+=answer[i]/10;
			answer[i]%=10;
		}
	}

	cout<<num1<<" * "<<num2<<endl<<"= ";

	for(int i=0; i<num1.size()+num2.size(); i++){
		cout<<answer[i];
	}

	cout<<endl;
}


int main(){
	string a1="", a2="";
	cout<<"Enter first number: ";
	cin>>a1;
	cout<<"Enter second number: ";
	cin>>a2;
	multiply(a1, a2);
	return 0;
}