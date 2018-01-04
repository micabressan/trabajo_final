<html>
<head>
</head>
<body>
<script>
//podaje n ocen od uzytkownika
//wypisuje oceny w postaci ocena 1 : ...
//srednia 
//wypisz czy ma promocje
//wypisz czy otrzymal swiadecwo z paskiem srednia>=4.75
//silnia liczby n w postaci !
 
 
 
 n=prompt("Podaj ilosc ocen");
 n=parseInt(n);

 //zadeklarowane zmienne
var o=1;
var i=1;
var suma=0;
var zagrozenie=0;
function blad(){
alert("Wprowadzona ocena, nie jest w zakresie 1-6")
location.reload();
}

//wprowadzenie ocen w petli
	 for(i=1;i<=n;i++){
	 o=prompt("Podaj "+i+" ocene:");
	 if(o>6 || o<1)
	 blad();
	 else{
	 document.write("<b> Ocena "+i+" : "+o+" <br> </b> ");
	 o=parseInt(o);
	 suma+=o;
	 
		 if(o==1)
		 zagrozenie+=1;
		 else{
		 zagrozenie+=0;
		 }
		 }
	}
	document.write("<br>")
	
	
	
		// WYNIKI //////////////////////
		//zagrozenie
			if(zagrozenie!=0)
			document.write("<b> Czy zdales : </b>  Widzimy sie w przyszlym roku w tym samym miejscu <br> ");
			else{
			 document.write("<b> Czy zdales : </b>  Brawo! Miernie, ale zdałeś <br> ");
			}
			
			//pasek
		if(srednia>=4.75)
		document.write("<b> Pasek : </b> Masz świadectwo z paskiem <br>");
		else{
		document.write("<b> Pasek : </b>  No, pasek dostaniesz, ale od taty <br>");
		}
		//srednia
var srednia=n/suma;
document.write("<b> Srednia ocen: </b> "+srednia.toFixed(3)+" <br>");

//silnia
 wynik = 1;  
        while (n > 0) 
        { 
                wynik = wynik * n ; 
                n -- ; 
        } 
        document.write("<b> Silnia z "+n+" wynosi: "+wynik+"<br> </b>"); 
   
 
 </script>
 </body>
</html>