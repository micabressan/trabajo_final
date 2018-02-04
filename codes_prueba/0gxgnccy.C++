  1 #include <iostream>
  2 
  3 using namespace std;
  4 
  5 int findMin(int a[], unsigned int leftIndex, unsigned int rightIndex)
  6 {
  7         while(leftIndex <= rightIndex)
  8             {
  9                 unsigned int mid = (leftIndex + rightIndex) / 2;
 10                 cout << "l: " << leftIndex << " r:" << rightIndex << endl;
 11                 cout << mid << endl;
 12                 if(leftIndex  == rightIndex) return a[rightIndex];
 13                 if(a[rightIndex] > a[mid]) rightIndex = mid;
 14                 if(a[leftIndex] < a[mid]) leftIndex = mid;
 15             }
 16 }
 17 
 18 int main(){
 19  int a[]={4,5,7,1,2,3};
 20  cout << findMin(a, 0, 5) << endl;
 21 }