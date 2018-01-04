#include <avr/io.h> //ahhoz, hogy használni tudd az IO portokat és regisztereket
#include <avr/interrupt.h> //ahhoz, hogy a megszakításokat is kezelni tudd

volatile int olvas=0, seged=0, i=0, kijelzo = 0, it0=0; 
int fgv1(void); 
int fgv2(void);
int fgv3(void);
int fgv4(void);
int fgv5(void);

int main() 
{  
	 DDRA = 0xFF;								// 7-szegmenses kijelző portja  
	 DDRB = DDRD = 0xF0;					 // LED  portjai  
	 DDRG = 0x00;						// GOMB portja  
	
	 TCCR0 = 5;	//a timer0-t overflow interruptra és CTC modra allitja megfelelo orajel eloosztassal							   
	 TIMSK = 1; //engedelyezi a timer0 overflow megszakitast
	 
	 sei(); //globalisan engedelyezi a megszakitasokat

	 while(1) //Ez itt a foprogram vegtelen ciklusa
	 {}; 
}
		
ISR(TIMER0_OVF_vect) //A Timer0 overflow megszakitast kiszolgalo fuggveny
{	
	//A gombokat leolvaso, majd feltetesen utasitast vegrehajto kodreszlet
	switch (PING & 0x1F) //lemaszkoljuk, amire nem vagyunk kivancsiak a kiertekelesnel
	{
		case 0x01:
		{
			kijelzo = fgv1();
			i = 1;	
			break;
		}
		case 0x02:
		{
			kijelzo = fgv2();
			i = 2;
			break;
		}
		case 0x04:
		{
			kijelzo = fgv3();
			i = 3;
			break;
		}		
		case 0x08:
		{
			kijelzo = fgv4();
			i = 4;
			break;
		}
	}

	PORTD=i;  // i értékeket kiírja LED-ekre   
	PORTB=i<<4;
		
	//Alább egy ewgyszeu allapotgep van megvalositva a kijelzo hajtasahoz
	it0++; //Ez az allapotgep allpotvaltozoja
	switch(it0)			
	{    
		case 1: // egyesek
		{
			PORTA = (1 << 7) + (kijelzo % 10);
			break;     
		}
		case 2: // t�zesek 
		{
			PORTA = 0b10010000 + (kijelzo / 10 % 10); 
			break;     
		}
		case 3: // sz�zasok
		{
			PORTA = 0b10100000 + (kijelzo / 100 % 10); 
			break;      
		}
		case 4:  // ezresek 
		{
			PORTA = 0b10110000 + (kijelzo / 1000 % 10); 
			it0 = 0; //az utolso allapotban visszaallitjuk az allapotvaltozot a kezdoertekre a kovetkezo futashoz  
			break; 
		}
	};	
}

int fgv1()
{
	int i=0,db=0;
	for(i=100;i<151;i++)
	{
		if((i&0b11000)==0b000000)
		{
			db++;
		}
	}
	return db;
}

volatile int fgv2(void) 
{   
	int i = 0, db = 0, seged1 = 0, seged2 = 0;
	for(i = 100; i < 151; i++)
	{
			 seged1 = seged2 = 0;
			 if((i & 0b1) == 0b1) {seged1++;}
			 else{seged2++;}
			 if((i&0b10)==0b10){seged1++;}
			 else{seged2++;}
			 if((i&0b100)==0b100){seged1++;}
			 else{seged2++;}
			 if((i&0b1000)==0b0100){seged1++;}
			 else{seged2++;}
			 if((i&0b10000)==0b10000){seged1++;}
			 else{seged2++;}
			 if((i&0b100000)==0b100000){seged1++;}
			 else{seged2++;}
			 if((i&0b1000000)==0b1000000){seged1++;}
			 else{seged2++;}
			 if((i&0b10000000)==0b10000000){seged1++;}
			 else{seged2++;}
			 if(seged1>seged2){db++;}
	}
		
	return db; 
};

int fgv3(void)
{ 
	int a=100, b=25, c=0;  // fgv2-�n bel�l l�that� lok�lis v�ltoz�k  
	c=a-b; 
			 
	return c; 
};
		 
int fgv4(void)
{
	return 0;
};