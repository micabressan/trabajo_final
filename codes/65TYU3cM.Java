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
		
		if(inputIntroduzido == "tigre" || inputIntroduzido == "Tigre") {
			Tigre myTigre = new Tigre();
			System.out.println(myTigre);
			return true;
				
		}else if(inputIntroduzido == "leão"|| inputIntroduzido == "Leão" || inputIntroduzido == "Leao" || inputIntroduzido == "leao"){
			Leao myLeao = new Leao();
			System.out.println(myLeao);
			return true;
				
		}else {
			return false;
		}
	}
}

public class Tigre {
	@Override
	public String toString() {
		String info = " BLAH BLAH BLAH INFO DO TIGRE. ";
		return info;	
	}
}

public class Leao {
	
	@Override
	public String toString() {
		String info = " BLAH BLAH BLAH INFO DO LEÃO. ";
		return info;	
	}
}