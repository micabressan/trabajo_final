package woche4;

import java.util.Scanner;

public class Uebung4 {

	public static void main(String[] args) {
		// fester Nutzername "Yassin" & einzugebender String
		String benutzer = "Yassin";
		String userEingabe;

		// einzugebenes Passwort
		String passwort;

		// Scanner fragt nach String userEingabe
		Scanner input = new Scanner(System.in);
		System.out.print("Benutzername: ");

		// Eingabe String benutzer muss übereinstimmen, um Schleife zu verlassen
		do {
			userEingabe = input.nextLine();

			if (userEingabe.equals(benutzer)) {
				System.out.println("");

			} else {
				System.out.print("Falscher Benutzername!" + "\n" + "Benutzername: ");
			}
		} while (!userEingabe.equals(benutzer));

		// passwort muss min 8 zeichen erreichen um Schleife zu verlassen
		do {
			System.out.print("Passwort: ");
			passwort = input.nextLine();

			if (passwort.length() > 7) {
				System.out.println("Willkommen daheim, Yassin :)");

			} else
				System.out.println("Passwort muss mindestens (Sicherheitslevel *) erreichen!(Min. 8 Zeichen)");
		} while (passwort.length() < 8);

		// Anfrage Passwortsicherheitsstufe erhöhen auf ** oder *** (optional)
		System.out.println("\n" + "Wollen sie ihr Passwort auf Sicherheitslevel ** oder *** erhöhen?" + "(Y/N)");
		String sicherheit;

		do {

			sicherheit = input.nextLine();
			if (sicherheit.equals("Y")) {
				break;

			} else if (sicherheit.equals("N")) {

				System.out.println("Goodbye!");
				System.exit(0);

			} else {
				System.out.println("Falsche Eingabe!");
			}
		} while (!sicherheit.equals("Y") && !sicherheit.equals("N"));

		boolean a = false;
		boolean b = false;

		String neuesPasswort;

		do {

			while (true) {
				System.out.print("Geben sie ihr neues Passwort ein: ");
				neuesPasswort = input.nextLine();
				if (neuesPasswort.length() > 7) {
					break;
				} else {
					System.out.println("Eingegebenes Passwort muss mindestens 8 Zeichen enthalten!" + "\n");
				}
			}

			for (char c : neuesPasswort.toCharArray()) {
				if (Character.isDigit(c)) {
					a = true;
				}
				if (Character.isUpperCase(c)) {
					b = true;
				}
			}

			if (a && b) {
				System.out.println("Sicherheitslevel** erreicht!");
			}

			if (!a || !b) {
				System.out.println("Sicherheitslevel** nicht erreicht!");
			}
		} while (!a || !b);

	}
}