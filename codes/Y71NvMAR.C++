#include <iostream>
#include <math.h>
using namespace std;

int x,y,sum=0;

bool checkS1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j-1][i-3]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j-1][i-1]=='.')
                    {
                        if(tab[j-1][i-2]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkS2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j+1][i-2]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+1][i-1]=='.')
                    {
                        if(tab[j+2][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


void setS1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x-1][y-1]='#';
    tab[x-1][y-2]='#';
}

void setS2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+1][y-1]='#';
    tab[x+2][y-1]='#';
}


bool checkZ1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j+1][i-1]=='.')
                    {
                        if(tab[j+1][i-2]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkZ2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i]=='.')
            {
                if(tab[j-1][i]=='.')
                {
                    if(tab[j-1][i-1]=='.')
                    {
                        if(tab[j-2][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


void setZ1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x+1][y-1]='#';
    tab[x+1][y-2]='#';
}

void setZ2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x-1][y]='#';
    tab[x-1][y-1]='#';
    tab[x-2][y-1]='#';
}


bool checkI1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-4]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j][i-3]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

void setI1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x][y-3]='#';
}

void setI2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x+3][y]='#';
}

bool checkI2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j+3][i]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


bool checkO(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-2]=='#'||tab[j+1][i-2]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+1][i-1]=='.')
                    {
                        if(tab[j][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

void setO(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+1][y-1]='#';
    tab[x][y-1]='#';
}


bool checkT1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#'||tab[j+1][i-2]=='#'||tab[j+1][i-3]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j+1][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkT2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#'||tab[j-1][i-2]=='#'||tab[j-1][i-3]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j-1][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkT3(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#'||tab[j+2][i-1]=='#'||tab[j+1][i-2]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j+1][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkT4(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#'||tab[j+1][i-1]=='#'||tab[j+2][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j+1][i+1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


void setT1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x+1][y-1]='#';
}
void setT2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x-1][y-1]='#';
}
void setT3(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x+1][y-1]='#';
}
void setT4(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x+1][y+1]='#';
}


bool checkJ1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#'||tab[j-1][i-1]=='#'||tab[j+1][i-2]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j-1][i]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkJ2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j+1][i-2]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkJ3(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-2]=='#'||tab[j+1][i-1]=='#'||tab[j+2][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkJ4(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#'||tab[j+1][i-1]=='#'||tab[j+2][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j+2][i+1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


void setJ1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x-1][y]='#';
}
void setJ2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x+1][y-2]='#';
}
void setJ3(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x][y-1]='#';
}
void setJ4(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x+2][y+1]='#';
}


