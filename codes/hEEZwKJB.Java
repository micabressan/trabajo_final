import java.util.Scanner;
public class do_zera {

	public static void main(String[] args) {
		Scanner odczyt = new Scanner(System.in);
		int liczba, suma;
		suma = 0;
		do{
			System.out.println("podaj liczbe: ");
			liczba = odczyt.nextInt();
			suma += liczba;
			if (liczba == 0){
				System.out.println(suma);
				break;
			}
		}while (true);
	}
}