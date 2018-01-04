#include <stdio.h> //printf(); scanf();
#include <cstdlib> //atoi();
#include <conio.h> //_getch();
#include <windows.h>
#include <ctime> //stime(time(0));

int SecureWrite()
{
    char String[10];
    int value = 0;
    while(true)
    {
        scanf("%s", String);
        // ?: - Это тернарный оператор Одним из существенных отличий обычного оператора if … else это то,
        //что результат операции ?: можно сохранять в переменную.
        value = abs(atoi(String))? abs(atoi(String)) : 0;
        if (value > 0)
            break;
        else
            printf("Введите значение |n| > 0: ");
    }
    return value;
}

char* InputString(int &Size)
{
    printf("Ввод строки: ");
    char* cloneString = NULL;
    char* String = NULL;

    Size = 0;

    while(true)
    {
        int symbol = _getch();

        cloneString = new char[Size + 1];
        for (int i = 0; i < Size; i++)
            if (String[i] != '\0')
                cloneString[i] = String[i];
        String = new char[Size + 1];
        for (int i = 0; i < Size; i++)
            String[i] = cloneString[i];
        delete[] cloneString;

        if ((symbol >= 'a' && symbol <= 'z') || (symbol >= 'A' && symbol <= 'Z') || (symbol >= '0' && symbol <= '9'))
        {
            String[Size] = symbol;
            Size++;
        }

        if(symbol == 32)
        {
            String[Size] = ' ';
            Size++;
        }

        if (symbol == 8 && Size > 0)
        {
            String[Size] = ' ';
            Size--;
        }

        if (symbol == 13)
        {
            String[Size] = '\0';
            break;
        }
    }
    printf("%s\n\n", String);
    return String;
}

void DataProcessing(char* String, int Size, char gls[]){
    int gl = 0;
    for(int i = 0; i < Size; i++)
        for(int j = 0; j < 12; j++)
            if(String[i] == gls[j])
                gl++;
    printf("[Обработка]:\nКол. гласных букв: %d\n\n", gl);
}

void OutputString(char* String){
    printf("[Вывод строки]:\n%s\n\n", String);
}

int main()
{
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);

    char* String = new char[1];
    String[0] = '\0';
    int Size = 0;

    char gls[13] = "aeiuoyAEIUOY";

    bool RUN = true;
    while(RUN){
        printf("[Меню]:\n");
        printf("---------------------\n");
        printf("1.Ввод строки\n");
        printf("2.Обработка строки\n");
        printf("3.Вывод строки\n");
        printf("4.Выход\n");
        printf("---------------------\n");
        switch(SecureWrite()){
            case 1:
            {
                String = InputString(Size);
                break;
            }
            case 2:
            {
                DataProcessing(String, Size, gls);
                break;
            }
            case 3:
                OutputString(String);
                break;
            case 4:
                RUN = false;
                break;
            default:
                break;
        }
    }
    delete[] String;
    return 0;
}