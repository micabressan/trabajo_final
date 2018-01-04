#include <Arduino.h>
#include "EEPROMAnything.h"

// 739ce2d6-2eed-4922-8252-993c6186c603

String UUID;
String newUUID;
uint8_t parsedUUID[16];
uint8_t eeUUID[16];


void parseUUID(String UUID, uint8_t parsedUUID[16]) {
    for (int i = 0; i < 32; i+=2) {
        parsedUUID[(i/2)] = strtoul(UUID.substring(i, (i+2)).c_str(), nullptr, 16);
    }
}

void UUIDToString(uint8_t parsedUUID[], String &UUID_param) {
    char buffer[2];
    UUID_param = "";
    Serial.println("-Tout va bien-");
    for (int i = 0; i < 16; i++) {
        Serial.println("-Tout va bien 2-");        
        sprintf(buffer, "%.2X", parsedUUID[i]);
        Serial.println("-Tout va bien 3-");        
        if ((i == 4) || (i == 6) || (i == 8) || (i == 10)) {
            UUID_param += '-';
        }
        UUID_param += buffer;
    }
    Serial.println("-Done converting -");    
    Serial.println("Lets moove on !");
}


void setup() {
    // put your setup code here, to run once:
    pinMode(LED_BUILTIN, OUTPUT);
    Serial.begin(9600);
    while (!Serial) {
        ; // wait for serial port to connect. Needed for native USB port only
    }
}

void loop() {
    // put your main code here, to run repeatedly:
    Serial.println("Hello you :)");
    Serial.println("Size of eeUUID: " + String(sizeof(eeUUID)));
    EEPROM_readAnything(0, eeUUID);
    //for (int i = 0; i < 16; i++) {
    //  Serial.println(String(i) + String(" : ") + String(currentUUID[i]));
    //}
    Serial.println("Enter an UUID:");
    while (newUUID.length() != 32) {
        while(!Serial.available()) {};
        newUUID = Serial.readString();
        Serial.println("Received: " + newUUID);
        newUUID.replace("-", "");
        if (newUUID.length() != 32) {
            Serial.println("Incorrect size. Enter an UUID:");            
        }
    }
    Serial.println("Toto");
    parseUUID(newUUID, parsedUUID);
    Serial.println("First element: " + String(parsedUUID[0]));
    UUIDToString(parsedUUID, newUUID);
    Serial.println("UUDI: ");
    Serial.println(newUUID);
    
    UUIDToString(eeUUID, UUID);
    Serial.println("EEPROM UUID: " + UUID);

    EEPROM_writeAnything(0, parsedUUID);

    UUID = "";
    newUUID = "";
}