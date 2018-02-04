#include <stdio.h>
#include <windows.h>
#include <conio.h>
#include <stdlib.h>

struct Dog
{
    char* name;
    char* breed;
    int weight;
    int year;
};

int SecureEntry(bool zero = false)
{
    char String[10];
    int value = 0;
    while(true)
    {
        scanf("%s", String);
        if(abs(atoi(String)))
            value = abs(atoi(String));
        else
            value = 0;
        if (zero) break;
        if (!zero && value > 0)
            break;
        else
            printf("Введите значение |n| > 0: ");
    }
    return value;
}

char* strEdit()
{
    char* cloneString = NULL;
    char* String = NULL;

    int Size = 0;

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
            String[Size] = '_';
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
    return String;
}

Dog* DogRemove(Dog* dogs, int &Size)
{
    if(Size == 0)
    {
        printf("Список собак пуст.\n\n");
        return dogs;
    }
    printf("\nВыберите собаку от 1..%d: ", Size);
    int Index = SecureEntry();
    Index--;

    if(Index >= Size)
    {
        printf("Собака не найдена!\n\n");
        return dogs;
    }

    Size--;
    Dog* copyDogs = new Dog[Size];
    for (int i = 0; i < Index; ++i)
        copyDogs[i] = dogs[i];
    for (int i = Index; i < Size; ++i)
        copyDogs[i] = dogs[i + 1];
    delete[] dogs;

    printf("Собака была удалена!\n\n");
    return copyDogs;
}

Dog* DogAdd(Dog* dogs, int &Size)
{
    Dog dog;
    printf("\n[Добавление в список]:\n");

    printf("Кличка: ");
    dog.name = strEdit();
    printf("%s\n", dog.name);

    printf("Порода: ");
    dog.breed = strEdit();
    printf("%s\n", dog.breed);

    printf("Вес: ");
    dog.weight = SecureEntry();

    printf("Год рождения: ");
    dog.year = SecureEntry();

    Size++;
    Dog* copyDogs = new Dog[Size];
    for (int i = 0; i < Size - 1; i++)
        copyDogs[i] = dogs[i];
    copyDogs[Size - 1].name = dog.name;
    copyDogs[Size - 1].breed = dog.breed;
    copyDogs[Size - 1].weight = dog.weight;
    copyDogs[Size - 1].year = dog.year;
    delete[] dogs;

    printf("Собака была добавлена в список.\n\n");

    return copyDogs;
}

void Output(Dog* dogs, int Size)
{
    printf("[Вывод списка собак]:\n");
    if(Size == 0)
        printf("Список к сожалению пуст...\n\n");
    else
        for (int i = 0; i < Size; i++)
        {
            printf("%d) %s %d %d %d", i + 1, dogs[i].name, dogs[i].breed, dogs[i].weight, dogs[i].year);
            if(dogs[i].year >= 2 && dogs[i].year <= 6)
                printf(" Собака годна к службе!\n");
            else
                printf("\n");
        }
}

int main()
{
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);

    int Size = 0;
    Dog* dogs = NULL;

    bool RUN = true;
    while(RUN)
    {
        printf("[Меню]:\n");
        printf("----------------\n");
        printf("1.Вывод\n");
        printf("2.Добавить\n");
        printf("3.Удалить\n");
        printf("4.Выход\n");
        printf("----------------\n");
        switch(SecureEntry())
        {
            case 1:
            {
                Output(dogs, Size);
                break;
            }
            case 2:
            {
                dogs = DogAdd(dogs, Size);
                break;
            }
            case 3:
            {
                dogs = DogRemove(dogs, Size);
                break;
            }
            case 4:
                RUN = false;
                break;
        }
    }

    delete[] dogs;
    return 0;
}