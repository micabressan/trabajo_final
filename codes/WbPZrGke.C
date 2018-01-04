/*
 * Shift_routines.h
 *
 * Created: 12/14/2017 11:28:00 PM
 *  Author: 
 */ 


#ifndef SHIFT-ROUTINES_H_
#define SHIFT-ROUTINES_H_


#include <avr/io.h>
#include <util/delay.h>

/***************************************

Configure Connections

****************************************/

#define HC595_PORT   PORTB
#define HC595_DDR    DDRB

#define HC595_DS_POS PB5      //Data pin (DS) pin location

#define HC595_SH_CP_POS PB4      //Shift Clock (SH_CP) pin location 
#define HC595_ST_CP_POS PB3      //Store Clock (ST_CP) pin location

/***************************************
Configure Connections ***ENDS***
****************************************/

//Initialize HC595 System

void HC595Init()
{
   //Make the Data(DS), Shift clock (SH_CP), Store Clock (ST_CP) lines output
   HC595_DDR|=((1<<HC595_SH_CP_POS)|(1<<HC595_ST_CP_POS)|(1<<HC595_DS_POS));
}


//Low level macros to change data (DS)lines
#define HC595DataHigh() (HC595_PORT|=(1<<HC595_DS_POS))

#define HC595DataLow() (HC595_PORT&=(~(1<<HC595_DS_POS)))

//Sends a clock pulse on SH_CP line
void HC595Pulse()
{
   //Pulse the Shift Clock

   HC595_PORT|=(1<<HC595_SH_CP_POS);//HIGH

   HC595_PORT&=(~(1<<HC595_SH_CP_POS));//LOW

}

//Sends a clock pulse on ST_CP line
void HC595Latch()
{
   //Pulse the Store Clock

   HC595_PORT|=(1<<HC595_ST_CP_POS);//HIGH
   _delay_loop_1(1);

   HC595_PORT&=(~(1<<HC595_ST_CP_POS));//LOW
   _delay_loop_1(1);
}


/*

Main High level function to write a single byte to
Output shift register 74HC595. 

Arguments:
   single byte to write to the 74HC595 IC

Returns:
   NONE

Description:
   The byte is serially transfered to 74HC595
   and then latched. The byte is then available on
   output line Q0 to Q7 of the HC595 IC.

*/
void HC595Write(uint8_t data)
{
   //Send each 8 bits serially

   //Order is MSB first
   for(uint8_t i=0;i<8;i++)
   {
      //Output the data on DS line according to the
      //Value of MSB
      if(data & 0b10000000)
      {
         //MSB is 1 so output high

         HC595DataHigh();
      }
      else
      {
         //MSB is 0 so output high
         HC595DataLow();
      }

      HC595Pulse();  //Pulse the Clock line
      data=data<<1;  //Now bring next bit at MSB position

   }

   //Now all 8 bits have been transferred to shift register
   //Move them to output latch at one
   HC595Latch();
}

/*

Simple Delay function approx 0.5 seconds

*/

void Wait()
{
   for(uint8_t i=0;i<30;i++)
   {
      _delay_loop_2(0);
   }
}

// void main()
// {
// 
//    HC595Init();
// 
//    while(1)
//    {
//       for(uint8_t i=0;i<8;i++)
//       {
//          HC595Write(led_pattern[i]);   //Write the data to HC595
//          Wait();                 //Wait 
// 
//       }
//    }
// 
// 
// }


#endif /* SHIFT-ROUTINES_H_ */