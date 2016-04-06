#include <EEPROM.h>

#define WORD_LENGTH 8

const char nonNumeric[WORD_LENGTH] = "example";
const unsigned short initAddress = 10; //from 0 to 512

void setup() {
  Serial.begin(9600);
  //write to EEPROM
  for (int i = 0; i < WORD_LENGTH; i++) {
    //   EEPROM.write(initAddress+i, *(nonNumeric + i));
    EEPROM.write(initAddress + i, nonNumeric[i]);
  }
  //read from EEPROM
  for (int i = 0; i < WORD_LENGTH; i++) {
    Serial.print((char) EEPROM.read(initAddress + i));
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}