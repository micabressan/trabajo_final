#include <iostream>
using namespace std;
#define Size 100
int arr[Size];
int SizeOfArray;
template <typename T> void quickSort(T *numbers, int left, int right)
{
  int pivot = numbers[left]; // разрешающий элемент
  int l_hold = left; //левая граница
  int r_hold = right; // правая граница
  while (left < right) // пока границы не сомкнутся
  {
    while ((numbers[right] >= pivot) && (left < right))
      right--; // сдвигаем правую границу пока элемент [right] больше [pivot]
    if (left != right) // если границы не сомкнулись
    {
      numbers[left] = numbers[right]; // перемещаем элемент [right] на место разрешающего
      left++; // сдвигаем левую границу вправо
    }
    while ((numbers[left] <= pivot) && (left < right))
      left++; // сдвигаем левую границу пока элемент [left] меньше [pivot]
    if (left != right) // если границы не сомкнулись
    {
      numbers[right] = numbers[left]; // перемещаем элемент [left] на место [right]
      right--; // сдвигаем правую границу вправо
    }
  }
  numbers[left] = pivot; // ставим разрешающий элемент на место
  pivot = left;
  left = l_hold;
  right = r_hold;
  if (left < pivot) // Рекурсивно вызываем сортировку для левой и правой части массива
    quickSort(numbers, left, pivot - 1);
  if (right > pivot)
    quickSort(numbers, pivot + 1, right);
}

int main()
{
    int i = 0;
    cout << " Hello, let's sort your array! Write size of array:  ";
    cin >> SizeOfArray;
    for (i = 0; i < SizeOfArray; i++)
    {
        cout << "[" << i + 1 << "]" << ": ";
        cin >> arr[i];
    }
    cout << "your array is: ";
    for (i = 0; i < SizeOfArray; i ++)
    {
        cout << arr[i] << "  ";
    }
    cout << endl;
    quickSort(arr, 0, SizeOfArray - 1);
    cout << "your new array: ";
    for (i = 0; i < SizeOfArray; i++)
    {
        cout << arr[i] << "  ";
    }
    cout << endl;
    return 0;
}