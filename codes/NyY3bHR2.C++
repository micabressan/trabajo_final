#include <iostream>
using namespace std;

int main()
{
    int n, min1, min2, max1, max2, m, i;
    cin >> n;
    i = 1;
    max1 = -45000;
    max2 = -45000;
    min1 = 45000;
    min2 = 45000;
    while(i != n + 1)
    {
      cin >> m;
      if(m > max1)
      {
        max2 = max1;	
        max1 = m;
      }
      else
      if(m > max2)
        max2 = m; 
      if(m < min1)
      {
        min2 = min1;
        min1 = m;
      }
      else
      if(m <= min2)
      {
        min2 = m;
      }
      i++;
    }
    if(((max1 * min1) < (min1 * min2)) && ((max1 * min1) < (max1 * max2)))
      cout << max1 * min1;
    else
    if(((max1 * min1) > (min1 * min2)) && ((min2 * min1) < (max1 * max2)))
      cout << min1 * min2;
    else
      cout << max1 * max2;
    cout << min1 << min2 << max1 << max2;
    return 0;
}