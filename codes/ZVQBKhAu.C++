#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
#define MIN -1
#define NMAX 200005
long n = 0;
vector <vector <long> > v(100001);

void init(long a[])
{
    long i;
    for(i = 0;i < n;i++)
        v[a[i]].push_back(i);
}
long count(long l,long r,long x)
{
    vector<long> a = v[x];
    long s = a.size(),res = 0;
    for(long i = 0; i < s;i++)
    {
        if(a[i] >= l && a[i] <= r)
            res++;
    }
    return res;
}
class node
{
public:
    friend class segmentTree;
    long l,r,maxval;
};
class segmentTree
{
public:	
	segmentTree(vector <node> &s,long a[])
	{
		build(s,a,0,n - 1,0);
	}
	long build(vector <node> &s,long a[],long start,long end,long index)
	{
		if (start == end)
		{
			s[index].maxval = a[start];
			s[index].l = start;
			s[index].r = end;
			return (s[index].maxval);
		}
		s[index].l = start;
		s[index].r = end;
		return (s[index].maxval = max(build(s,a,(start + end)/2 + 1,end,2*index + 2),
        build(s,a,start,(start + end)/2,2*index + 1)));
	}
	long rmq(vector <node> &s,long index,long l,long r)
	{
		if (index >= 2*n + 1 || (s[index].l > r || s[index].r < l))
		{
			return MIN;
		}
		if ((s[index].l == s[index].r) || (l <= s[index].l && r >= s[index].r))
		{
			return s[index].maxval;
		}
		return max(rmq(s,2*index + 1,l,r),rmq(s,2*index + 2,l,r));
	}
};
int main()
{
    long m;
    cin >> n >> m;
    long a[n];
    vector <node> s(2*n + 1);
    for(long i = 0; i < n;i++)
        cin >> a[i];
    segmentTree t(s,a);
    init(a);
    while(m-->0)
    {
        long qs,qe;
        cin >> qs >> qe;
        long max = t.rmq(s,0, qs - 1, qe - 1);
        //cout << v[max][0] << v[max][1];
        cout << count(qs - 1,qe - 1,max) << endl;
    }
    return 0;
}