#include <fstream>
#include <iostream>

#include <stdlib.h> // system("PAUSE");
#include <time.h>   // srand(time(NULL));

using namespace std;

bool bitTest(const char *filename);
bool poker(const char *filename);
bool series(const char *filename);
bool longSeries(const char *filename);

bool genKey(const char *filename, int len);

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        cout<<"Wrong argc"<<endl;
        cout<<"randtest.ext [filename]"<<endl;
        return -1;
    }

    //genKey(argv[1], 20000);

    if(bitTest(argv[1]))
        cout<<"Bit Test: passed."<<endl;
    else
        cout<<"Bit Test: failed."<<endl;

    if(poker(argv[1]))
        cout<<"Poker Test: passed."<<endl;
    else
        cout<<"Poker Test: failed."<<endl;

    if(series(argv[1]))
        cout<<"Series Test: passed."<<endl;
    else
        cout<<"Series Test: failed."<<endl;

    if(longSeries(argv[1]))
        cout<<"Long Series Test: passed."<<endl;
    else
        cout<<"Long Series Test: failed."<<endl;

    system("PAUSE");
    return 0;
}

bool genKey(const char* filename, int len)
{
    ofstream key(filename);

    srand(time(NULL));

    for(int i = 0; i < len; i++) {
        key.put(rand()%2+48);
    }

    key.close();
    return true;
}


bool bitTest(const char* filename)
{
    int buffer;
    int count = 0;

    ifstream key;
    key.open(filename, ios::binary);

    for(int i = 0; i < 20000; i++) {
        buffer = key.get();
        if(buffer != EOF) {
            if((buffer - '0') == 1)
                count++;
        }
        else
            break;
    }

    key.close();


    if((9725 < count) && (count < 10275))
        return true;
    else
        return false;
}

bool poker(const char* filename)
{
    int *count = new int[16];
    int buffer;
    int num;
    int pow;
    long p = 0;

    ifstream key;
    key.open(filename, ios::binary);

    for(int i = 0; i < 16; i++)
        count[i] = 0;
    for(int i = 0; i < 5000; i++) {
        num = 0;
        for(int j = 0; j < 4; j++) {
            buffer = key.get();
            if(buffer != EOF) {
                pow = 1;
                // potęgowanie...
                for(int k = 3; k > j; k--) {
                    pow *= 2;
                }
                num += (buffer-'0')*pow;
            }
            else
                break;
        }
        count[num]++;
        if(buffer == EOF)
            break;
    }

    key.close();

    for(int i = 0; i < 16; i++)
        p += count[i]*count[i];
    p = 16*p/5000-5000;

    if((2.16 < p) && (p < 47.6))
        return true;
    else
        return false;
}

bool series(const char* filename)
{
    int buffer;
    int num = 0;
    int *count = new int[6];
    int buffer2;

    ifstream key;
    key.open(filename, ios::binary);

    for(int i = 0; i < 6; i++)
        count[i] = 0;

    buffer2 = key.get();
    for(int i = 0; i < 20000; i++) {
        buffer = key.get();
        if(buffer != EOF) {
            if(buffer == buffer2)
                num++;
            else {
                if(num >= 6)
                    count[5]++;
                else
                    count[(num-1)]++;
                buffer2 = buffer;
                num = 0;
            }
        }
        else {
            if(num >= 6)
                count[5]++;
            else
                count[(num-1)]++;
            break;
        }
    }

    key.close();

    if((2315 <= count[0]) && (count[0] <= 2685) &&
       (1114 <= count[1]) && (count[1] <= 1386) &&
       (527 <= count[2]) && (count[2] <= 723) &&
       (240 <= count[3]) && (count[3] <= 384) &&
       (103 <= count[4]) && (count[4] <= 209) &&
       (103 <= count[5]) && (count[5] <= 209))
        return true;
    else
        return false;
}

bool longSeries(const char* filename)
{
    int buffer;
    int max = 0;
    int count = 0;
    int buffer2;

    ifstream key;
    key.open(filename, ios::binary);

    buffer2 = key.get();
    for(int i = 0; i < 20000; i++) {
        buffer = key.get();
        if(buffer != EOF) {
            if(buffer == buffer2)
                count++;
            else {
                buffer2 = buffer;
                count = 1;
            }
            if(max < count)
                max = count;
        }
        else
            break;
    }
    if(max < 26)
        return true;
    else
        return false;
}