#define _GLIBCXX_DEBUG
#include <bits/stdc++.h>

using namespace std;
typedef long long nagai;

nagai gcd1(nagai a, nagai b)
{
	while (b)
	{
		a = a % b;
		swap(a, b);
	}
	return a;
}

nagai gcd(nagai a, nagai b)
{
	int ans = 0;
	while (true)
	{
		if (!a)
			return b << ans;
		if (!b)
			return a << ans;
		if (!(a & 1) && !(b & 1))
			++ans, a >>= 1, b >>= 1;
		else if (!(a & 1))
			a >>= 1;
		else if (!(b & 1))
			b >>= 1;
		else if (a > b)
			a -= b;
		else 
			b -= a;
	}
}


int main()
{
	int n;
	scanf("%d", &n);
	vector<nagai> a(n);
	for (auto& x : a)
		scanf("%lld", &x);
	sort(a.begin(), a.end());
	auto a1 = a;
	int l = unique(a1.begin(), a1.end()) - a1.begin();
	map<nagai, int> cnt;
	for (auto& x : a)
		++cnt[x];
	vector<nagai> ans(n + 1);
	nagai sum = 0;
	for (auto& x : cnt)
		sum += x.first;
	nagai g = 0;
	sum = 0;
	for (auto& x : cnt)
		sum += x.first;
	vector<int> candel(n);
	for (int i = 0; i < n; ++i)
		candel[i] = i > 0 && a[i - 1] == a[i];
	vector<int> cntsuff(n + 1);
	cntsuff[n - 1] = 1;
	for (int i = n - 2; i >= 0; --i)
		cntsuff[i] = cntsuff[i + 1] + int(a[i] != a[i + 1]);
	vector<nagai> cursum(n + 1);
	for (int i = 0; i < n; ++i)
		cursum[i + 1] = cursum[i] + (candel[i] ? 0 : a[i]);
	vector<nagai> sum2(n + 1);
	vector<int> c(n + 1);
	nagai csum2 = 0;
	int cc = 0;
	sum2.back() = c.back() = 0;
	for (int k = n - 1; k >= 0; --k)
	{
		if (candel[k])
			csum2 += a[k], ++cc;
		sum2[k] = csum2;
		c[k] = cc;
	}
	vector<int> next(n + 1);
	next[n] = n + 1;
	for (int i = n - 1; i >= 0; --i)
		if (c[i] == c[i + 1])
			next[i] = next[i + 1];
		else
			next[i] = i + 1;
	int last = 0;
	vector<nagai> curg = a;
	int C = n > 10000 ? 100 : n;
	for (int i = 0; i <= n; ++i)
	{
		if (i == n || gcd(g, a[i]) != g)
		{
			vector<nagai> mxkek(n + 1);
			nagai neut = -1000000000000000000LL;
			mxkek.back() = neut;
			nagai cur = neut;
			int mxind = -1;
			bool ok = false;
			for (int j = n - 1; j >= 0; --j)
			{
				if ((!ok || j >= i) && !candel[j] && curg[j] - a[j] > cur)
				{
					curg[j] = gcd(curg[j], g);
					if (curg[j] - a[j] > cur)
					{
						cur = curg[j] - a[j];
						mxind = j;
					}
					ok = true;
				}
				mxkek[j] = cur;
			}
			int maxc = 0;
			for (int i1 = i; i1 >= last; --i1)
			{
				nagai g1 = sum - cursum[i1] + mxkek[0];
				if (mxkek[i1] == neut)
					continue;
				int lastc = -1;
				int k = 0;
				int it = 0;
				for (k = i1; k <= n; k = next[k], ++it)
				{
					int c1 = c[k] + cntsuff[i1];
					nagai ansich = g1 + sum2[k];
					if (c1 <= maxc)
						break;
					lastc = c1;
					ans[c1] = max(ans[c1], ansich);
				}
				maxc = c[i1] + cntsuff[i1];
			}
			maxc = 0;
			for (int i1 = i; i1 >= last; --i1)
			{
				if (i1 == 0)
					continue;
				nagai g1 = sum - cursum[i1] + g;
				int lastc = -1;
				int k = 0;
				int it = 0;
				for (k = i1; k <= n; k = next[k], ++it)
				{
					int c1 = c[k] + cntsuff[i1] + 1;
					if (i1 < n && candel[i1])
						--c1;
					nagai ansich = g1 + sum2[k];
					if (c1 < maxc)
						break;
					if (lastc == -1)
						lastc = c1;
					ans[c1] = max(ans[c1], ansich);
				}
				if (lastc >= 0)
				maxc = lastc;
			}
			last = i + 1;
		}
		if (i < n)
		{
			nagai g1 = g;
			g = gcd(g, a[i]);
		}
	}
	for (int i = 1; i < n; ++i)
		ans[i + 1] = max(ans[i], ans[i + 1]);
	for (int i = 1; i <= n; ++i)
		cout << ans[i] << '\n';
}