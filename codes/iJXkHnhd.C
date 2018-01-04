/*
  SD card file dump

//https://github.com/Seeed-Studio/Small_ePaper_Shield - biblioteka do epapieru:  #include <ePaper.h> #include "GT20L16_drive.h"


  This example shows how to read a file from the SD card using the
  SD library and send it over the serial port.

  The circuit:
   SD card attached to SPI bus as follows:
 ** MOSI - pin 11
 ** MISO - pin 12
 ** CLK - pin 13
 ** CS - pin 4 (for MKRZero SD: SDCARD_SS_PIN)

  MEGA 2560
  MOSI - Pin 51
  MISO - Pin 50
  Clock - Pin 52
  Chip Select - pin 53

  created  22 December 2010
  by Limor Fried
  modified 9 Apr 2012
  by Tom Igoe

  This example code is in the public domain.

*/

#include <SPI.h>
#include <SD.h>
#include <ePaper.h>
#include "GT20L16_drive.h"

#define SCREEN_SIZE 200                 // choose screen size: 144, 200, 270

#if (SCREEN_SIZE == 144)
#define EPD_SIZE    EPD_1_44

#elif (SCREEN_SIZE == 200)
#define EPD_SIZE    EPD_2_0

#elif (SCREEN_SIZE == 270)
#define EPD_SIZE    EPD_2_7

#else
#error "Unknown EPB size: Change the #define SCREEN_SIZE to a supported value"
#endif


//const int chipSelect = 4;
int pinCS = 53; // Pin 10 on Arduino Uno
String filename = "test.txt";
//String ojapierdole[14] = {"0ahoj", "1szczury", "2ladowe", "3nie", "4lubie", "5was", "6ale", "7was", "8kocham", "9wy", "10misie", "11kolorowe", "12Br.", "13Z."};
String zdzisiowa_tablica_stringow[7];
int numer = 0;
int zadany_numer = 0;
//File plik_z_wynikami;
char CR;
boolean koniec_rekordow = false;
//char tablica_stringow[7][20]; //[# of elements][size of elements];



void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  pinMode(pinCS, OUTPUT);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  Serial.print("Initializing SD card...");
  // see if the card is present and can be initialized:
  //if (!SD.begin(chipSelect)) {
  if (!SD.begin()) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("card initialized.");
  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.



  EPAPER.begin(EPD_SIZE);                             // setup epaper, size
  EPAPER.setDirection(DIRNORMAL);                     // set display direction

  //File dataFile = SD.open(filename);

  eSD.begin(EPD_SIZE);
  GT20L16.begin();
  EPAPER.clear_sd(); //clear display
  //int linia = 13;
  //EPAPER.drawString("HH/MM/SS/DD/MM/YY", 0, 0);*/
  //EPAPER.drawNumber(12345, 0, linia);
  //EPAPER.drawFloat(-1.25, 2, 0, linia+linia);
  EPAPER.display(); // use only once
  delay(100);


}

void card_read_serial()
{
  File dataFile = SD.open(filename);
  // if the file is available, write to it:
  if (dataFile) {
    while (dataFile.available()) {
      Serial.write(dataFile.read());

    }
    dataFile.close();
  }
  // if the file isn't open, pop up an error:
  else {
    Serial.println("error opening " + filename);
  }
}

void card_read_serial2()
{
  //  memset(tablica_stringow, 0, sizeof(tablica_stringow[0][0]) * 7 * 20); //czyszczenie tablicy
  memset(zdzisiowa_tablica_stringow, 0, sizeof(zdzisiowa_tablica_stringow)); //czyszczenie tablicy
  int obecny_rekord = 0;

  File dataFile = SD.open(filename);
  // if the file is available, write to it:
  if (dataFile) {
    //   while (dataFile.available()) {
    while (obecny_rekord < zadany_numer)
    {
      //Serial.write(dataFile.read());
      if (dataFile.available())
      {
        CR =  dataFile.read();
        if (CR == '\n') // 0x0d ->\r 0x0a \n norpead robi w kolejnosc \r\n
        {
          obecny_rekord++;
        }
      }
      else
      {
        if (obecny_rekord < zadany_numer)
        {
          koniec_rekordow = true;
          //zadany_numer = 0; //nie udalo sie nam dojsc do takiej linii a plik sie skonczyl to zacznij od poczatku
        }
        break;
      }

    }
    for (int i = 0; i < 7; i++)
    {
      if (dataFile.available())
      {
        zdzisiowa_tablica_stringow[i] =  dataFile.readStringUntil('\n');
        obecny_rekord++;                                                //dalej zliczamy rekordy
      }
      else
      {
        zdzisiowa_tablica_stringow[i] = "";
        koniec_rekordow = true;
      }
      //Serial.println(i);
      Serial.println(zdzisiowa_tablica_stringow[i]);
    }
    Serial.print(" obecny rekord ");
    Serial.print(obecny_rekord);
    Serial.println();
    Serial.print(" zadany rekord ");
    Serial.print(zadany_numer);
    Serial.println();
    Serial.print("koniec rekordow ");
    Serial.print(koniec_rekordow);
    Serial.println();
    if (obecny_rekord <= zadany_numer)
    {
      koniec_rekordow = true;
      //zadany_numer = 0; //nie udalo sie nam dojsc do takiej linii a plik sie skonczyl to zacznij od poczatku
    }
    //break;
    //wychodzimy z loopa!!!!!!!!!!!!!!!!!!!!!!
    //Serial.write(dataFile.read());
    //CR = dataFile.read();
    {
      /*String line = dataFile.readStringUntil('\n');
        Serial.println(line);*/
    }
    //}
    //    if ( koniec_rekordow == true)
    //    {
    //      zadany_numer = 0;
    //    }
    dataFile.close();
    // }
    // if the file isn't open, pop up an error:
  }
  else {
    Serial.println("error opening " + filename);
  }
}


