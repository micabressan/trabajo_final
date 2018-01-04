package woche4;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class Uebung5 {

	public static void main(String[] args) throws IOException {

		Scanner myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Textpassage.txt"));
		int anzahlWoerter = 0;

		while (myFile.hasNext()) {
			myFile.next();
			anzahlWoerter++;
		}

		String[] woerter = new String[anzahlWoerter];

		myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Textpassage.txt"));

		int wortFueller = 0;
		while (myFile.hasNext()) {
			woerter[wortFueller] = myFile.next();
			wortFueller++;
		}

		for (int i = 0; i < woerter.length; i++) {
			System.out.print(woerter[i] + " ");
		}

		System.out.print("\n");
		
		System.out.print(Histogramm(woerter));
		
	}
	
		static String Histogramm(String[] woerter) {
		
		int probe = 0;
		for (int i = 0; i < woerter.length; i++) {
			probe++;
		}
		String[] test = new String[probe];
		
		
		for (int i = 0; i < woerter.length; i++) {
			test[i] = "*";
			return test[];

		}

	}
}