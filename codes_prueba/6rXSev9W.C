long int power(int x, int y){
    long int result=1;
    for(;y>0;y--) result *= x;
    return result;
}

long int multi(long int x,long int y,int size) { // gia x=2343556 kai y=9873432 me size=7
    if(size==1){return x*y;}
    long int a=x/power(10,size/2);     // a=2343    *tessera prota psifia tou x
    long int b=x%(a*power(10,size/2));  // b=556    *tria teleftea psifia tou x
    long int c=y/(power(10,size/2));    // c=9873   *tessera prota psifia tou y
    long int d=y%(c*power(10,size/2));  // b=432    *tria teleftea psifia tou y
    //ypologizo to ginomeno a*c me anadromh
    long int ac=multi(a,c,(size/2)+(((size%2)==0)?0:1));
    //ypologizo to ginomeno b*d me anadromh
    long int bd=multi(b,d,(size/2));
    //tora prepei na ipologiso ta ad kai bc ostoso an ipologiso to (a+b)*(c+d) kai afereso ta ac kai bd tha prokipsei
    //to athrisma ton ad kai bc me mia mono anadromikh klish anti gia 2
    long int adPlusbc=multi(a+b,c+d,(size/2)+(((size%2)==0)?0:1))-ac-bd; // xrisimopoio os size ths klishs to size tou megaliterou
    //tora epistrefo to apotelesma apo thn formula : a*c*10^size  + (a*d+b*c)*10^size/2 + b*d
    return power(10,size)*ac + power(10,(size/2)+(((size%2)==0)?0:1))*adPlusbc + bd;
} 
int main()
{
    int n1=523,n2=112;
    long int r1=n1*n2;
    long int r2=multi(n1,n2,5);
    printf("stadart multiplication : %d*%d=%li\ndevide and conquer multiplication %d*%d=%li\n",n1,n2,r1,n1,n2,r2);
}