#include <stdio.h>
#include <stdlib.h>
#define MAX 300

typedef struct tacka{ int x; int y} Tacka;

	void funkcija(*Tacka a, Tacka t3, Tacka t4){
		int j,i,k,m=0,n,br;
		Tacka* t1,t2;
		for(i=0; i<N-1; i++)
			for(j=i+1; j<N; j++){
				br=0;
				t1.x=a[i].x;
				t1.y=a[i].x;
				t2.x=a[j].x;
				t2.y=a[j].y;
					for(n=0; n<N; n++)
					{	if(t1.x> t2.x && t1.y>t2.y && a[n].x<t1.x && a[n].x>t2.x && a[n].y<t1.y && a[n].y>t2.y) br++;
						if(t1.x> t2.x && t1.y<t2.y && a[n].x<t1.x && a[n].x>t2.x && a[n].y>t1.y && a[n].y<t2.y) br++;
						if(t1.x< t2.x && t1.y>t2.y && a[n].x>t1.x && a[n].x<t2.x && a[n].y<t1.y && a[n].y>t2.y) br++;
						if(t1.x< t2.x && t1.y<t2.y && a[n].x<t1.x && a[n].x<t2.x && a[n].y<t1.y && a[n].y<t2.y) br++;
					}
					if(m<br){
						m=br;
						t3.x=t1.x;
						t4.x=t2.x;
						t3.y=t1.y;
						t4.y=t2.y;
					}
			}

 	void main(){
 		int i,j,k,N;
 		Tacka t3, t4;
 		Tacka *a;

 		printf("Unesite broj elementa niza:");
 		scanf("%d",&N);
 		if(N>300 || N<0) exit(1);
 		a=(Tacka*) malloc(N*sizeof(Tacka));
 		if(a==NULL) exit(2);

 		printf("Unesite kordinate tacaka:");
 		for(i=0; i<N; i++) 
 		{
 			scanf("%d%d%d ", &a[i].x, &a[i].y);
 			
 		}
 			t3.x=0;
 			t3.y=0;
 			t4.x=0;
 			t4.y=0;
 			 funkcija(a, &t3, &t4);

 			printf("Trazeni pravougaonik ima temena na dijagonali (%d,%d), (%d,%d):", t3.x, t3.y, t4.x; t4.y);
 			free(a);
 		}