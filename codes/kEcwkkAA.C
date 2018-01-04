/**
 * helpers.c
 *
 * Helper functions for Problem Set 3.
 */

#include <cs50.h>

#include "helpers.h"

/**
 * Returns true if value is in array of n values, else false.
 */
bool search(int value, int values[], int n)
{
    // TODO: implement a searching algorithm
    int first = 0, last = n - 1;
    if (value < 0)
    {
        return false;
    }
    else
    {
        while(last >= first)
        {
            int mid = (first + last)/2;  // делим пополам массив
            if(values[mid] == value)
            {
                return true;
            }
            else if (values[mid] > value) // если значение в ячейке посередине больше искаемого, то оно становится последним и -1
            {
                last = first - 1;
            }
            else
            {
                first = last + 1; // наоборот
            }
        }
        return false;
    }
}

/**
 * Sorts array of n values.
 */
void sort(int values[], int n)
{
    // TODO: implement a sorting algorithm
    int j;//

    for(int i = 0; i < n; i++)
    {
        int smallest = i;
        for(int k = i + 1; k < n; k++)
        {
            if(values[smallest] > values[k]) // проверяем
            {
                smallest = k;
            }

        }
        // меняем местами значения
        j = values[smallest];
        values[smallest] = values[i];
        values[i] = j;
    }

}