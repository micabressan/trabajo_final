#include<stdio.h>
#include<conio.h>
void main()
{
 int i,j,n,tot_m,m_os,m[10],m2[1024],temp=0,tm;
 clrscr();
 printf("Enter the memory size (in MB) = ");
 scanf("%d",&tot_m);
 printf("Enter OS size (in MB) = ");
 scanf("%d",&m_os);
 printf("Enter the number of processes = ");
 scanf("%d",&n);
 tot_m=m_os;
 for(i=0;i<n;i++)
 {
  printf("Enter memory size for processes %d = ",(i+1));
  scanf("%d",&m[i]);
  m2[i]=m[i];
 }
 for(i=0;i<n;i++)
 {
  if(m[i]<=tot_m)
  {
   printf("Memory allocated for process %d\n",(i+1));
   printf("Memory %d to %d\n",temp,(m[i]+temp));
   temp+=m[i];
   tot_m-=m[i];
   m2[i]=-1;
  }
  else
  {
   if(m2[i]==-1)
   {
    tot_m+=m[i];
    tm=0;
   }
   printf("\nProcess %d completed",(i-1));
   printf("\nProcess %d allocated",(i+1));
   printf("\nMemory %d to %d",tm,(m[i]+tm));
   tm+=m[i];
  }
 }
 if(tot_m>0)
 {
  printf("\nFree Space (in MB) = %d",tot_m);
 }
 else
 {
  printf("\nNo free space at some instant");
 }
 getch();
}