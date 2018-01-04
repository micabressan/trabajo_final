package ppj20;
import java.io.IOException;
import java.io.InputStream;
import java.util.Scanner;
public class Klasa1 {
	public static void main(String[] args) {
		
		MojSkaner ms = new MojSkaner(System.in);
		//System.out.println(ms.odczytajSlowo());
		System.out.println(ms.odczytajLinie());
	}
}
class MojSkaner{
	InputStream is;
	 public MojSkaner(InputStream is){
		this.is = is;
	}
	 String odczytajSlowo() {
		 String wyn = "";
		 InputStream wejscie = System.in;
		 try {
			 int znak = 0;
			 while((znak = wejscie.read()) != ' ') {
				 wyn = wyn + (char)znak;
			 }
		 }catch(IOException e) {
			 System.out.println("Błąd.");
			 e.printStackTrace();
		 }
		 return wyn;
	 }
	 String odczytajLinie() {
		 String wyn = "";
		 //Scanner odczyt = new Scanner(System.in);
		// wyn = odczyt.nextLine();
		InputStream wejscie = System.in;
		 try {
			 int znak = 0;
			 while((znak = wejscie.read()) != 13) {
				 wyn = wyn + (char)znak;
			 }
		 }catch(IOException e) {
			 System.out.println("Błąd");
			 e.printStackTrace();
		 }
		 
		 return wyn;
	 }
}