bool checkL1(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#'||tab[j+1][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j+1][i]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkL2(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-3]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j][i-1]=='.')
                {
                    if(tab[j][i-2]=='.')
                    {
                        if(tab[j-1][i-2]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkL3(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#'||tab[j+1][i-1]=='#'||tab[j+2][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j+2][i-1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}

bool checkL4(char tab[10][20])
{
    for(int i=19;i>=0;i--)
    {
        for(int j=0;j<10;j++)
        {
            try
            {
            if(tab[j][i-1]=='#'||tab[j+1][i-1]=='#'||tab[j+2][i-1]=='#')
                continue;
            if(tab[j][i]=='.')
            {
                if(tab[j+1][i]=='.')
                {
                    if(tab[j+2][i]=='.')
                    {
                        if(tab[j][i+1]=='.')
                        {
                            x=j;
                            y=i;
                            return true;
                        }
                        else
                            continue;
                    }
                    else
                        continue;
                }
                else
                    continue;
            }
            else
                continue;
            }
            catch(exception)
            {
                 continue;
            }
        }
    }
    return false;
}


void setL1(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x+1][y]='#';
}
void setL2(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x][y-1]='#';
    tab[x][y-2]='#';
    tab[x-1][y-2]='#';
}
void setL3(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x+2][y-1]='#';
}
void setL4(char tab[10][20],int x,int y)
{
    tab[x][y]='#';
    tab[x+1][y]='#';
    tab[x+2][y]='#';
    tab[x][y+1]='#';
}


int findLines(char tab[10][20])
{
    int c=0;
    for(int i=0;i<20;i++)
    {
        for(int j=0;j<10;j++)
        {
            if(tab[j][i]=='#')
                c++;
        }
        if(c==10)
            return i;
        c=0;
    }
    return 999;
}

void deleteLines(char tab[10][20])
{
    int a = findLines(tab);
    while(a!=999)
    {
        sum++;
        for(a;a>0;a--)
        {
            for(int j=0;j<10;j++)
            {
                tab[j][a]=tab[j][a-1];
            }
        }
        for(int j=0;j<10;j++)
        {
            tab[j][0]='.';
        }
        a = findLines(tab);
    }
}

int main()
{
    char tab[10][20];
    int nowX,nowY;

    string blocks;
    for(int i=0;i<20;i++)
    {
        for(int j=0;j<10;j++)
        {
            cin>>tab[j][i];
        }
    }
    cin>>blocks;

    for(int i=0;i<blocks.length();i++)
    {
        switch(blocks[i])
        {
        case 'Z':
            {
                checkZ1(tab);
                nowX=x;
                nowY=y;
                checkZ2(tab);
                if(nowY>y)
                    setZ1(tab,nowX,nowY);
                else
                    setZ2(tab,x,y);
                break;
            }
        case 'S':
            {
                checkS1(tab);
                nowX=x;
                nowY=y;
                checkS2(tab);
                if(nowY>y)
                    setS1(tab,nowX,nowY);
                else
                    setS2(tab,x,y);
                break;
            }
        case 'I':
            {
                checkI1(tab);
                nowX=x;
                nowY=y;
                checkI2(tab);
                if(nowY>y)
                    setI1(tab,nowX,nowY);
                else
                    setI2(tab,x,y);
                break;
            }
        case 'O':
            {
                if(checkO(tab))
                    setO(tab,x,y);
                break;
            }
        case 'T':
            {
                checkT1(tab);
                nowX=x;
                nowY=y;
                checkT2(tab);
                if(nowY>y)
                {
                    checkT3(tab);
                    if(nowY>y)
                    {
                        checkT4(tab);
                        if(nowY>y)
                            setT1(tab,nowX,nowY);
                        else
                            setT4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkT4(tab);
                        if(nowY>y)
                            setT3(tab,nowX,nowY);
                        else
                            setT4(tab,x,y);
                    }
                }
                else
                {
                    nowX=x;
                    nowY=y;
                    checkT3(tab);
                    if(nowY>y)
                    {
                        checkT4(tab);
                        if(nowY>y)
                            setT2(tab,nowX,nowY);
                        else
                            setT4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkT4(tab);
                        if(nowY>y)
                            setT3(tab,nowX,nowY);
                        else
                            setT4(tab,x,y);
                    }
                }
                break;
            }
        case 'J':
            {
                checkJ1(tab);
                nowX=x;
                nowY=y;
                checkJ2(tab);
                if(nowY>y)
                {
                    checkJ3(tab);
                    if(nowY>y)
                    {
                        checkJ4(tab);
                        if(nowY>y)
                            setJ1(tab,nowX,nowY);
                        else
                            setJ4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkJ4(tab);
                        if(nowY>y)
                            setJ3(tab,nowX,nowY);
                        else
                            setJ4(tab,x,y);
                    }
                }
                else
                {
                    nowX=x;
                    nowY=y;
                    checkJ3(tab);
                    if(nowY>y)
                    {
                        checkJ4(tab);
                        if(nowY>y)
                            setJ2(tab,nowX,nowY);
                        else
                            setJ4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkJ4(tab);
                        if(nowY>y)
                            setJ3(tab,nowX,nowY);
                        else
                            setJ4(tab,x,y);
                    }
                }
                break;
            }
        case 'L':
            {
                checkL1(tab);
                nowX=x;
                nowY=y;
                checkL2(tab);
                if(nowY>y)
                {
                    checkL3(tab);
                    if(nowY>y)
                    {
                        checkL4(tab);
                        if(nowY>y)
                            setL1(tab,nowX,nowY);
                        else
                            setL4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkL4(tab);
                        if(nowY>y)
                            setL3(tab,nowX,nowY);
                        else
                            setL4(tab,x,y);
                    }
                }
                else
                {
                    nowX=x;
                    nowY=y;
                    checkL3(tab);
                    if(nowY>y)
                    {
                        checkL4(tab);
                        if(nowY>y)
                            setL2(tab,nowX,nowY);
                        else
                            setL4(tab,x,y);
                    }
                    else
                    {
                        nowX=x;
                        nowY=y;
                        checkL4(tab);
                        if(nowY>y)
                            setL3(tab,nowX,nowY);
                        else
                            setL4(tab,x,y);
                    }
                }
                break;
            }
        }

        deleteLines(tab);
    }
    cout<<sum;
}