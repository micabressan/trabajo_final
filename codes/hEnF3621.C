#include<stdio.h>
#include<conio.h>
#include<stdlib.h> 

int luaspsg(); //luaspersegi
int luassgt(); //luas segitiga
int luaslinkaran(); //luas lingkaran
int luasjargen(); //luas jajar genjang
int luasbelketupat(); //luas belah ketupat
int luaslayang(); //luas layang-layang
int luaspp(); //luas persegi panjang
int luastrap(); //Luas trapesium
int kelpsg(); //Keliling persegi
int kelsgt(); //Keliling segitiga
int keling(); //Keliling lingkaran
int keljargen(); //Keliling jajar genjang
int kelbelketupat(); //Keliling belah ketupat
int kelayang(); //Keliling layang-layang
int kelpp(); //Keliling persegi panjang
int keltrap(); //Keliling trapesium
int luas(); //Luas
int keliling(); //keliling

main (){

printf("\n\n");
printf("\t\tMenghitung Luas & Keliling Bangun Datar\n\n");
printf("\t\t\tCreate by Paska404\n\n");
printf("\t\t---------------------------------------");
printf("\n\n");
printf("\t\t\t\tMenu\n\n");

int menuawal;
printf("\t\t\t1.Luas\n");
printf("\t\t\t2.Keliling\n");
scanf("%d" , &menuawal);
system("cls"); 


switch(menuawal){
case 1: luas(); break;
case 2: keliling(); break;
case 8: break;
default:printf("\t\t\tSilahkan pilih salah satu\n\n"); 

}

int luas;
printf("\t\t\tLuas Bangun Datar\n\n");
printf("\t\t\t1.Persegi\n");
printf("\t\t\t2.Segitiga\n");
printf("\t\t\t3.Lingkaran\n");
printf("\t\t\t4.Jajar Genjang\n");
printf("\t\t\t5.Belah Ketupat\n");
printf("\t\t\t6.Layang-layang\n");
printf("\t\t\t7.Persegi Panjang\n");
printf("\n");
printf("\t\t\tMasukan Pilihan : ");
scanf("%d" , &luas);
system("cls"); 

switch(luas){
case 1: luaspsg(); break;
case 2: luassgt(); break;
case 3: luaslinkaran(); break;
case 4: luasjargen(); break;
case 5: luasbelketupat(); break;
case 6: luaslayang(); break;
case 7: luaspp(); break;
case 8: break;
default:printf("\t\t\tSilahkan pilih salah satu\n\n"); 

}

int keliling;
printf("\t\t\tKeliling Bangun Datar\n\n");
printf("\t\t\t1.Persegi\n");
printf("\t\t\t2.Segitiga\n");
printf("\t\t\t3.Lingkaran\n");
printf("\t\t\t4.Jajar Genjang\n");
printf("\t\t\t5.Belah Ketupat\n");
printf("\t\t\t6.Layang-layang\n");
printf("\t\t\t7.Persegi Panjang\n");
printf("\n");
printf("\t\t\tMasukan Pilihan : ");
scanf("%d" , &keliling);
system("cls"); 

switch(keliling){
case 1: kelpsg(); break;
case 2: kelsgt(); break;
case 3: keling(); break;
case 4: keljargen(); break;
case 5: kelbelketupat(); break;
case 6: kelayang(); break;
case 7: kelpp(); break;
case 8: break;
default:printf("\t\t\tSilahkan pilih salah satu\n\n"); 

}

getch();
return 0;

}


int luaspsg(){

	//Luas Persegi
	int s1, s2;	
	printf("\n");
	printf("\t\t\tLuas Persegi\n\n");
	printf("\t\tMasukan sisi a : ");
	scanf("%i" , &s1);
	printf("\n");
	printf("\t\tMasukan sisi b : ");
	scanf("%i" , &s2);
	//Rumus 
	printf("\n");
	printf("\t\tHasilnya : ");
	printf("%i" , s1*s2);
	printf("\n");
}


int luassgt(){

	//Luas Segitiga
	int al, t;
	printf("\n");
	printf("\t\t\tLuas Segitiga\n\n");
	printf("\t\tMasukan alas  : ");
	scanf("%i" , &al);
	printf("\n");
	printf("\t\tMasukan tinggi : ");
	scanf("%i" , &t);
	printf("\n");
	//Rumus  
	printf("\t\tHasilnya : ");
	printf("%i" , al*t/2);
	printf("\n");
}
	
int luaslinkaran(){

	//Luas lingkaran
	float r;
	printf("\n");
	printf("\n\n");
	printf("\t\t\tLuas Lingkaran\n\n");
	printf("\t\tMasukan jari-jari	: ");
	scanf("%f" , &r);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%f" , 3,14*r*r);
	printf("\n");
}

int luasjargen(){

	//Luas jajar genjang
	int alas, t;
	printf("\n");
	printf("\n\n");
	printf("\t\t\tLuas Jajar Genjang\n\n");
	printf("\t\tMasukan alas : ");
	scanf("%i" , &alas);
	printf("\n");
	printf("\t\tMasukan tinggi : ");
	scanf("%i" , &t);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , alas*t);
	printf("\n");
}

