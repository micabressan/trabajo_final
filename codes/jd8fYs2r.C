#include <UbidotsMicroESP8266.h>

#define SSID "wauters"
#define PASS "3FCAE37124"

#define TOKEN "A1E-Uw48qeCksVbnRHNpnrIwyQpmJ6REeW"
#define TEMPID "5a2423f9c03f97239ef1d424"

Ubidots client(TOKEN);

void setup() {
  Serial.begin(115200);
  Serial.println("Testing 115200");
  client.setDataSourceLabel("arduino");
  client.wifiConnection(SSID, PASS);
}

void loop() {
  if (Serial.available()) {
    float temp = Serial.read();
    client.add(TEMPID, temp);
    client.sendAll(false);
  }
}