int c = 1;
int ledRed =4,
    ledBlue = 5,
    ledGreen = 6;

void setLED(int led) {
  /*
  // led = HIGH
  // if(led != ledRed)  ledRed = LOW
  // if(led != ledBlue)  ledBlue = LOW
  // if(led != ledGreen)  ledGreen = LOW
  */
}

int main() {
  if(c % 1 == 0) {
    setLED(ledRed);
  } else if(c % 2 == 0) {
    setLED(ledBlue);
  } else if(c % 4 == 0) {
    setLED(ledGreen)
  }
}