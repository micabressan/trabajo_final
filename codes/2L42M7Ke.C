/*
 * uhraufzug.c
 *
 *  Created on: 16.12.2017
 *      Author: Nina
 */


#include <avr/io.h>
#include <stdio.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "uart.h"

int main()
{
	//Setup

	uart_stdio();
	cli(); //Timer/Interrups stoppen

	//Ausgänge initialisieren, Register A, weil B für PWM benötigt wird
	PORTA &= ~(1<<PA0);		/*magnetlinks (hier ist untere Endlage angebracht, weil dieses Gewicht schneller abläuft)*/
	PORTA &= ~(1<<PA1);		//magnetrechts
	PORTB &= ~(1<<PB5);		//=OC1A


	//Ports als Ausgänge
	DDRA |= (1<<PA0);
	DDRA |= (1<<PA1);
	DDRB |= (1<<PB5);

	//Pins als Eingänge
	DDRA &= ~(1<<PA4);		//endlageunten
	DDRA &= ~(1<<PA5);		//endlageoben

	//PORTA |= (1<<PA4); //Pull-Up, sonst Pull-Down

	/*
	// Timer 1 konfigurieren (16MHz)
	TCCR1A = (1<<WGM12); 					//CTC Modus (Clear Timer on Compare Match)
	TCCR1A |= ((1<<CS10) | (1<<CS11)) ; 	//Prescaler 64		//(16000000/64)/9000=27,78=28
	OCR1A = 28/2-1;							//Compare Match bei 13, weil 9kHz, also high und low müssen in 9kHz rein, deswegen durch 2 teilen
	TCCR1A = (1<<COM1A0);						//Das Signal am Pin OC1A soll invertiert werden wenn Compare Match (Toggle).

	// Compare Interrupt erlauben
	TIMSK1 |= (1<<OCIE1A);

	 */
	printf("Initialisiert");

_delay_ms(1000);

	while(!(PINA & (1<<PA4))) 	//wenn untere Endlage berührt ist
	{
		_delay_ms(50);
	}
	printf("Eingang high");

	PORTA |= (1<<PA0);		//dann linken Magnet anziehen
	_delay_ms(2000);		//warten
	sei();			//Timer/Interrupts starten --> Takt geht an Motor


	while(!(PINA & (1<<PA5))) 	//wenn untere Endlage berührt ist
	{
		_delay_ms(50);
	}
	//Schleife beenden wenn obere Endlage erreicht
	cli();		//Motor stoppen
	PORTA &= ~(1<<PA0);		//linken Magnet lösen


	/*
		//hier while einfügen, Bedingung: 5° zurückdrehen
		//Signalausgabe an Motor links

		PORTA |= (1<<PA1);		//dann rechten Magnet anziehen
		//while, Bedingung: PINA & (1<<PA5)	//bis obere Endlage berührt
		//Signalausgabe an Motor (rechts drehen)
		PORTA &= ~(1<<PA1);		//rechten Magnet lösen
		//while, Bedingung: 5° zurückdrehen
		//Signalausgabe an Motor (links drehen)
	 *
	 */


	return 0;
}