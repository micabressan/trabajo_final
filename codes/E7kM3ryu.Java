import java.util.Scanner;

public class Aufgabe63 {
	
	public static void main(String[] args)
	
	{	
		
		Scanner scan = new Scanner(System.in);
		System.out.println("Bitte geben Sie eine Zeichenfolge ein: ");
		String eingabe= scan.nextLine();
		char [] feld = eingabe.toCharArray();
		
		int vergleich = 0;
	
		//System.out.println(feld[1]);
		
		numbers(feld, eingabe, vergleich);
		
	
	}
	
	public static void numbers(char [] feld,String eingabe, int vergleich)
	{
		
		
		
		for (int i = 0; i < eingabe.length(); i++)			//überprüft, ob es eine ( oder eine ) Klammer ist
		{
			if (vergleich < 0)
			{
				
				break;
			}
			
			else if (feld[i] == '(')
			{
				
				vergleich++;
				
			}
			
			else if (feld[i] == ')')
			{
				vergleich--;
			}
			
			
		
		}
		
		
		
		if(vergleich == 0)
		{
		
		System.out.println("Die Eingabe war korrekt!");
		
		}
		
		else if(vergleich < 0)
		{
			System.out.println("Leider ist die Eingabe falsch");
		}
		

		
	}
	
	
	}