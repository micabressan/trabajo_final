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
	if (!a)
		return b;
	if (!b)
		return a;
	if (!(a & 1) && !(b & 1))
		return gcd(a >> 1, b >> 1) << 1;
	if (!(a & 1))
		return gcd(a >> 1, b);
	if (!(b & 1))
		return gcd(a, b >> 1);
	if (a > b)
		return gcd((a - b) >> 1, b);
	else
		return gcd((b - a) >> 1, a);
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
	vector<int> from(n);
	vector<nagai> val(n);
	vector<nagai> cursum(n);
	for (int i = 0; i < n - 1; ++i)
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
	for (int i = 0; i < n; ++i)
	{
		if (i == n - 1 || gcd(g, a[i]) != g)
		{
			vector<nagai> mxkek(n);
			nagai neut = -1000000000000000000LL;
			nagai cur = neut;
			for (int j = n - 1; j >= 0; --j)
			{
				if (!candel[j] && curg[j] - a[j] > cur)
				{
					curg[j] = gcd(curg[j], g);
					cur = max(cur, curg[j] - a[j]);
				}
				mxkek[j] = cur;
			}
			int maxc = 0;
			for (int i1 = i; i1 >= last; --i1)
			{
				// if (j1 < i1) continue
				nagai g1 = sum - cursum[i1] + mxkek[i1];
				if (mxkek[i1] == neut)
					continue;
				int lastc = -1;
				for (int k = i1; k <= n; k = next[k])
				{
					int c1 = c[k] + cntsuff[i1];
					nagai ansich = g1 + sum2[k];
					if (c1 <= maxc && k > i1 + 7)
						break;
					lastc = c1;
					ans[c1] = max(ans[c1], ansich);
				}
				maxc = lastc;
			}
//			last = i + 1;
		}
		nagai g1 = g;
		g = gcd(g, a[i]);
		if (g != g1)
			last = i + 1;
	}
	for (int i = 1; i < n; ++i)
		ans[i + 1] = max(ans[i], ans[i + 1]);
	for (int i = 1; i <= n; ++i)
		cout << ans[i] << '\n';
}