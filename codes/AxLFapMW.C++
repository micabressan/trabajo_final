#include <iostream>

using namespace std;

int main()
{
	int n, m;

	cin >> n >> m;

	int Array[n][m];

	for ( int i = 0; i < n; i++ )
	{
		for ( int j = 0; j < m; j++ )
		{
			Array[i][j] = 0;
			Array[i][0] = 1;
			Array[0][j] = 1;

			if ( i && j )
			{
				Array[i][j] = Array[i-1][j] + Array[i][j-1];
			}
		}
	}

	for ( int j = 0; j < m; j++ )
	{
		for ( int i = 0; i < n; i++ )
		{
			cout << Array[i][j] << " ";
		}

		cout << endl;
	}

	return 0;
}