import java.util.Scanner;

// Calkowanie numeryczne - metoda Monte-Carlo

public class Metoda_Monte_Carlo {

	//funkcja dla ktorej obliczamy calke
	private static double func(double x) {
		return x*x;
	}
        //      Warunek:
	//	Zwraca 1 jeżeli punkt leży nad osi OY i jednocześnie pod wykresem funkcji całkowanej
	//	Zwraca -1 jeżeli punkt leży pod osi OY i jednocześnie nad wykresem funkcji całkowanej
	//	W przeciwnym razie zwraca 0
	private static double funcIn(double x, double y) { //Funkcja sprawdza powyższy warunek
		if (( y > 0) && (y <= func(x)))
			return 1;
	   else if (( y < 0) && (y >= func(x)))
			return -1;
		return 0;
	}
	
	//Funkcja, ktora losuje punkt z przedzialu od a do b 
        //(czyli w naszej funkcji od xp do xk oraz od yp do yk)
	private static double randomPoint(double a, double b) {
        return  a + Math.random() * (b-a);
	}	
	
	public static void main(String[] args) {
		double xp, xk, yp, yk, calka;
		int n, pointsIn;
                Scanner scan= new Scanner(System.in);
		
		System.out.println("Podaj poczatek przedzialu całkowania");
		xp = scan.nextInt();
		
		System.out.println("Podaj koniec przedzialu całkowania");
		xk = scan.nextInt();

		System.out.println("Podaj dokladnosc calkowania (ilość punktów)");
		n = scan.nextInt();
		

        yp = 0;
        yk = Math.ceil(Math.max(func(xp), func(xk)));
        System.out.println("xp="+xp+", xk="+xk+ ", yp=0.0, yk=" +yk);
        
        pointsIn = 0;

        for (int i=0; i<n; i++) {
                pointsIn += funcIn(randomPoint(xp, xk), randomPoint(yp, yk));
        }

        calka = (pointsIn / (double)n) * ((xk-xp) * (yk-yp));        
		
		System.out.println("Wartosc calki wynosi w przyblizeniu " + calka);

	}

}