/*void konwertujDoZdzisiowejTablicyStringow()
  {
  for (int i = 0; i < 7; i++) //wiersze
  {
    String string_buff = String("");
    for (int j = 0; j < 20; j++) //znaki
    {
      string_buff = String(string_buff + tablica_stringow[i][j]);
    }
    zdzisiowa_tablica_stringow[i] = String(string_buff);
  }
  }
*/
/*void wypelnianie_tablicy_char2()
  {
  memset(tablica_stringow, 0, sizeof(tablica_stringow[0][0]) * 7 * 20); //czyszczenie tablicy
  memset(zdzisiowa_tablica_stringow, 0, sizeof(zdzisiowa_tablica_stringow)); //czyszczenie tablicy
  int obecny_rekord = 0;
  File dataFile = SD.open(filename);

  while (dataFile.available()) //read from the file until there's nothing else in it:
  {
    Serial.write(dataFile.read());

    while (obecny_rekord < zadany_numer) //czytamy dopoki nie dojdziemy do naszje linii
    {
      Serial.write(dataFile.read());
      CR =  dataFile.read();
      if (CR == '\n') // 0x0d ->\r 0x0a \n norpead robi w kolejnosc \r\n
      {
        obecny_rekord++;
      }
    }
    Serial.print("Obecny rekord ");
    Serial.print(obecny_rekord);
    Serial.println();
    for (int j = 0; j < 7; j++) //j to numer  wiersza
    {
      int i = 0; // numer znaku w danym wierszy
      CR =  dataFile.read();

      while (CR != '\r')
      {
        tablica_stringow[j][i] = CR;
        i++;

      }
      //tablica_str[j] = str(tablica_stringow[j]);
      Serial.println("nowa linia");
    }
    konwertujDoZdzisiowejTablicyStringow();
  }
  dataFile.close(); //powinnismy miec wypelniona nasza tablice

  }
*/
void piszemy2()
{
  char dupa[20];
  EPAPER.clear_sd();
  int linia = 13; // tyle wynosi minimalny odstem piedzy liniami
  for (int i = 0; i < 7; i++) //max 7 linii na raz mozemy wyswietlic
  {
    if (zdzisiowa_tablica_stringow[i] != "")
   { 
    zdzisiowa_tablica_stringow[i].toCharArray(dupa, 20); //strinigi trzeba zrzucic do tablicy znakow, inaczje nie ruszy
    EPAPER.drawString(dupa, 0, (i * linia));
    EPAPER.drawNumber((zadany_numer + i), 100, (i * linia));
  }
    //numer++;
  }
  /*EPAPER.drawString("HH/MM/SS/DD/MM/YY", 0, 0);
    EPAPER.drawNumber(numer, 0, linia);
    EPAPER.drawFloat(-1.25, 2, 0, linia+linia);*/
  EPAPER.display();

}

void linia()
{
  delay(25);
  EPAPER.clear_sd();
  EPAPER.drawString("numer to", 0, 0);
  EPAPER.drawNumber(zadany_numer, 100, 0);
  EPAPER.display();
  delay(25);
}



void loop() {
  //zadany_numer = 10;
  //wypelnianie_tablicy_char();
  //wypelnianie_tablicy_char2();

  //card_read_serial();
  card_read_serial2();

  if (zdzisiowa_tablica_stringow[0] != "") //w przypadku jak skonczyl sie nam plik to mamy puste tablice bo jestesmy o jeden character przed koncem pliku
  {
    linia();//wyswietla  numer to:
    piszemy2();//wyswietla 7 rekordow
  }
  if ( koniec_rekordow == true)
  {
    zadany_numer = 0;//wracamy do pierwszej linii
    koniec_rekordow = false;
  } else
  {
    zadany_numer = zadany_numer + 7;
  }


}