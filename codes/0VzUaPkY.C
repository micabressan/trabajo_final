void f9(int * a, int n) {
    int flag = 1;
    while (flag) {
        flag = 0;
        int i;
        for (i = n - 2; i >= 0; --i) {
            int sgn1 = -1, sgn2 = -1;
            if (a[i] == 0)
                sgn1 = 0;
            if (a[i] < 0)
                sgn1 = 1;
            if (a[i + 1] == 0)
                sgn2 = 0;
            if (a[i + 1] < 0)
                sgn2 = 1;
            if (sgn1 > sgn2) {
                int tmp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = tmp;
                flag = 1;
            }
        }
    }
}

int f11(int * a, int n, int x) {
    int l = -1, r = n;
    while (l + 1 < r) {
        int m = (l + r) / 2;
        if (a[m] >= x)
            r = m;
        else
            l = m;
    }
    return r;
}

int * f10(int n) {
    int a[n + 1];
    int i;
    for (i = 0; i < n + 1; ++i)
        a[i] = 0;
    for (i = 0; i < n; ++i) {
        a[0] = 1;
        a[i + 1] = 1;
        int j;
        int tmp1 = 1, tmp2;
        for (j = 1; j < i + 1; ++j) {
            tmp2 = a[j];
            a[j] += tmp1;
            tmp1 = tmp2;
        }
    }
    return a;
}