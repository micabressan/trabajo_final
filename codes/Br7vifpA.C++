#include <Servo.h> 

const int fuoco = 5;          
const int triggerPort = 9;
const int echoPort = 8;
const int cometa = 10;
const int servopin = 11;

int brightness = 0;    
int fadeAmount = 5; 
int fadePos = 5;

int maxDist = 100; //distanza massima in cm per considerare una persona vicina
//NOTA: resistenza da 680 Ohm su ogni pin del segnale dei mosfet

Servo myservo;  
int pos = 0;    
 
void setup() {
	//myservo.attach(servopin); 
	pinMode(triggerPort, OUTPUT);
	pinMode(echoPort, INPUT);
	pinMode(cometa, OUTPUT);
	pinMode(fuoco, OUTPUT);
}
 
void loop() {
	digitalWrite( triggerPort, LOW );
	digitalWrite( triggerPort, HIGH );
	delayMicroseconds( 10 );
	digitalWrite( triggerPort, LOW );
 
	long durata = pulseIn( echoPort, HIGH );
	long distanza = 0.034 * durata / 2;
 
	//dopo 38ms è fuori dalla portata del sensore
	if( durata > 38000 || distanza > maxDist){
		analogWrite(cometa, 1);    
	} else{ 
		int brightnessCometa = 255 - map(distanza, 0, maxDist, 1, 255);
		analogWrite(cometa, brightnessCometa);    
	}
 
	analogWrite(fuoco, brightness);    

	brightness = brightness + fadeAmount;

	if (brightness == 0 || brightness == 255) {
		fadeAmount = -fadeAmount ; 
	}     

	myservo.write(pos);     
	pos = pos + fadePos;
	if (pos == 0 || pos == 180) {
    	fadePos = -fadePos ; 
	}     

	delay(100);
}