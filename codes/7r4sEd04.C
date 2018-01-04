void shellsort(unsigned long nel,
        int (*compare)(unsigned long i, unsigned long j),
        void (*swap)(unsigned long i, unsigned long j))
{        
    unsigned long cnt=2;
    unsigned long fib0=1, fib1=1, fib=0;
    while (fib<=nel)
    {
        cnt++;
        fib=fib0+fib1;
        fib0=fib1;
        fib1=fib;
    }
    cnt--;
    unsigned long spis[cnt];
    spis[0]=1;
    spis[1]=1;
    for (int j=2; j<cnt; j++)
    {
        spis[j]=spis[j-2]+spis[j-1];
    }
    cnt--;
    unsigned long k=spis[cnt];
    while (k>0)
    {
        for (unsigned long j=k; j<nel; j++)
        {
            int cur=j, el=j-k;
            while ((el>=0) && (compare (cur, el)<0))
            {
                swap(cur, el);
                cur-=k;
                el-=k;
            }
        }
        if (cnt==1) break;
        cnt--;
        k=spis[cnt];
    }
}