class Leao {
	
	public void Leao() {
		
	}
	
	@Override
	public String toString() {
		String info = " BLAH BLAH BLAH INFO DO LEÃO. ";
		return info;	
	}
}

import java.util.Scanner;

public class App {
	
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		
		System.out.println("Choose the name of the animal:");
		
		String inputIntroduzido = input.nextLine();
		
		while(!introduçao(inputIntroduzido)) {
			System.out.println("The animal you've chosen is not in our database. Please choose a new one:");
		}
		introduçao(inputIntroduzido);
		
		input.close();
	}
	
	public static boolean introduçao (String inputIntroduzido) {
		
		if(inputIntroduzido == "tigre" || inputIntroduzido == "Tigre") {
			
			return true;
				
		}else if(inputIntroduzido == "leão"|| inputIntroduzido == "Leão" || inputIntroduzido == "Leao" || inputIntroduzido == "leao"){
			// não sei como chamar o toString para aqui da mesma forma que tinhas feito before.
			return true;
				
		}else {
			return false;
		}
	}
}