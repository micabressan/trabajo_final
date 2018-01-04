
#ifndef _MODE_H
#define	_MODE_H

class Mode {
protected:
    int *b;//Sorted Array
    int bSize;//Size of Sorted Array;
    int max_Freq;//Frequency of the mode set,
    int num_Modes;//Number of Modes, size of Mode Array
    int *m;//Mode Array
    int *mark_Sort(int *,int);//Utility function for the class
public:
    Mode();
     Mode(int *,int);//Constructor inputing the initial
    ~Mode(){//Constructor inputing the initial
        delete []b;
        delete []m;
    }
    void nMode();//Main worker function
    int const * get_Sort()const{
        return b;
    }
    int const * get_Mode()const{
        return m;
    }
    int set_Freq()const{
        
    }
    int get_Freq()const{
        return max_Freq;
    }
    int set_numModes()const{
        
    }
    int get_numModes()const{
        return num_Modes;
    }

};
class Statistics:Mode {
protected:
  //Stores the sum of the array
    //int average;//Stores the average of the sum of array
    int middle;//Store number of the array
    float median;
   
public:
    int set_Median();
    int get_Median()const{
        return median;
    } 

};

#endif	/* _MODE_H */