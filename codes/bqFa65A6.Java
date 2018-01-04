/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chp8challenge5month;
import java.util.Scanner; 
/**
 *
 * @author StoneBone 
 */
public class Month 
{
    //Field (holds the number of the month) 
    private int monthNumber; 
    
   //Don't know if needs these fields 
    private String monthName; // need? 
    private Month monthToEqual; //needs value? 
    
    
    //no-arg constructor 
    public Month()
    {
        monthNumber = 1;
    }
    
    //Constructor accepts number of month as argument //don;t know if need to do more
    public Month(int theNumber)
    {    
        monthNumber = theNumber;
        
        if (monthNumber < 1 || monthNumber > 12) //Hopefully is correct 
                monthNumber = 1;
    }
    
    //Constructor accepts name of month as arugment 
    public Month (String theMonth) //modify to accept different months (!!!!!)
    {
       //trying this, don't know if right 
       
       if (theMonth == "January")
           monthNumber = 1;
       else if (theMonth == "February")
               monthNumber = 2;
       else if (theMonth == "March")
           monthNumber = 3; 
       else if (theMonth == "April")
           monthNumber = 4;
       else if (theMonth == "May")
           monthNumber = 5;
       else if (theMonth == "June")
           monthNumber = 6; 
       else if (theMonth == "July")
           monthNumber = 7;
       else if (theMonth == "August")
           monthNumber = 8;
       else if (theMonth == "September")
           monthNumber = 9;
       else if (theMonth == "October")
           monthNumber = 10;
       else if (theMonth == "November")
           monthNumber = 11;
       else if (theMonth == "December")
           monthNumber = 12;
    
    }
    
    
    
    public void setMonthNumber(int setMonth)
    {
        monthNumber = setMonth; //hopefully this is right 
        
        if (monthNumber < 1 || monthNumber > 12)
             monthNumber = 1;
    }
    
    
    public int getMonthNumber()
    {   
      return monthNumber; 
    }     
                  
    
    public String getMonthName() //don't know what issue is 
    {
      
     //Don't know if sohuld be case 
    //These return the name of the month //It should be the strings themselves
      if (monthNumber == 1)
         return "January";
      else if (monthNumber == 2)
          return "February";
      else if (monthNumber == 3)
          return "March";
      else if (monthNumber == 4 )
        return "April";
      else if (monthNumber == 5)
          return "May";
      else if (monthNumber == 6)
          return "June";
      else if (monthNumber == 7)
          return "July";
      else if (monthNumber == 8)
          return "August";
      else if (monthNumber == 9)
          return "September";
      else if (monthNumber == 10)
          return "October";
      else if (monthNumber == 11)
          return "November";
      else if (monthNumber == 12)
          return "December";
      else
          return "Ivalid number."; //Don't know if it should be somehting else 
                    
    } 

    
    public String toString()
    {
        String gettingMonth = monthName; //proabbly needs a string in it right? 
                //need to return same value as getMonthName //field? 
                
        return gettingMonth;
    }       
    
    public boolean equals (Month compareMonth)//needs Month object as argument 
    {
        //For determining if this method is true or false 
        boolean status;
        
       if(compareMonth.equals(monthToEqual))
          status = true;
       else 
           status = false;
        
     return status;
    }
    
    
    public boolean greaterThan(Month greaterThanMonth)
    {
        boolean status;
        if (monthNumber > greaterThanMonth.monthNumber) 
            status = true;
        else
            status = false;
        
        return status;
    }
    
    public boolean lessThan (Month lessThanMonth)
    {
        boolean status;
        
        if (monthNumber < lessThanMonth.monthNumber)
            status = true;
        else 
            status = false;
        
        return status; 
    }
    
}