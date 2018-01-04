package woche4;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class Uebung3 {

	public static void main(String[] args) throws IOException {

		Scanner myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Kontostaende.txt"));
		int groesse = 0;

		// Solange nicht am Dateiende angekommen
		while (myFile.hasNextInt()) {
			// Zaehle Anzahl der Ints/Kontostaende
			myFile.nextInt();
			groesse++;
		}

		int[] kontostaende = new int[groesse];

		myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Kontostaende.txt"));

		int counter = 0;
		while (myFile.hasNextInt()) {
			kontostaende[counter] = myFile.nextInt();
			counter++;
		}
			
			for (int i = 0; i < kontostaende.length;i++) {
				
				System.out.print(kontostaende[i] + " ");
		
		}
	
			for (int a = 0; a < kontostaende.length; a++) {
			int bruch = kontostaende[a] / 10;
			
			}}
		
			
			
			
		public static String histogramm(int [] kontostaende, int bruch) {
			for (int b = 0; b < bruch;b++) {
				String[] test = new String[bruch];
				test[b] = "*";
			return test[b];

			}

		}
	}