#include <graphics.h>
#include <conio.h>
#include <math.h>
#include "Affine.h"
#define TYLEX 20
#define TYLEY 8
#define PI 3.14


void waving(){
	    
      
int gd=DETECT,gm,x,y,tx,ty,i,x1,y1,xm,ym;
//initgraph(&gd,&gm,"");

//xm=getmaxx();
//ym=getmaxy();
//setviewport(xm/2,ym/3+32,xm,ym,0 );


for(int p=0;p<=3;p++) {

setactivepage(p);
    
// VE CO

    setcolor(RED);
  
     for(int i=-200;i<=200;i++)
{
     
    
x=(int) ceil((PI*i/100)*TYLEX);
y=(int) ceil(sin(PI*(i+p*50)/100)*TYLEY);
x1=(int) ceil((PI*(i+1)/100)*TYLEX);
y1=(int) ceil(sin(PI*(i+p*50+1)/100)*TYLEY);
line(x,y,x1,y1);


x=(int) ceil((PI*i/100)*TYLEX);
y=(int) ceil(sin(PI*(i+p*50)/100)*TYLEY-160);
x1=(int) ceil((PI*(i+1)/100)*TYLEX);
y1=(int) ceil(sin(PI*(i+p*50+1)/100)*TYLEY-160);
line(x,y,x1,y1);

 }
 
line((int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200+p*50)/100)*TYLEY), (int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200+p*50)/100)*TYLEY-160) );     
line((int) ceil((PI*(200)/100)*TYLEX),(int) ceil(sin(PI*(200+p*50)/100)*TYLEY), (int) ceil((PI*(200)/100)*TYLEX),(int) ceil(sin(PI*(200+p*50)/100)*TYLEY-160) );     

 setfillstyle(1,RED);
floodfill(-45,-100,RED);   


// VE COT CO

setcolor(WHITE);
line((int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX),225 );     
line((int) ceil((PI*(-200)/100)*TYLEX)-15,(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX)-15,225 );     
line((int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX)-15,(int) ceil(sin(PI*(-200)/100)*TYLEY)-165 );   
line ((int) ceil((PI*(-200)/100)*TYLEX),225 ,	(int) ceil((PI*(-200)/100)*TYLEX)-15,225 );

circle((int) ceil((PI*(-200)/100)*TYLEX)-7,(int) ceil(sin(PI*(-200)/100)*TYLEY)-175,10);    
    
 
setfillstyle(1,BLUE);
floodfill((int) ceil((PI*(-200)/100)*TYLEX)-5,100,WHITE); 

setfillstyle(1,GREEN);
floodfill((int) ceil((PI*(-200)/100)*TYLEX)-5,(int) ceil(sin(PI*(-200)/100)*TYLEY)-170,WHITE); 

//  VE TRU CO

	line((int) ceil((PI*(-200)/100)*TYLEX)-70,225,(int) ceil((PI*(-200)/100)*TYLEX)+50,225);
    line((int) ceil((PI*(-200)/100)*TYLEX)-70,225,(int) ceil((PI*(-200)/100)*TYLEX)-90,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)+50,225,(int) ceil((PI*(-200)/100)*TYLEX)+70,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)-115,245,(int) ceil((PI*(-200)/100)*TYLEX)+95,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)-115,245,(int) ceil((PI*(-200)/100)*TYLEX)-135,265);
    line((int) ceil((PI*(-200)/100)*TYLEX)+95,245,(int) ceil((PI*(-200)/100)*TYLEX)+115,265);
    line((int) ceil((PI*(-200)/100)*TYLEX)-135,265,(int) ceil((PI*(-200)/100)*TYLEX)+115,265);
    setfillstyle(1,8);
    floodfill((int) ceil((PI*(-200)/100)*TYLEX)-50,230,WHITE);
    floodfill((int) ceil((PI*(-200)/100)*TYLEX)-50,250,WHITE);
    
// VE SAO

