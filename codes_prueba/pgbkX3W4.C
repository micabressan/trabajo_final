#include <stdio.h>
#include <stdlib.h>

void mergesort(int *a, int l , int r)

{   int mid;
    if (l<r)
    {
        mid = (l+r)/2;
        mergesort(a,l,mid);
        mergesort(a,mid+1,r); 
        merge(a,l,r,mid);
    }

}

int merge(int *a,int l,int r,int mid)

{
    int i=l,j=mid+1;
    int k=l;
    int c[100];
    while(i<=mid && j <=r)
    {
        if(a[i]<=a[j])
        {
            c[k]=c[i];
            k++;
            i++;
        }
        else
        {
            c[k]=c[j];
            k++;
            j++;
        }

    }

    while(i<=mid)
    {
        c[k]=c[i];
        k++;
        i++;
    }

    while(i<=r)
    {
        c[k]=c[j];
        k++;
        j++;
    }

    for(k=l; k<=r; k++)
        a[k]=c[k];



}

int main()
{
    int a[]= {1,4,3,2,3,4};
    mergesort(a,0,5);
    int k;
    for(k=0; k<6;k++)
        printf("%d",a[k]);
    return 0;
    }