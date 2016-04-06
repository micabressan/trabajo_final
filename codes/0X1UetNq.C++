#include<iostream>
#include<iomanip>
#include<vector>
#include<stack>
#include<map>
#include<algorithm>
#include<set>
#include<cmath>

#define PI 3.14159265358979323846264338327950288419

using namespace std;

int main(){
int testcases;
cout<<fixed<<setprecision(7)<<endl;
cin>>testcases;
for(int i  = 0; i < testcases; i++){
  long double v, s;
  cin>>v>>s;
  long double  angle = (90 / PI) * asin((s * 9.8) / (v * v)) ;
  cout<<"Case #"<<i + 1<<":  "<<angle<<endl;
}
return 0;
}