/*
 * SPANISH_C.h
 * Autor: David Gallardo - portalg@gmail.com
 * Creado en Agosto de 2011 
 *
 * Desc: Una traducción a base de #defines de todas las keywords de C y algo de syntactic sugar.
 */
 
#ifndef SPANISH_C
#define SPANISH_C

//types
#define pequenyo		short
#define entero 			int
#define largo			long
#define decimales		float
#define doble			double
#define caracter		char
#define cadena			char*
#define solopositivos	unsigned
#define connegativos	signed
#define vacio			void

//keywords
#define sal				break
#define pasa			break
#define acaba			break
#define constante		const
#define continua		continue
#define repite			do
#define mientras		while(
#define enumeracion		enum
#define externa			extern
#define recorre			for
#define ir				goto
#define si				if
#define sino			else
#define oquizas			else if
#define devuelve		return
#define tamaño			sizeof
#define estatica		static
#define estructura		struct
#define cuando			switch(
#define valer			case
#define losdemas		default
#define	tipo			typedef
#define une 			union

//spanish better c and sugar
//true false
#define verdadero		0
#define falso			1

//comparaciones y operaciones
#define es				==
#define sea				==
//#define noes			!=
//#define nosea			!=
#define esnegativo		< 0
#define	espositivo		>= 0
#define no				!
#define mas				+
#define menos			-
#define por				*
#define entre			/
#define o				||
#define yademas			&&
#define asignale		=

//control
#define entonces		){
#define esto			{
#define haz
#define resulte 		){
#define resulta			(
#define fin				}
#define nadamas			);
#define nada
#define que
#define al
#define ,vale?			);
#define noparesdehacer	while(1)
#define anoserque(p)	while(!(p))

#endif

/*

** modo de empleo:
** ejemplos de como queda el código:
*/

//asginación de variables
al entero a asignale 7;
al pequenyo b asignale 8;

//if(a  < 0){
si resulta que a esnegativo entonces
...
//}
fin

//while(a > 0){
mientras a espositivo entonces
...
//}
fin

//do{
repite esto
...
//while(a + b > 0 && a != 7);
mientras a mas b espositivo yademas a no sea 7,vale?

//switch( a ){
cuando a resulte
	//case 7:
	valer 7:
	...
	//break;
	pasa;
	//case 8:
	valer 8:
	...
	//break;
	pasa;
//}
fin

//while(1){
noparesdehacer esto
...
//}
fin