setcolor(YELLOW);
    x=-50;

    for(int x=-52;x<=52;x++)
{
   
line(x,ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);

if (x<=47) {
  line(x,(x+50)*tan(0.2*PI)+ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,(x+50+1)*tan(0.2*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);
 }
 
if (x>=-47) {
     line(x,(50-x)*tan(0.2*PI)+ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,(50-(x+1))*tan(0.2*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);
       
            }
 if (x>=-45 && x<=45) {           
            
line (x, (abs(x)-19)*tan(0.38*PI)+ ceil(sin(PI*(x+p*50)/100)*TYLEY)-97,x+1,(abs(x+1)-19)*tan(0.38*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-97);                  
}


}


setfillstyle(1,14);

      floodfill(-26,-90,14);
      floodfill(26,-90,14);
      floodfill(0,-80,14);
      floodfill(0,-120,14);
      floodfill(20,-60,14);
      floodfill(-20,-60,14);
 
 
}


//system("cmdmp3win.exe BadGirl.mp3"); 

int count=0;
i=0;

do{
setvisualpage(i);
if (count%2==0) i++;
else i--;
if (i==3 || i==0) count = 1 - count;
else delay(200);

}while(!kbhit());

}





void cotco(){
	
// VE COT CO

setcolor(WHITE);
line((int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX),225 );     
line((int) ceil((PI*(-200)/100)*TYLEX)-15,(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX)-15,225 );     
line((int) ceil((PI*(-200)/100)*TYLEX),(int) ceil(sin(PI*(-200)/100)*TYLEY)-165, (int) ceil((PI*(-200)/100)*TYLEX)-15,(int) ceil(sin(PI*(-200)/100)*TYLEY)-165 );   
line ((int) ceil((PI*(-200)/100)*TYLEX),225 ,	(int) ceil((PI*(-200)/100)*TYLEX)-15,225 );

circle((int) ceil((PI*(-200)/100)*TYLEX)-7,(int) ceil(sin(PI*(-200)/100)*TYLEY)-175,10);    
    
 
setfillstyle(1,BLUE);
floodfill((int) ceil((PI*(-200)/100)*TYLEX)-5,100,WHITE); 

setfillstyle(1,GREEN);
floodfill((int) ceil((PI*(-200)/100)*TYLEX)-5,(int) ceil(sin(PI*(-200)/100)*TYLEY)-170,WHITE); 

//  VE TRU CO

	line((int) ceil((PI*(-200)/100)*TYLEX)-70,225,(int) ceil((PI*(-200)/100)*TYLEX)+50,225);
    line((int) ceil((PI*(-200)/100)*TYLEX)-70,225,(int) ceil((PI*(-200)/100)*TYLEX)-90,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)+50,225,(int) ceil((PI*(-200)/100)*TYLEX)+70,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)-115,245,(int) ceil((PI*(-200)/100)*TYLEX)+95,245);
    line((int) ceil((PI*(-200)/100)*TYLEX)-115,245,(int) ceil((PI*(-200)/100)*TYLEX)-135,265);
    line((int) ceil((PI*(-200)/100)*TYLEX)+95,245,(int) ceil((PI*(-200)/100)*TYLEX)+115,265);
    line((int) ceil((PI*(-200)/100)*TYLEX)-135,265,(int) ceil((PI*(-200)/100)*TYLEX)+115,265);
    setfillstyle(1,8);
    floodfill((int) ceil((PI*(-200)/100)*TYLEX)-50,230,WHITE);
    floodfill((int) ceil((PI*(-200)/100)*TYLEX)-50,250,WHITE);
}




