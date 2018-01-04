public class Osoba {
	String imie="";
	String nazwisko="";
	int rokurodzenia=0;
	public Osoba(String imie, String nazwisko, int rokurodzenia){ 	
		imie=this.imie;
		nazwisko=this.nazwisko;
		rokurodzenia=this.rokurodzenia;
	}
	public void show() {
		System.out.println("Imie: " + imie + " Nazwisko: "+nazwisko+" Rok Urodzenia: " + rokurodzenia);	
	}
}