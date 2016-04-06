template<class T1, class T2>
class Kolekcija{
T1 * _elementi1;
T2 * _elementi2;
int _trenutnoElemenata;
/*
1. AddElement :: omogucava dodavanje novog elementa u kolekciju. Ukoliko je moguce, osigurati automatsko prosiranje kolekcije prilikom dodavanja svakog novog elementa, te onemoguciti ponavljanje elemenata
2. RemoveElement :: na osnovu parametra tipa T1 uklanja elemente iz kolekcije i ukoliko je moguce smanjuje velicinu niza/kolekcije. Prilikom uklanjanja elemenata ocuvati redoslijed njihovog dodavanja
*/
};
class Datum{
int *_dan, *_mjesec, *_godina;
//1. potrebne funkcije
};
class Pitanje{
const int _pitanjeID;
char * _tekst;
char * _odgovori[10];//maksimalno 10 odgovora
int _tacan;//lokacija tacnog odgovora - svako pitanje moze imati samo jedan tacan odgovor
int _bodova; //broj bodova koje nosi pitanje
Datum _datumKreiranja;
/*	
1.AddOdgovor :: dodaje novi odgovor u listu ponudjenih odgovora. Voditi racuna da novi odgovor moze biti tacan
2.RemoveOdgovor :: na osnovu lokacije u nizu uklanja podatke o ponudjenom odgovoru. Prilikom uklanjanja ocuvati redoslijed dodavanja odgovora. Uklanjanje tacnog odgovora zahtijeva odabir novog tacnog dogovora osim u slucaju da se uklanja posljednji ponudjeni odgovor
3.operator<< :: ispisuje pitanje sa svim ponudjenim odgovorima
*/
};
class Kandidat{
char * _imePrezime;
char _JMBG[14];
//argument tipa int ce cuvati informaciju o odgovoru koji je kandidat dao na ponudjeno pitanje
Kolekcija<Pitanje, int> _kandidatPitanjaOdgovori;
/*
1.AddPitanje :: dodaje pitanje na koje kandidat treba odgovoriti tokom prijemnog ispita
2.RemovePitanje :: na osnovu teksta pitanja, uklanja podatke o pitanju
3.GetBrojBodova :: vraca broj bodova koje je kandidat ostvario na prijemnom ispitu. Za netacan odgovor kandidat osvaja 0 bodova, a u suprotnom osvaja broj bodova koje nosi to pitanje
*/
};

class PrijemniIspit{
Datum _datumOdrzavanja;
vector<Kandidat *> _prijavljeniKandidati;
int _pragProlaznosti; //prag prolaznosti na prijemnom ispitu npr. 30 bodova
int _brojPitanja;
/*
1. DodajKandidata :: dodaje novog kandidata koji ce polagati prijemni ispit
2. PokreniIspit :: na osnovu parametra koji predstavlja JMBG kandidata pokrece prijemni ispit i kandidatu omogucava unos odgovora na postavljena pitanja. Za pokretanje prijemnog ispita kandidat mora posjedovati broj pitanja koja su definisana atributom _brojPitanja
3. DodajPitanje :: dodaje novo pitanje kandidatu sa vrijednoscu JMBG-a koji je proslijedjen kao parametar. Datum kreiranja novog pitanja ne smije biti manji od datuma odrzavanja prijemnog ispita 
4. PrikaziUspjeh :: treba da ispise uspjeh prijavljenih kandidata organizovan po sljedecim kategorijama: 
a.Polozili
b.Nisu polozili
c.Nisu izasli
d.Ne zadovoljavaju uslove (nemaju dovoljan broj pitanja)
5. GetTacneOdgovore :: vraca niz kandidata koji su tacno odgovorili na pitanje koje je proslijedjeno kao parametar 
*/
};
void main(){
//izbjegavajte koristenje vlastitog imena i prezimena
//provjeriti validnost izvrsenja svih dostupnih funkcionalnosti na objektu tipa PrijemniIspit 
}