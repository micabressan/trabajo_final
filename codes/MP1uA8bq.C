#include <SoftwareSerial.h>

SoftwareSerial mySerial(10,11); // RX, TX

int fils_1;
int fils_2;
int fils_3;
int fils_4;
int val=0;

void setup() {

  Serial.begin(9600);
  pinMode(0, INPUT);
  pinMode(1, OUTPUT);
  for(int i=2 ; i<=5 ; i++)
  {
    pinMode(i, OUTPUT);
    digitalWrite(i, HIGH);
   }
    // Open serial communications and wait for port to open:
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }// set the data rate for the SoftwareSerial port
  //mySerial.begin(9600);
  //mySerial.println(3);
}


void loop() {
  //Serial.println( digitalRead(5) );
    if(analogRead(A5)> 1020)
  { 
    fils_1 = 1;
  }
  else{
    fils_1 = 0;
  }
    if(analogRead(A4)> 1020)
  { 
    fils_2 = 2;
  }
  else{
    fils_2 = 0;
  }
    if(analogRead(A3)> 1020)
  { 
    fils_3 = 4;
  }
  else{
    fils_3 = 0;
  }
    if(analogRead(A2)> 1020)
  { 
    fils_4 = 8;
  }
  else{
    fils_4 = 0;
  }
  val=fils_1+fils_2+fils_3+fils_4;
   //Serial.println(fils_1);
   //Serial.println(fils_2);
   //Serial.println(fils_3);
   //Serial.println(fils_4);
   Serial.write(val);
   delay (10);
   //Serial.write(val);
   
   // run over and over
 
 }