// ledit 8-11
int led8 = 8, led9 = 9, led10 = 10, led11 = 11;
// namiskat 2-5
int nappi2 = 2, nappi3 = 3, nappi4 = 4, nappi5 = 5;
//Random
int randomValue=0, pressed=0, previousNum=0, refreshSpeed=100;
void setup() {
  //Ledit OUTPUTteja
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(8, OUTPUT);
  // namiskat INPUTteja
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
  Serial.begin(9600);
  randomSeed(analogRead(A0)*analogRead(A2)/(1+analogRead(A1)));
}

void loop() {
  pressed = 0;
  while(randomValue == previousNum)
  {
    randomValue = random(8,12);
  }
  Serial.println(randomValue);
  previousNum = randomValue;
   switch(randomValue)
   {
     case 8:
       digitalWrite(led8, HIGH);
     break;

     case 9:
       digitalWrite(led9, HIGH);
     break;
     
     case 10:
       digitalWrite(led10, HIGH);
     break;

     case 11:
       digitalWrite(led11, HIGH);
     break;
   }
   
  while(pressed==0)
  {
    if(digitalRead(2)==1||digitalRead(3)==1||digitalRead(4)==1||digitalRead(5)==1)
    {
      for(int i=8;i<=11;i++)
      {
        digitalWrite(i,LOW);
        pressed=1;
        delay(refreshSpeed);
      }
    }
  }
}