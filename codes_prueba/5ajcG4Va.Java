package woche4;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Uebung2 {
	public static void main(String[] args) throws Exception {
		// List<Integer> kontostaende = new ArrayList<Integer>();
        
		Scanner myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Kontostaende.txt"));
        int groesse = 0;

        // Solange nicht am Dateiende angekommen
		while(myFile.hasNextInt()) {
            // Zaehle Anzahl der Ints/Kontostaende
			myFile.nextInt();
            groesse++;
		}
        
        int[] kontostaende = new int[groesse];
        
        myFile = new Scanner(new File("C:\\Users\\Yassin\\Desktop\\Kontostaende.txt"));
        
        int counter = 0; 
        while(myFile.hasNextInt()) {
            kontostaende[counter] = myFile.nextInt();
            counter++;
        }
             
             
        for (int i = 0; i < kontostaende.length; i++) {
            if (kontostaende[i] > 100) {
                System.out.println("Kontostand " + (i+1) + " ist groesser als 100. Wert: " + kontostaende[i]);
            }
        }                         
	}
}