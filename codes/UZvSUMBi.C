/* Christmas tree decoration - with WS2822 LED RGB light strip
 * You can use either 30 LED/meter or 60 LED/meter strips
 * Constants are set to 43 LEDs (15 trunk + 8+8+4+4+2+2 branches)
 * Measured current consumption for 43 LEDs is about 280-360 mA per current colors and setings
 * (C) 2017, Janos Noll - license: public domain, feel free to reuse
 */

#include <Adafruit_NeoPixel.h>

#define PIN            13 // PIN 13 = D7 on NodeMCU
#define NUMPIXELS      43 // (15+8+8+4+4+2+2) total number of LEDs
#define NUMLIGHTS 20 // how many colored ones at once
#define TRUNKLEDS 15 // number of LEDs on trunk (stay green always)

#define COLORSCALE 8 // 5 bit: 0-31 scaled to x8
#define ANIMPALCOLORS 5
char animPalette[] = { "7C007C05100403E07FE00" };

#define BASERED 0
#define BASEGREEN 60
#define BASEBLUE 0

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

void setPixelAtOffset( int idx, unsigned int color ) {
    int cred = ((color >> 10) & 0x1F) * COLORSCALE;
    int cgreen = ((color >> 5) & 0x1F) * COLORSCALE;
    int cblue = (color & 0x1F) * COLORSCALE;
    pixels.setPixelColor(idx, pixels.Color(cred, cgreen, cblue));
}
unsigned int parseHex2( char* hex ) {
  char buf[5];
  strncpy((char *)&buf, hex, 4); buf[4] = 0;
  return (unsigned int)strtol(buf, 0, 16);
}


int ppos[NUMLIGHTS];
int pidx = 0;

void setup() {
  int c;
  Serial.begin(115200);
  Serial.println("Started");
  pixels.begin(); // This initializes the NeoPixel library.

  for (c = 0; c < NUMPIXELS; c++) {
    pixels.setPixelColor(c, pixels.Color(BASERED, BASEGREEN, BASEBLUE));
  }
  pixels.show();
  for (c = 0; c < NUMLIGHTS; c++) ppos[c] = -1;
}


void loop() {
  if (ppos[pidx] >= 0)
    pixels.setPixelColor(ppos[pidx], pixels.Color(BASERED, BASEGREEN, BASEBLUE));

  int pos;
  while (true) {
    pos = TRUNKLEDS + random(NUMPIXELS - TRUNKLEDS); // skip trunk
    bool found = false;
    for (int c = 0; c < NUMLIGHTS; c++) if (ppos[c] == pos) found = true;
    if (!found) break;
  }
  ppos[pidx] = pos;
  pidx++;
  if (pidx >= NUMLIGHTS) pidx = 0;
  //
  int colSelect = random(ANIMPALCOLORS);
  unsigned int color = parseHex2(&animPalette[4 * colSelect]);
  setPixelAtOffset(pos, color);
  pixels.show();
  
  delay(500);
}