import java.io.IOException;
import java.io.InputStreamReader;
import java.security.PrivilegedAction;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

import javax.swing.text.StyledEditorKit.ForegroundAction;

import Oseba.Comparable;
import Oseba.Test;

public class Izziv5 implements Test {

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("How long arrays should we have?");
		int n = scanner.nextInt();
		//System.out.println(n);
		String[] tt = new String[n];
	
	
		
		//String test =  newPerson.ime.toString();
		//System.out.println(newPerson.priimek);
		//System.out.println(newPerson.ime);
		for (int i = 0; i < n; i++) {
			Oseba newPerson = new Oseba();
			tt[i] = newPerson.ime;
			System.out.println(tt[i]);
		}
		System.out.println(tt[2]);
		
		
		scanner.close();
	}
	
}

class Oseba{
	String[] priimki = {"Zajc", "Krt", "Špes", "Malus", "Golob", "Hrastel", "Blatnik"};
	String[] imena = {"Jure", "Lea", "Teja", "Tadej", "Jakob", "Anže", "Leon"};
	//int letoR;
	Random rnd = new Random();
	String priimek = priimki[rnd.nextInt(priimki.length)];
	String ime = imena[rnd.nextInt(imena.length)];
	int letoR2 = rnd.nextInt(2018 - 1900) + 1900;
	String letoR = Integer.toString(letoR2);
	@SuppressWarnings("unused")
	String[] person = {priimek, ime, letoR};
	public  Oseba(){
		priimek = priimki[rnd.nextInt(priimki.length)];
		ime = imena[rnd.nextInt(imena.length)];
		letoR2 = rnd.nextInt(2018 - 1900) + 1900;
	}

	
	public interface Comparable{
		Oseba newPerson = new Oseba();
		String  ime = newPerson.ime;
		Oseba newPers = new Oseba();
		String ime2 = newPers.ime;
		Oseba newPerson2 = new Oseba();
		int  leto = newPerson2.letoR2;
		Oseba newPers2 = new Oseba();
		int leto2 = newPers2.letoR2;
		Oseba newPerson3 = new Oseba();
		String  priimek = newPerson3.priimek;
		Oseba newPers3 = new Oseba();
		String priimek2 = newPers3.priimek;
		
		if(leto < leto2){
			int temp = leto2;
			leto2 = leto;
			leto = temp;
			
		}
	
	}
	
}