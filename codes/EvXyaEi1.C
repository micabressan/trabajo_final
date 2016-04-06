
#include <pic16f690.h>

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

// CONFIG
#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA4/OSC2/CLKOUT pin, I/O function on RA5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // MCLR Pin Function Select bit (MCLR pin function is digital input, MCLR internally tied to VDD)
#pragma config CP = OFF         // Code Protection bit (Program memory code protection is disabled)
#pragma config CPD = OFF        // Data Code Protection bit (Data memory code protection is disabled)
#pragma config BOREN = OFF      // Brown-out Reset Selection bits (BOR disabled)
#pragma config IESO = OFF       // Internal External Switchover bit (Internal External Switchover mode is disabled)
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)


void main()
{
    TRISC = 0x00; //Setto tutti i pin della porta C come USCITE. Li imposterei ad 1 se li volessi come ingressi


    /*	Un'altro modo forse un po più intuitivo per settare uno ad uno i vari bit è:

	TRISCbits.TRISC0 = 0; // Output
	TRISCbits.TRISC1 = 1; // Input
	TRISCbits.TRISC2 = 0; // Output
	TRISCbits.TRISC3 = 0; // Output
	TRISCbits.TRISC4 = 0; // Output
	TRISCbits.TRISC5 = 0; // Output
	TRISCbits.TRISC6 = 0; // Output
	TRISCbits.TRISC7 = 0; // Output
    */

    while(1)
    {
        PORTCbits.RC0 = 1; //LED ON
        for (int i=0; i < 100000; i++); //Dovrebbe funzionare come pausa
        PORTCbits.RC0 = 0;//LED OFF
        for (int i=0; i < 100000; i++);
    }

}