void ve(int k,int c,int p) {
	int x,y,x1,y1;
	setcolor(c);
	     for(int i=-200;i<=200;i++)
{
     
    
x=(int) ceil((PI*i/100)*TYLEX);
y=k+(int) ceil(sin(PI*(i+p*50)/100)*TYLEY);
x1=(int) ceil((PI*(i+1)/100)*TYLEX);
y1=k+(int) ceil(sin(PI*(i+p*50+1)/100)*TYLEY);
line(x,y,x1,y1);


x=(int) ceil((PI*i/100)*TYLEX);
y=k+(int) ceil(sin(PI*(i+p*50)/100)*TYLEY-160);
x1=(int) ceil((PI*(i+1)/100)*TYLEX);
y1=k+(int) ceil(sin(PI*(i+p*50+1)/100)*TYLEY-160);
line(x,y,x1,y1);

 }
 
line((int) ceil((PI*(-200)/100)*TYLEX),k+(int) ceil(sin(PI*(-200+p*50)/100)*TYLEY), (int) ceil((PI*(-200)/100)*TYLEX),k+(int) ceil(sin(PI*(-200+p*50)/100)*TYLEY-160) );     
line((int) ceil((PI*(200)/100)*TYLEX),k+(int) ceil(sin(PI*(200+p*50)/100)*TYLEY), (int) ceil((PI*(200)/100)*TYLEX),k+(int) ceil(sin(PI*(200+p*50)/100)*TYLEY-160) );     

setfillstyle(1,c);
floodfill(x-50,y+50,c); 
putpixel(x-50,y+50,RED);


// VE SAO

setcolor(YELLOW);
    x=-50;

    for(int x=-52;x<=52;x++)
{
   
line(x,k+ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,k+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);

if (x<=47) {
  line(x,k+(x+50)*tan(0.2*PI)+ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,k+(x+50+1)*tan(0.2*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);
 }
 
if (x>=-47) {
     line(x,k+(50-x)*tan(0.2*PI)+ceil(sin(PI*(x+p*50)/100)*TYLEY)-100,x+1,k+(50-(x+1))*tan(0.2*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-100);
       
            }
 if (x>=-45 && x<=45) {           
            
line (x, k+(abs(x)-19)*tan(0.38*PI)+ ceil(sin(PI*(x+p*50)/100)*TYLEY)-97,x+1,k+(abs(x+1)-19)*tan(0.38*PI)+ceil(sin(PI*(x+1+p*50)/100)*TYLEY)-97);                  
}


}


setfillstyle(1,14);

      floodfill(-26,k+-90,14);
      floodfill(26,k+-90,14);
      floodfill(0,k+-80,14);
      floodfill(0,k+-120,14);
      floodfill(20,k+-60,14);
      floodfill(-20,k+-60,14);
 
}




struct point {
       float x,y;
       };
int main()
{
    int gd=0,gm=0,p=0;
    float Q[3][3],P[3][3],M[3][3];
    point A,B;
    initgraph(&gd,&gm,"");
    int xm=getmaxx();
    int ym=getmaxy();
    setviewport(xm/2,ym/3+32,xm,ym,0 );
    
    A.x=300; A.y=200;
    B.x=200; B.y=300;
    
    P[0][2]=Q[0][2]=1;
    P[1][0]=Q[1][0]=0;
    P[1][1]=Q[1][1]=0;
    P[1][2]=Q[1][2]=0;
    P[2][0]=Q[2][0]=0;
    P[2][1]=Q[2][1]=0;
    P[2][2]=Q[2][2]=0;
    
    TinhTien(M,0,-2);
    
    
    cotco();
    
    for (int i=0;i<=100;i++) {
    
     p++;
          //rectangle(A.x,A.y,B.x,B.y);
         // line(A.x,A.y,A.x+100,A.y+100);
         ve(A.y,4,p);
          delay(100);
        
         // rectangle(A.x,A.y,B.x,B.y);
         // line(A.x,A.y,A.x+100,A.y+100);
          ve(A.y,0,p);
        
          
          P[0][0]=A.x;
          P[0][1]=A.y;
          
          MatMul(P,M,Q);
          
          A.x=Q[0][0];
          A.y=Q[0][1];
          
          P[0][0]=B.x;
          P[0][1]=B.y;
          
          MatMul(P,M,Q);
          
          B.x=Q[0][0];
          B.y=Q[0][1];
                  
			  // getch(); 
          }
          ve(A.y,4,0);
    //getch();
    //closegraph();
    waving();
}