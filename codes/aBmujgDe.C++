
#include <bits/stdc++.h>
#define ll long long
#define ui unsigned int
#define pii pair<int, int>
#define pll pair<ll, ll>
#define pui pair<ui, ui>
#define pb push_back
#define ull unsigned long long
using namespace std;

/** Interface */

inline int readChar();
template <class T = int> inline T readInt();
template <class T> inline void writeInt( T x, char end = 0 );
inline void writeChar( int x );
inline void writeWord( const char *s );

/** Read */

static const int buf_size = 4096;

inline int getChar() {
    static char buf[buf_size];
    static int len = 0, pos = 0;
    if (pos == len)
         pos = 0, len = fread(buf, 1, buf_size, stdin);
    if (pos == len)
        return -1;
    return buf[pos++];
}

inline int readChar() {
    int c = getChar();
    while (c <= 32)
        c = getChar();
    return c;
}

template <class T>
inline T readInt() {
    int s = 1, c = readChar();
    T x = 0;
    if (c == '-')
        s = -1, c = getChar();
    while ('0' <= c && c <= '9')
        x = x * 10 + c - '0', c = getChar();
    return s == 1 ? x : -x;
}

/** Write */

static int write_pos = 0;
static char write_buf[buf_size];

inline void writeChar( int x ) {
    if (write_pos == buf_size)
        fwrite(write_buf, 1, buf_size, stdout), write_pos = 0;
    write_buf[write_pos++] = x;
}

template <class T>
inline void writeInt( T x, char end ) {
    if (x < 0)
        writeChar('-'), x = -x;

    char s[24];
    int n = 0;
    while (x || !n)
        s[n++] = '0' + x % 10, x /= 10;
    while (n--)
        writeChar(s[n]);
    if (end)
        writeChar(end);
}

inline void writeWord( const char *s ) {
    while (*s)
        writeChar(*s++);
}

struct Flusher {
    ~Flusher() {
        if (write_pos)
            fwrite(write_buf, 1, write_pos, stdout), write_pos = 0;
    }
} flusher;

struct ms{
    int k;
    int w;
};

int main(int argc, char *argv[])
{
    int t = readInt();
    int n = readInt();
    vector<int> a(n);
    for (int i = 0; i < n; i++) {
        a[i] = readInt();
    }
    ms dp[n + 1][n + 1];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            dp[i][j] = {INT_MAX, INT_MAX};
    dp[n - 1][0] = {1, 0};
    int ans = INT_MAX;
    for (int len = n - 1; len >= 0; len--)
        for (int i = n - len - 1; i >= 0; i--) {
            int j = i + len;
            if (dp[len][i].w + a[i] <= t){
                if (dp[len][i].k < dp[len - 1][i + 1].k || (dp[len][i].k == dp[len - 1][i + 1].k &&
                                                    dp[len][i].w + a[i] < dp[len - 1][i + 1].w))
                {
                    dp[len - 1][i + 1] = dp[len][i];
                    dp[len - 1][i + 1].w += a[i];
                    if (i + 1 > j)
                    {
                        ans = min(ans, dp[len - 1][i + 1].k);
                    }
                }
            }
            else
            {
                ms s = {dp[len][i].k + 1, a[i]};
                if (dp[len - 1][i + 1].k > s.k || (dp[len - 1][i + 1].k == s.k && dp[len - 1][i + 1].w > s.w)) {
                    dp[len - 1][i + 1] = s;
                    if (i + 1 > j)
                    {
                        ans = min(ans, dp[len - 1][i + 1].k);
                    }
                }

            }

            if (dp[len][i].w + a[j] <= t && j > 0){
                if (dp[len][i].k < dp[len - 1][i].k || (dp[len][i].k == dp[len - 1][i].k &&
                                                    dp[len][i].w + a[j] < dp[len - 1][i].w))
                {
                    dp[len - 1][i] = dp[len][i];
                    dp[len - 1][i].w += a[j];
                    if (i + 1 > j)
                    {
                        ans = min(ans, dp[len - 1][i].k);
                    }
                }
            }
            else if (j > 0)
            {
                ms s = {dp[len][i].k + 1, a[j]};
                if (dp[len - 1][i].k > s.k || (dp[len - 1][i].k == s.k && dp[len - 1][i].w > s.w)) {
                    dp[len - 1][i] = s;
                    if (i + 1 > j)
                    {
                        ans = min(ans, dp[len - 1][i].k);
                    }
                }

            }
        }
    writeInt(ans, '\n');
    return 0;
}