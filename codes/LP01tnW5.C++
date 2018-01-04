#include<iostream>
using namespace std;

#define SIZE 111

void merge(int array[],int left,int mid,int right){
    int size1=mid-left+1;
    int size2=right-mid;
    int L[size1],R[size2];
    for(int i=0;i<size1;i++)
        L[i]=array[left+i];
    for(int j=0;j<size2;j++)
        R[j]=array[mid+1+j];
    int l=0;
    int r=0;
    int index=left;
    while(l<size1 && r<size2){
        if(L[l]<=R[r]){
            array[index]=L[l];
            l++;
        }
        else{
            array[index]=R[r];
            r++;
        }
        index++;
    }
    while(l<size1){
        array[index]=L[l];
        l++;
        index++;
    }
    while(r<size2){
        r++;
        index++;
    }
}

void mergeSort(int array[],int left,int right){
    if(left<right){
        int mid=left+(right-left)/2;
        mergeSort(array,left,mid);
        mergeSort(array,mid+1,right);
        merge(array,left,mid,right);
    }
}

int main()
{
    int size,array[SIZE];
    cout<<"Number of Element: ";
    cin>>size;
    for(int i=0;i<size;i++)
        cin>>array[i];
    mergeSort(array,0,size-1);
    for(int i=0;i<size;i++){
        cout<<array[i];
        if(i==size-1)
            cout<<endl;
        else
            cout<<" ";
    }

    return 0;
}