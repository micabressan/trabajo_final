// include the library code:
#include <LiquidCrystal.h>
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// NB: ALL NOTES DEFINED WITH STANDARD ENGLISH NAMES, EXCEPT FROM "A" 
//THAT IS CALLED WITH THE ITALIAN NAME "LA" BECAUSE A0,A1...ARE THE ANALOG PINS ON ARDUINO.
// (Ab IS CALLED Ab AND NOT LAb)
#define  C0 16.35
#define Db0 17.32
#define D0  18.35
#define Eb0 19.45
#define E0  20.60
#define F0  21.83
#define Gb0 23.12
#define G0  24.50
#define Ab0 25.96
#define LA0 27.50
#define Bb0 29.14
#define B0  30.87
#define C1  32.70
#define Db1 34.65
#define D1  36.71
#define Eb1 38.89
#define E1  41.20
#define F1  43.65
#define Gb1 46.25
#define G1  49.00
#define Ab1 51.91
#define LA1 55.00
#define Bb1 58.27
#define B1  61.74
#define C2  65.41
#define Db2 69.30
#define D2  73.42
#define Eb2 77.78
#define E2  82.41
#define F2  87.31
#define Gb2 92.50
#define G2  98.00
#define Ab2 103.83
#define LA2 110.00
#define Bb2 116.54
#define B2  123.47
#define C3  130.81
#define Db3 138.59
#define D3  146.83
#define Eb3 155.56
#define E3  164.81
#define F3  174.61
#define Gb3 185.00
#define G3  196.00
#define Ab3 207.65
#define LA3 220.00
#define Bb3 233.08
#define B3  246.94
#define C4  261.63
#define Cb4  277.18
#define Db4 311.13
#define D4  293.66
#define Eb4 311.13
#define E4  329.63
#define F4  349.23
#define Fb4 369.99
#define Gb4 369.99
#define G4  415.30
#define Ab4 466.316
#define LA4 440.00
#define Bb4 466.16
#define B4  493.88
#define C5  523.25
#define Cb5 554.37
#define Db5 622.25
#define D5  587.33
#define Eb5 622.25
#define E5  659.26
#define F5  698.46
#define Fb5 739.99
#define Gb5 830.61
#define G5  783.99
#define Ab5 830.61
#define LA5 880.00
#define Bb5 932.33
#define B5  987.77
#define C6  1046.50
#define Db6 1108.73
#define D6  1174.66
#define Eb6 1244.51
#define E6  1318.51
#define F6  1396.91
#define Gb6 1479.98
#define G6  1567.98
#define Ab6 1661.22
#define LA6 1760.00
#define Bb6 1864.66
#define B6  1975.53
#define C7  2093.00
#define Db7 2217.46
#define D7  2349.32
#define Eb7 2489.02
#define E7  2637.02
#define F7  2793.83
#define Gb7 2959.96
#define G7  3135.96
#define Ab7 3322.44
#define LA7 3520.01
#define Bb7 3729.31
#define B7  3951.07
#define C8  4186.01
#define Db8 4434.92
#define D8  4698.64
#define Eb8 4978.03
// DURATION OF THE NOTES 
#define BPM 120    //  you can change this value changing all the others
#define H 2*Q //half 2/4
#define Q 60000/BPM //quarter 1/4 
#define E Q/2   //eighth 1/8
#define S Q/4 // sixteenth 1/16
#define W 4*Q // whole 4/4

void setup() {     
pinMode(8, OUTPUT);   
  lcd.begin(16, 2);
  // Print a message to the LCD.
lcd.setCursor(0, 0);
lcd.print("evgeny grinko");
lcd.setCursor(0, 1);
lcd.print("vals");
delay(1000);
lcd.setCursor(0, 1);
}

