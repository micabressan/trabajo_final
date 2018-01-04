#define OnOffPin 50  //definicje pinów przycisków
#define ModePin 25
#define RecordPin 40
#define ZoomPlusPin 20
#define ZoomNegativePin 15
 
#define OnOffCam 22  //definicje pinów kamery
#define ModeCam 23
#define RecordCam 24
#define ZoomPlusCam 19
#define ZoomNegativeCam 16
 
 
int ModeType = 0;
int ifON = 0;
int ifRec = 0;
 
 
int checkPin(){
 
  if(check(OnOffPin)==1){
    return 1;
  }else{
    if(check(ModePin)==1){
    return 2;
  }else{
    if(check(RecordPin)==1){
    return 3;
  }else{
    return 0;
  }
  }
  }
 
 
}

void zoomCheck(int mode){
  if(mode == 0 || mode == 1){
    if(digitalRead(ZoomPlusPin) == LOW){
      delay(70);
      if(digitalRead(ZoomPlusPin) == LOW){
      zoomPut(1);
      }
    }
    
      if(digitalRead(ZoomNegativePin) == LOW){
      delay(70);
      if(digitalRead(ZoomNegativePin) == LOW){
      zoomPut(2);
      }
    }
    
      
      if(digitalRead(ZoomNegativePin) == HIGH && digitalRead(ZoomPlusPin) == HIGH){
      delay(70);
      if(digitalRead(ZoomNegativePin) == HIGH && digitalRead(ZoomPlusPin) == HIGH){
      zoomPut(0);
      }
    }
  }
}

int zoomPut(int value){
  if(value == 2){
    digitalWrite(ZoomPlusCam, LOW);
    digitalWrite(ZoomNegativeCam, HIGH);
    Serial.println("Zoom -");
  }
  if(value == 1){
    digitalWrite(ZoomNegativeCam, LOW);
    digitalWrite(ZoomPlusCam, HIGH);
    Serial.println("Zoom +");
  }else{
    if(value == 0){
      digitalWrite(ZoomPlusCam, LOW);
      digitalWrite(ZoomNegativeCam, LOW);
    }
  }  
  
} 
//funkcja sprawdzająca czy na pinie jest stan wysoki i zwracająca  wartość po puszczeniu przycisku, dodatkowo uwzględnia drgania styków
int check(int pin){
  if(digitalRead(pin) == LOW){
    delay(70);
    if(digitalRead(pin) == LOW){
      while(digitalRead(pin) == LOW){
        delay(1);
      }
     
      return 1;
    }else{
      return 0;
    }
   
  }else{
    return 0;
  }
 
}
 
//funkcja zapisująca do kamery
int saveCam(int pinCam){
    switch (pinCam) {
    case 1:
      ModeType = 0;
      digitalWrite(OnOffCam, HIGH);
      delay(250);
      digitalWrite(OnOffCam, LOW);
      if(ifON == 0){
        ifON = 1;
        Serial.println("Wlaczono kamere");
      }else{
        ifON = 0;
        Serial.println("Wylaczono kamere");
      }    
      break;
    case 2:
      digitalWrite(ModeCam, HIGH);
      delay(250);
      digitalWrite(ModeCam, LOW);
      if(ModeType<2){
        ModeType++;
      }else{
        ModeType = 0;
      }
     
      if(ModeType==0)
        Serial.println("Tryb aparat");
       
       if(ModeType==1)
        Serial.println("Tryb kamera");
       
       if(ModeType==2)
        Serial.println("Tryb dyktafon");
      break;
    case 3:
      digitalWrite(RecordCam, HIGH);
      delay(250);
      digitalWrite(RecordCam, LOW);
        if(ifRec==0 && ModeType!=0){
          ifRec=1;
          Serial.println("Rozpoczeto nagrywanie");
        }else{
         if(ifRec==1 && ModeType!=0){
          ifRec=0;
          Serial.println("Wylaczono nagrywanie");
        }else{
          Serial.println("Zrobiono zdjecie");
        }
        }
 
    break;
 
  }
 
}
 
 
 
void setup() {
  Serial.begin(9600);
  pinMode(OnOffPin, INPUT_PULLUP); //domyślnie wartosć HIGHT bo piny podciągnięte do VCC
  pinMode(ModePin, INPUT_PULLUP);
  pinMode(RecordPin, INPUT_PULLUP);
  pinMode(ZoomNegativePin, INPUT_PULLUP);
  pinMode(ZoomPlusPin, INPUT_PULLUP);
 
  pinMode(OnOffCam, OUTPUT);
  pinMode(ModeCam, OUTPUT);
  pinMode(RecordCam, OUTPUT);
  pinMode(ZoomNegativeCam, OUTPUT);
  pinMode(ZoomPlusCam, OUTPUT);
  Serial.println("Witaj w sterowaniu kamera!");
}
 
 
 
//właściwa funkcja programu
void loop() {
   saveCam(checkPin());
   zoomCheck(ModeType);
   
 
}