#include <stdio.h>

void sort(int a[], int n)
{
    for (int i = 0; i <n; ++i)
    {
        int j = i-1;
        while (a[i] > a[j] && j >= 0)
        {
            a[j+1] = a[j];
            --j;
        }
        a[j+1] = a[i];
    }
}

int main()
{
    int a[50], n, dem = 1;
    scanf("%d",&n);
    for (int i = 0; i<n; ++i)
        scanf("%d",&a[i]);
        
    sort(a,n);
    
    printf("%d--%d\n",a[0], dem);
    for (int i = 1; i<n; ++i)
        if (a[i] == a[i-1])
            printf("%d--%d\n",a[i], dem);
        else 
        {
            dem = i+1;
            printf("%d--%d\n",a[i], dem);
        }
        
        return 0;
}