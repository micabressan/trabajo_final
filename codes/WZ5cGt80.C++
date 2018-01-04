Result NewtonsMethod(function <long double(long double)> f,
                     function <long double(long double)> df,
                     const long double xn,
                     const long double eps) {
    long double x1 = xn - f(xn) / df(xn);
    long double x0 = xn;
    int step = 0;
    while (fabs(x0 - x1) > eps) {
        x0 = x1;
        x1 = x1 - f(x1) / df(x1);
        ++step;
    }
    return {step, x1, fabs(x1 - x0), f(x1)};
}