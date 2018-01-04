#include "Mode.h"
//Constructor
Mode::Mode(int *a,int s){
    //Copy the array
    this->bSize=s;
    this->b = new int[s];
        for(int i=0;i<s;++i){
            this->b[i]=a[i];
        }
    //Sort then find the mode
    this->b=this->mark_Sort(this->b,s);
    this->nMode();
}

//Utility function
int * Mode::mark_Sort(int *b,int len){
        for(int i=0;i<len-1;++i){
            for(int j=i+1;j<len;++j){
                if(b[i]>b[j]){
                    b[i]=b[i]^b[j];
                    b[j]=b[i]^b[j];
                    b[i]=b[i]^b[j];
                }
            }
        }
        return b;
}

//One way to do the mode
void Mode::nMode(){
        //First find the max_frequency
        int count=1;max_Freq=1;
        for(int i=0;i<(bSize-1);i++){

            if(b[i]==b[(i+1)]){
                count++;
            }
            else if (b[i]!=b[i+1]){
                if(count>max_Freq){
                    max_Freq=count;
                }
                count=1;
            }
        }int set_Freq(max_Freq);
        //cout<<"Max Frequency = "<<max_Freq<<endl;
        //Now to find the number of modes6
        num_Modes=0;
        count=1;
        for( int i=0;i<(bSize-1);i++){
            if(b[i]==b[i+1]){//if the arrays element is == to the next element in the array
                count++;
                if(count==max_Freq){//if current frequency is == to the max frequency
                    num_Modes++;
                }
            }
            else if(b[i]!=b[i+1]){//if the arrays element is not == to the next element in the array, reset the current frequency
                count=1;
            }
        }int set_numModes(num_Modes);
        //cout<<"Number of Modes = "<<num_Modes<<endl;

        //Now to fill the array with modes
        this->m = new int[num_Modes];
        int j=0;
        count=1;
        for(int i=0;i<(bSize);i++){//going through array
            if(b[i]==b[i+1]){//if element is == to next element, count ++
                count++;
                if(count==max_Freq){//if count is == to the max frequency, then this element must be a mode
                    this->m[j]=b[i];//assign this element to the new modes array
                    if(j<num_Modes){//if the current element in the mode array is < than the number of modes
                        j++;//increment mode element so it advances in the mode array
                    }
                    
                }
            }
            else if(b[i]!=b[i+1]){
                count=1;        //Reset mode count 
            }
        }
    
       
   }  

int Statistics::set_Median(){
           
       middle=bSize/2;
    if(middle%2==0)//Calculate if size of array is even or odd
    {
     median=((b[middle]) + (b[middle-1]))/2;
    }
    else
    {
        median=b[middle];
    }  
       int set_Median(median);
       
           }