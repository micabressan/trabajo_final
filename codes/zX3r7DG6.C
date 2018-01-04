#include <Timers.h>


int puls[2048];    //tablica z probkami sygnalu
int wartMax=0; //do badania lokalnych wart. max 

  
Timer pomiarPulsu;

void setup() {
Serial.begin(9600);
delay(5000);  //na ustabilizowanie czujnika przed pomiarem

pomiarPulsu.begin(6);  //timer na 6 ms
}



void loop() {
//pobranie wyników
  for(int i=0; i<2048; i++)
  {
    if(pomiarPulsu.available());
    {
         puls[i]=analogRead(0);
         pomiarPulsu.restart();
    }
  }


  //wydruk wyników
for(int i=0; i<2048; i++)
    {
        Serial.println(puls[i]);
    }


//tutaj filtracja ktorej nie mam


//szukanie lokalnych wart. max

for(int i=0; i<2048; i++)
{
 // wartMax=max(
}

}