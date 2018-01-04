//программа читает колво элементов в тексте
#include <iostream>

using namespace std;

struct El
{ char D; int k;
El *l, *r;
};

void  Dob (El *&T, char x)
{ if (T==0)
{T=new El;
T->D=x;
T->k=0;
T->l=T->r=0; }


if (x<T->D) Dob(T->l,x);
if (x>T->D) Dob (T->r,x);
if (x==T->D) T->k++;
}
void vivod (El *T) 
{ if (T!=0)
{ vivod (T->l);
cout<<T->D<<"("<<T->k<<")\n";
vivod (T->r);
}
}


void PRINT (El *T, int u)
{ if (T!=0) 
{
PRINT (T->r, u+1);
for (int i=0; i<u; i++)
cout<<"\t.";    //пробелы
cout<<T->D<<endl;
PRINT (T->l, u+1);
}
}

int height (El *T, int hl, int hr)    // Высота дерева!
{
if (T==0) return (0);
else  { hl=height(T->l, hl, hr);
       hr=height(T->r, hl, hr);
       if (hl>hr) return (1+hl);
       else return (1+hr);  }
}


int main ()
{ El *A=0;
string S;
getline (cin, S);   //ввод данных
{
for ( int i=0; i<S.length(); i++)
Dob (A, S[i]);
PRINT (A, 0);
vivod (A);
};
 
 cout<<endl<<"height="<<height(A,0,0)<<endl;  //Выводит высоту дерева

cin>>S;
return 0; }