package Uppgift4;

import javax.swing.JOptionPane;

public class Metoder {

	public static void anmal() {
	Person [] minaStuderande = new Person [3];
	
	for (int i = 0; i < minaStuderande.length; i++) {
	String input = JOptionPane.showInputDialog(null, "Vänligen mata in namn och matrikelnummer separerat med komma(,)");
	String [] array = input.split(",");
	String x = array[0];
	int y = Integer.parseInt(array[1]);
	minaStuderande [i] = new Person(x,y);
	if (minaStuderande.length == Person.antalSkapat) {
	
	
	System.out.println(minaStuderande[0].getInfo());
	System.out.println(minaStuderande[1].getInfo());
	System.out.println(minaStuderande[2].getInfo());
	}
	}
	}
	

	public static void stryk() {
		// TODO Auto-generated method stub
		
	}

	public static void skrivUt(String [] minaStuderande) {
		for (int i = 0; i < Person.antalSkapat; i++) {
			JOptionPane.showMessageDialog(null, minaStuderande[i]);
			
		}
		
		}
	

	public static void sluta() {
		// TODO Auto-generated method stub
		
	}

	public static int fraga(int x) {
		String[] mojligheter = new String [] {"Anmäl", "Stryk", "Skriv ut", "Sluta"}; 
		int svar = JOptionPane.showOptionDialog(null, "Vad vill du göra?" , "Question", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE, null, mojligheter, mojligheter[0]);
		
		if (svar == 0) { 
			JOptionPane.showMessageDialog(null, "Du tryckte anmäl!");
			Metoder.anmal();
		}
		if (svar == 1) {
			JOptionPane.showMessageDialog(null, "Du tryckte Stryk!");
			Metoder.stryk();
		}
		if (svar ==2) {
			JOptionPane.showMessageDialog(null, "Du tryckte Skriv ut!");
			Metoder.skrivUt(minaStuderande);
		}
		if(svar==3) {
			JOptionPane.showMessageDialog(null, "Du tryckte Sluta!");
			Metoder.sluta();
		}
		return svar;
	}
}