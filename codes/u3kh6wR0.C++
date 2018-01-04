#include <fstream>
#include <string>
#include <algorithm>
#include <vector>
#include <unordered_set>

using namespace std;

ifstream fin ("zimeria.in");
ofstream fout ("zimeria.out");

short p,v[300];
int n,i,j,h,t;
char c;

string s;
vector <string> a;
unordered_set <string> myset;

bool cmp ( string a, string b )
{
    int i,h;

    h = min ( a.length(), b.length() );

    for ( i=0; i < h; i++ )
        if ( v[a[i]] > v[b[i]] )
            return 0;
        else if(v[a[i]] < v[b[i]])
            return 1;

    if ( a.length() > b.length() )
        return 0;

    return 1;
}

int main()
{
    fin >> p >> n;

    if(p==1)
    {
        fin>>s;

        for ( i=0; i<n; i++ )
        {
            fin>>s;

            if( myset.find(s) == myset.end() )
            {
                myset.insert(s);
                t++;
            }
        }

        fout<<t;
    }
    else
    {

        for ( i=0; i<12; i++ )
        {
            fin >> c;
            v[c] = i;
        }

        for ( i=0; i<n; i++ )
        {
            fin>>s;
            a.push_back(s);
        }

        sort(a.begin(),a.end(),cmp);

        h = a.size();

        for ( i=0; i<h; i++ )
            fout << a[i] << '\n';
    }

    return 0;
}