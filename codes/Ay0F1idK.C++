#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <windows.h>
#include <conio.h>
#include <string.h>

FILE *game;

struct alat{
	char nama[6];
	int dmg;
};

struct user{
	char nama[10];
	int we;
	int def;
	int hp;
};

int main (){
	
	srand(time(0));
	char play, kar, kata[20];
	int player=0, pil=0, pil1=0, c=0;
	
	struct alat w[3];
	struct alat t[3];
	strcpy(w[0].nama,"Sword"); w[0].dmg=200;
	strcpy(w[1].nama,"Axe"); w[1].dmg=300;
	strcpy(w[2].nama,"Staff"); w[2].dmg=170;
	
	strcpy(t[0].nama,"Wood"); t[0].dmg=70;
	strcpy(t[1].nama,"Iron"); t[1].dmg=100;
	strcpy(t[2].nama,"Magic"); t[2].dmg=90;
	
	struct user p[2];
	p[0].hp=rand()%201 + 300;
	p[1].hp=rand()%201 + 300;
	
	do{
		printf("New Game (Y/N) == ");fflush(stdin);scanf("%c",&play);
		if (play == 'Y' || play == 'y'){
			game = fopen("record.txt","w");
			
			//Isi data Player
			player=rand()%2;
			if(player == 1){
				while (player >=0){
					printf("Player %d : \n",player);
					fflush(stdin);
					while ((kar=getchar()) != '\n'){
						kata[c]=kar;c++;
					}
					strcpy(p[player].nama,kata);
					fputs(kata,game);
					fputc('\n',game);
					printf("Choose Weapon : \n1. Sword\n2. Axe\n3. Staff\n Choice == ");scanf("%d",&pil);
					if(pil == 1){
						p[player].we=w[0].dmg;
						fputs("Weapon : ",game);
						fputs(w[0].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[0].dmg);
						fputc('\n',game);
					}
					else if (pil == 2){
						p[player].we=w[1].dmg;
						fputs("Weapon : ",game);
						fputs(w[1].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[1].dmg);
						fputc('\n',game);
					}
					else if (pil == 3){
						p[player].we=w[2].dmg;
						fputs("Weapon : ",game);
						fputs(w[2].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[2].dmg);
						fputc('\n',game);
					}
			
					printf("Choose Shield : \n1. Wood\n2. Iron\n3. Magic\n Choice == ");scanf("%d",&pil1);
					if(pil1 == 1){
						p[player].def=t[0].dmg;
						fputs("Weapon : ",game);
						fputs(t[0].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[0].dmg);
						fputc('\n',game);
					}
					else if (pil1 == 2){
						p[player].def=t[1].dmg;
						fputs("Weapon : ",game);
						fputs(t[1].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[1].dmg);
						fputc('\n',game);
					}
					else if (pil1 == 3){
						p[player].def=t[2].dmg;
						fputs("Weapon : ",game);
						fputs(t[2].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[2].dmg);
						fputc('\n',game);
					}
					player--;c=0;
					fputc('\n',game);
					fputc('\n',game);
				}
			}
			else {
				while (player <= 1){
					printf("Player %d : \n",player);
					fflush(stdin);
					while ((kar=getchar()) != '\n'){
						kata[c]=kar;c++;
						//strcpy(p[player].nama,kata);	
					}
					strcpy(p[player].nama,kata);
					fputs(kata,game);
					fputc('\n',game);
					printf("Choose Weapon : \n1. Sword\n2. Axe\n3. Staff\n Choice == ");scanf("%d",&pil);
					if(pil == 1){
						p[player].we=w[0].dmg;
						fputs("Weapon : ",game);
						fputs(w[0].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[0].dmg);
						fputc('\n',game);
					}
					else if (pil == 2){
						p[player].we=w[1].dmg;
						fputs("Weapon : ",game);
						fputs(w[1].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[1].dmg);
						fputc('\n',game);
					}
					else if (pil == 3){
						p[player].we=w[2].dmg;
						fputs("Weapon : ",game);
						fputs(w[2].nama,game);
						fputc('\n',game);
						fputs("Demage : ",game);
						fprintf(game,"%d",w[2].dmg);
						fputc('\n',game);
					}
			
					printf("Choose Shield : \n1. Wood\n2. Iron\n3. Magic\n Choice == ");scanf("%d",&pil1);
					if(pil1 == 1){
						p[player].def=t[0].dmg;
						fputs("Weapon : ",game);
						fputs(t[0].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[0].dmg);
						fputc('\n',game);
					}
					else if (pil1 == 2){
						p[player].def=t[1].dmg;
						fputs("Weapon : ",game);
						fputs(t[1].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[1].dmg);
						fputc('\n',game);
					}
					else if (pil1 == 3){
						p[player].def=t[2].dmg;
						fputs("Weapon : ",game);
						fputs(t[2].nama,game);
						fputc('\n',game);
						fputs("Armour : ",game);
						fprintf(game,"%d",t[2].dmg);
						fputc('\n',game);
					}
					player++;c=0;
					fputc('\n',game);
					fputc('\n',game);
				}
			}
			
			//
			
			fclose(game);
			if(p[0].hp < 0 && p[1].hp >0){
				printf("Player 2 WIN\n");
				system("pause");
				fclose(game);
				break;
			}
			else if (p[0].hp > 0 && p[1].hp < 0){
				printf("Player 1 WIN\n");
				system("pause");
				fclose(game);
				break;
			}
			else if (p[0].hp == 0 && p[1].hp == 0){
				printf("DRAW\n");
				system("pause");
				fclose(game);
				break;
			}
		}
		else {
			break;
		}
		
	}
	while (play != 'N' || play != 'n');{
		printf("Terima Kasih...\n");
		printf("Bisa Lihat hasil game di record.txt\n\n");
		system("pause");
	}
	
	return 0;
}