int luasbelketupat(){

	//Luas belah ketupat
	int de1, de2;
	printf("\n");
	printf("\t\t\tLuas Belah Ketupat\n\n");
	printf("\t\tMasukan diagonal 1 : ");
	scanf("%i" , &de1);
	printf("\n");
	printf("\t\tMasukan diiagonal 2 : ");
	scanf("%i" , &de2);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , (de1*de2)/2);
	printf("\n");
}

int luaslayang(){

	//Luas layang-layang
	int d1, d2;
	printf("\n");
	printf("\t\t\tLuas Layang-Layang\n\n");
	printf("\t\tMasukan diagonal 1 : ");
	scanf("%i" , &d1);
	printf("\n");
	printf("\t\tMasukan diagonal 2 : ");
	scanf("%i" , &d2);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , (d1*d2)/2);
	printf("\n");
}

int luaspp(){

	//Luas Persegi Panjang
	int p, l;
	printf("\n");
	printf("\t\t\tLuas Persegi Panjang\n\n");
	printf("\t\tMasukan panjang	: ");
	scanf("%i" , &p);
	printf("\n");
	printf("\t\tMasukan lebar	: ");
	scanf("%i" , &l);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , p*l);
	printf("\n");
}

int luastrap(){
	//Luas Trapesium
	int alass, sisice, tinggii; 
	printf("\n");
	printf("\t\t\tLuas Trapesium\n\n");
	printf("\t\tMasukan alas	: ");
	scanf("%i" , &alass);
	printf("\n");
	printf("\t\tMasukan sisi c	: ");
	scanf("%i" , &sisice);
	printf("\n");
	printf("\t\tMasukan tinggi	: ");
	scanf("%i" , &tinggii);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , 1/2*(alass+sisice)*tinggii);
	printf("\n");
}

int kelpsg(){

	//Keliling Persegi
	int sisi;	
	printf("\n");
	printf("\t\t\tKeliling Persegi\n\n");
	printf("\t\tMasukan sisi : ");
	scanf("%i" , &sisi);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya : ");
	printf("%i" , 4*sisi);
	printf("\n");
}

int kelsgt(){

	//Keliling Segitiga
	int sisia, sisib, sisic;
	printf("\n");
	printf("\t\t\tKeliling Segitiga\n\n");
	printf("\t\tMasukan sisi a  : ");
	scanf("%i" , &sisia);
	printf("\n");
	printf("\t\tMasukan sisi b : ");
	scanf("%i" , &sisib);
	printf("\n");
	printf("\t\tMasukan sisi c : ");
	scanf("%i", &sisic);
	//Rumus  
	printf("\t\tHasilnya : ");
	printf("%i" , sisia+sisib+sisic);
	printf("\n");
}

int keling(){

	//Keliling lingkaran
	float d;
	printf("\n");
	printf("\n\n");
	printf("\t\t\tKeliling Lingkaran\n\n");
	printf("\t\tMasukan diameter	: ");
	scanf("%f" , &d);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%f" , 3,14*d);
	printf("\n");
}

int keljargen(){

	//Keliling jajar genjang
	int a, b;
	printf("\n");
	printf("\n\n");
	printf("\t\t\tKeliling Jajar Genjang\n\n");
	printf("\t\tMasukan alas   : ");
	scanf("%i" , &a);
	printf("\n");
	printf("\t\tMasukan sisi b : ");
	scanf("%i" , &b);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	   : ");
	printf("%i" , 2*(a+b));
	printf("\n");
}

int kelbelketupat(){

	//Keliling belah ketupat
	int sisii;
	printf("\n");
	printf("\t\t\tKeliling Belah Ketupat\n\n");
	printf("\t\tMasukan sisi : ");
	scanf("%i" , &sisii);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , 4*sisii);
	printf("\n");
}

int kelayang(){

	//Keliling layang-layang
	int sia, sib;
	printf("\n");
	printf("\t\t\tKeliling Layang-Layang\n\n");
	printf("\t\tMasukan sisi a : ");
	scanf("%i" , &sia);
	printf("\n");
	printf("\t\tMasukan sisi b : ");
	scanf("%i" , &sib);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , 2*(sia+sib));
	printf("\n");
}

int kelpp(){

	//Keliling Persegi Panjang
	int pa, le;
	printf("\n");
	printf("\t\t\tKeliling Persegi Panjang\n\n");
	printf("\t\tMasukan panjang	: ");
	scanf("%i" , &pa);
	printf("\n");
	printf("\t\tMasukan lebar	: ");
	scanf("%i" , &le);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , 2*(pa+le));
	printf("\n");
}

int keltrap(){

	//Keliling Trapesium
	int sisiia, sisiib, sisiic, sisiid;
	printf("\n");
	printf("\t\t\tKeliling Trapesium\n\n");
	printf("\t\tMasukan sisi a	: ");
	scanf("%i" , &sisiia);
	printf("\n");
	printf("\t\tMasukan sisi b	: ");
	scanf("%i" , &sisiib);
	printf("\n");
	printf("\t\tMasukan sisi c	: ");
	scanf("%i" , &sisiic);
	printf("\n");
	printf("\t\tMasukan sisi d	: ");
	scanf("%i" , &sisiid);
	printf("\n");
	//Rumus 
	printf("\t\tHasilnya	: ");
	printf("%i" , sisiia+sisiib+sisiic+sisiid);
	printf("\n");
}