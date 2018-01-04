import java.util.Scanner;

public class App {
	
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		
		System.out.println("Choose the name of the animal:");
		
		while(!introduçao(input.nextLine())) {
			System.out.println("The animal you've chosen is not in our database. Please choose a new one:");
		}
		
		input.close();
	}
	
	public static boolean introduçao (String inputIntroduzido) {
		
		if(inputIntroduzido.compareTo("tigre")==0 || inputIntroduzido.compareTo("Tigre")==0) {
			Tigre myTigre = new Tigre();
			System.out.println(myTigre);
			return true;
				
		}else if(inputIntroduzido.compareTo("leão")==0|| inputIntroduzido.compareTo("Leão")==0 || inputIntroduzido.compareTo("Leao")==0 || inputIntroduzido.compareTo("leao")==0){
			Leao myLeao = new Leao();
			System.out.println(myLeao);
			return true;
				
		}else {
			return false;
		}
	}
}

class Leao {
	
	@Override
	public String toString() {
		String info = " BLAH BLAH BLAH INFO DO LEÃO. ";
		return info;	
	}
}

class Tigre {
	
	@Override
	public String toString() {
		String info = " BLAH BLAH BLAH INFO DO TIGRE. ";
		return info;	
	}
}