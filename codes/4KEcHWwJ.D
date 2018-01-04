// ldc2.exe -release -m64 -O heapsort.d

import std.conv;
import std.stdio;

const int IM = 139968;
const int IA =   3877;
const int IC =  29573;

double gen_random(double max)
{
    static int last = 42;
    return max * (last = (last * IA + IC) % IM) / IM;
}

void heapsort(int n, double[] ra) {
    int i, j;
    int ir = n;
    int l = (n >> 1) + 1;
    double rra;

    for (;;) {
        if (l > 1) {
            rra = ra[--l];
        } else {
            rra = ra[ir];
            ra[ir] = ra[1];
            if (--ir == 1) {
                ra[1] = rra;
                return;
            }
        }
        i = l;
        j = l << 1;
        while (j <= ir) {
            if (j < ir && ra[j] < ra[j+1])
                ++j;
            if (rra < ra[j]) {
                ra[i] = ra[j];
                j += (i = j);
            } else {
                j = ir + 1;
            }
        }
        ra[i] = rra;
    }
}

void main(string[] args)
{
    int N = args.length < 2 ? 1 : to!int(args[1]);
    auto ary = new double[N + 1];
    
    for (int i = 1; i <= N; i++)
       ary[i] = gen_random(1);

    heapsort(N, ary);
    writeln(ary[N]);
}