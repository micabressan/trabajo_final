console.log("%c ZADANIE PIERWSZE", "background:black; color:red")
/*  Zadanie 1
    Utworz 3 zmienne.
    - Pierwsza zmienna ma byc typem number(liczba) i nazywac sie liczba
    - Druga ma byc typem string i nazywac sie napis.
    - Trzecia ma byc typem boolean(prawda/falsz) i nazywac sie owca.
*/
//Ponizej pisz swoj kod



console.log("💠: " + liczba);
console.log("⭐: " + napis);
console.log("🚙: " + owca);
console.log("%c ZADANIE DRUGIE", "background:black; color:red");
/*
    Zadanie 2
    Na dole podane sa  zmienne ktore przechowuja liczbe
    sekund w minucie , sekund w godzinie itd.
    Twoim zadaniem jest przypisac do pozostałyc zmennych odpowiednie
    liczby korzystajac z tych utworoznych wczesniej;
*/

    let sekundWMinucie = 60;
    let minutWGodzinie = 60;
    let sekundWGodzinie //Uzupelnij

    let godzinWDobie = 24;
    let sekundWDobie //Uzupelnij

    let dniWRoku = 365;
    let sekundWRoku //Uzupelnij

    let twojWiek //Uzupelnij
    let twojWiekWSekundach // Uzupelnij

console.log("Masz: " + twojWiekWSekundach + " sekund ❤️");
console.log("%c ZADANIE TRZECIE", "background:black; color:red");

/*
  Zadanie 3
  Poniżej masz 3 zmienne.
  Zwieksz x o 5.
  Zmniejsz y o 5.
  Zwieksz z o 1.
  Zmniejsz c o 1.
 */
 let x  = 5;
 let y = 15;
 let z = 9;
 let c = 11;
 //Twoj kod poniżej


if(x === 10 && y === 10 && z === 10 && c === 10) {
  console.log("Zadanie 3 zaliczone 👏");
} else {
  console.log("Popełniłes gdzieś błąd 🐑");
}
console.log("%c ZADANIE CZWARTE", "background:black; color:red");

/*
  Zadanie 4
  Utworz 3 zmienne o nazwie pozdrowienie,imie, owca2
   do pierwszych dwoch przypisz dowolny napis
  do ostatniej przypisz polonczenie pierwszych dwoch napisow pamietaj o spacji
*/
//twoj kod ponizej


  console.log(imie,pozdrowienie,owca2);
  console.log("%c ZADANIE PIATE", "background:black; color:red");
  /*
    Zadanie 5
    Sprawdz za pomoca komendy w JavaScript jak dlugi jest napis ze zmiennej owca2;
  */
//twoj kod Ponizej


console.log("%c ZADANIE SZOSTE", "background:black; color:red");
/*
  Zadanie 6
  * Do zmiennej pierwszaLitera, za pomoca nawiasow [],
    przypisz pierwsza litere ze zmiennej imie.
  * Do  zmiennych duzeLitery i  maleLitery przypisz odpowiednio
    zmieniony na same male i same duze litery napis ze zmiennej owca2

    Przyklad dla napisu LaLaLa:
    duzeLitery -> LaLaLa
    maleLitery -> lalala
    link1: https://developer.mozilla.org/pl/docs/Web/JavaScript/Referencje/Obiekty/String/toUpperCase
    link2: https://developer.mozilla.org/pl/docs/Web/JavaScript/Referencje/Obiekty/String/toLowerCase
*/
//twoj kod Ponizej
let pierwszaLitera
let duzeLitery
let maleLitery

if(pierwszaLitera === imie[0] && duzeLitery === owca2.toUpperCase() && maleLitery === maleLitery.toLowerCase()){
  console.log("Dobrze 👏");
} else {
  console.log("Cos poszlo nie tak 😞");
}
console.log("%c ZADANIE SIODME", "background:black; color:red");
/*
  Zadanie 7
    Uzupelnij operatorami logicznymi(czyli <, >, ===, itd) zmienne poniżej
    aby porowniana zwracaly prawde
*/

  let owca3 = 1000
  let owca4 = 500
  let spr = owca3   owca4
  console.log(spr);

  owca3 = 376
  owca4 = 500
  spr = owca3   owca4
  console.log(spr);

  owca3 = 500
  owca4 = 500
  spr = owca3   owca4
  console.log(spr);

  owca3 = "1"
  owca4 = 1
  spr = owca3   owca4
  console.log(spr);

  owca3 = true
  owca4 = false
  spr = owca3   owca4
  console.log(spr);