// the loop routine runs over and over again forever:
void loop() {
    tone(8,Fb5,Q);
    lcd.clear();
    lcd.print("1-F5#");
    delay(1+Q);
    tone(8,Gb5,Q);
    lcd.clear();
    lcd.print("2-G5#");
    delay(1+Q);
    tone(8,E5,H);
    lcd.clear();
    lcd.print("3-E5");
    delay(1+H);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("4-C5#");
    delay(1+Q);
    tone(8,D5,H);
    lcd.clear();
    lcd.print("5-D5");
    delay(1+Q);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("6-C5#");
    delay(1+H);
    tone(8,Fb5,Q);
    lcd.clear();
    lcd.print("7-F5#");
    delay(1+Q);
    tone(8,Gb5,Q);
    lcd.clear();
    lcd.print("8-G5#");
    delay(1+Q);
    tone(8,E5,H);
    lcd.clear();
    lcd.print("9-E5");
    delay(1+H);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("10-C5#");
    delay(1+Q);
    tone(8,D5,H);
    lcd.clear();
    lcd.print("11-D5");
    delay(1+H);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("12-C5#");
    delay(1+Q);
    tone(8,D5,Q);
    lcd.clear();
    lcd.print("13-D5");
    delay(1+Q);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("14-C5#");
    delay(1+Q);
    tone(8,B4,Q);
    lcd.clear();
    lcd.print("15-B4");
    delay(1+Q);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("16-C5#");
    delay(1+Q);
    tone(8,B4,H);
    lcd.clear();
    lcd.print("17-B4");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("18-C5#");
    delay(1+Q);
    tone(8,D5,Q);
    lcd.clear();
    lcd.print("19-D5#");
    delay(1+Q);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("20-C5#");
    delay(1+Q);
    tone(8,B4,Q);
    lcd.clear();
    lcd.print("21-B4");
    delay(1+Q);
    tone(8,Gb4,H);
    lcd.clear();
    lcd.print("22-G4#");
    delay(1+H);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("23-C5#");
    delay(1+Q);
    tone(8,D5,Q);
    lcd.clear();
    lcd.print("24-D5");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("25-C5#");
    delay(1+Q);
    tone(8,B4,Q);
    lcd.clear();
    lcd.print("26-B4#");
    delay(1+Q);
    tone(8,Gb4,H);
    lcd.clear();
    lcd.print("27-G4#");
    delay(1+Q);
    tone(8,B4,H);
    lcd.clear();
    lcd.print("28-B4");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("29-C5#");
    delay(1+Q);
    tone(8,D5,Q);
    lcd.clear();
    lcd.print("30-D5");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("31-C5#");
    delay(1+Q);
    tone(8,B4,Q);
    lcd.clear();
    lcd.print("32-B4");
    delay(1+Q);
    tone(8,Gb4,H);
    lcd.clear();
    lcd.print("33-G4#");
    delay(1+Q);
    tone(8,B4,H);
    lcd.clear();
    lcd.print("34-B4");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("35-C5#");
    delay(1+Q);
    tone(8,D5,Q);
    lcd.clear();
    lcd.print("36-D5");
    delay(1+Q);
    tone(8,Cb5,Q);
    lcd.clear();
    lcd.print("37-C5#");
    delay(1+Q);
    tone(8,B4,Q);
    lcd.clear();
    lcd.print("38-B4");
    delay(1+Q);
    tone(8,Gb4,H);
    lcd.clear();
    lcd.print("39-G4#");
    delay(1+Q);
    tone(8,Cb5,H);
    lcd.clear();
    lcd.print("40-C5#");
    delay(1+Q);
    tone(8,D5,H);
    lcd.clear();
    lcd.print("41-D5");
    delay(1+Q);
    tone(8,Ab4,H);
    lcd.clear();
    lcd.print("42-A4#");
    delay(1+Q);
    tone(8,B4,H);
    lcd.clear();
    lcd.print("43-B4");
    delay(1+Q);
    tone(8,Gb4,W);
    lcd.clear();
    lcd.print("44-G4#");
    delay(1+W);

tone(8,Fb4,Q);
lcd.clear();
lcd.print("45-F4#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("46-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("47-C5#");
delay(1+H);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("48-F4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("49-A4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("50-C5#");
delay(1+H);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("51-F4#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("52-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("53-C5#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("54-F4#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("55-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("56-C5#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("57-F4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("58-A4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("59-C5#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("60-F4#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("61-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("62-C5#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("63-F4#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("64-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("65-C5#");
delay(1+H);
tone(8,D4,Q);
lcd.clear();
lcd.print("66-D4");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("67-F4#");
delay(1+Q);
tone(8,LA4,H);
lcd.clear();
lcd.print("68-A4");
delay(1+Q);
tone(8,D4,Q);
lcd.clear();
lcd.print("69-D4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("70-A4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("71-A4");
delay(1+Q);
tone(8,D4,Q);
lcd.clear();
lcd.print("72-D4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("73-A4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("74-A4");
delay(1+H);
tone(8,B3,Q);
lcd.clear();
lcd.print("75-B3");
delay(1+Q);
tone(8,D4,Q);
lcd.clear();
lcd.print("76-D4");
delay(1+Q);
tone(8,Fb4,H);
lcd.clear();
lcd.print("77-F4#");
delay(1+H);
tone(8,B3,Q);
lcd.clear();
lcd.print("78-B3");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("79-F4#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("80-F4#");
delay(1+Q);
tone(8,B3,Q);
lcd.clear();
lcd.print("81-B3");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("82-F4#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("83-F4#");
delay(1+H);
tone(8,Cb4,Q);
lcd.clear();
lcd.print("84-C4#");
delay(1+Q);
tone(8,F4,Q);
lcd.clear();
lcd.print("85-F4");
delay(1+Q);
tone(8,Gb4,H);
lcd.clear();
lcd.print("86-G4#");
delay(1+H);
tone(8,Cb4,Q);
lcd.clear();
lcd.print("87-C4#");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("88-G4#");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("89-G4#");
delay(1+Q);
tone(8,Cb4,Q);
lcd.clear();
lcd.print("90-C4#");
delay(1+H);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("91-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("92-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("93-D5");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("94-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("95-D5");
delay(1+Q);
tone(8,B4,H);
lcd.clear();
lcd.print("96-B4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("97-B4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("98-D5");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("99-B4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("100-D5");
delay(1+Q);
tone(8,LA4,H);
lcd.clear();
lcd.print("101-A4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("102-A4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("103-D5");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("104-A4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("105-D5");
delay(1+Q);
tone(8,Gb4,H);
lcd.clear();
lcd.print("106-G4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("107-A4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("108-B4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("109-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("110-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("111-D5");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("112-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("113-D5");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("114-B4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("115-B4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("116-D5");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("117-B4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("118-D5");
delay(1+Q);
tone(8,LA4,H);
lcd.clear();
lcd.print("119-A4");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("120-F4#");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("121-G4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("122-A4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("123-B4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("124-A4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("125-C5#");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("126-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("128-D5");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("129-C5#");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("130-D5");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("131-B4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("132-B4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("133-D5");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("134-A4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("135-A4");
delay(1+Q);
tone(8,D5,Q);
lcd.clear();
lcd.print("136-D5");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("137-D5");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("138-G4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("139-A4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("140-B4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("141-B4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("142-C5#");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("143-B4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("144-C5#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("145-A4");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("146-A4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("147-C5#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("148-A4");
delay(1+Q);
tone(8,Cb5,Q);
lcd.clear();
lcd.print("149-C5#");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("150-G4#");
delay(1+Q);
tone(8,Fb4,Q);
lcd.clear();
lcd.print("151-F4#");
delay(1+Q);
tone(8,Gb4,Q);
lcd.clear();
lcd.print("152-G4#");
delay(1+Q);
tone(8,LA4,Q);
lcd.clear();
lcd.print("153-A4");
delay(1+Q);
tone(8,B4,Q);
lcd.clear();
lcd.print("154-B4");
delay(1+Q);
tone(8,LA4,W);
lcd.clear();
lcd.print("155-A4");
delay(1+Q);
    lcd.clear();
lcd.setCursor(0, 0);
lcd.print("evgeny grinko");
lcd.setCursor(0, 1);
lcd.print("vals");
    delay(10000);
}