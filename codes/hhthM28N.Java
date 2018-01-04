import java.io.FileInputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;

public class SintaksniAnalizator {

	private static StringBuilder sb = new StringBuilder();
	private static String redak = "";
	private static Integer dubina = 0;
	private static Scanner sc = new Scanner(System.in);
	
	public static void start(){
		//Path file = Paths.get("C:\\primjer.in");
		//try {
		//	System.setIn(new FileInputStream(file.toFile())); // preusmjeri
		//														// datoteku na
		//														// system in
		//} catch (Exception ignored) {
		//}		
		
		program();
		System.out.println(sb.toString());
		sc.close();
	}
	
	public static void program(){
		sb.append(radiRed("<program>", dubina)).append("\n");
		redak = noviRed();
		if(redak.startsWith("IDN") || redak.startsWith("KR_ZA") || redak.isEmpty()){
			dubina++;
			lista_naredbi();
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void lista_naredbi(){
		sb.append(radiRed("<lista_naredbi>", dubina)).append("\n");
		if(redak.startsWith("IDN") || redak.startsWith("KR_ZA")){
			dubina++;
			naredba();
			lista_naredbi();
			dubina--;
			return;
		}
		
		if(redak.startsWith("KR_AZ") || redak.isEmpty()){
			dubina++;
			sb.append(radiRed("$", dubina)).append("\n");
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void naredba(){
		sb.append(radiRed("<naredba>", dubina)).append("\n");
		if(redak.startsWith("IDN")){
			dubina++;
			naredba_pridruzivanja();
			dubina--;
			return;
		}
		
		if(redak.startsWith("KR_ZA")){
			dubina++;
			za_petlja();
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void naredba_pridruzivanja(){
		sb.append(radiRed("<naredba_pridruzivanja>", dubina)).append("\n");
		
		if(redak.startsWith("IDN")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			dubina--;
		}
				
		if(redak.startsWith("OP_PRIDRUZI")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			dubina--;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void za_petlja(){
		sb.append(radiRed("<za_petlja>", dubina)).append("\n");
		if(redak.startsWith("KR_ZA")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			dubina--;
			redak = noviRed();
		}
		
		if(redak.startsWith("IDN")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			dubina--;
			redak = noviRed();
		}
		
		if(redak.startsWith("KR_OD")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			dubina--;
		}
		if(redak.startsWith("KR_DO")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			lista_naredbi();
			dubina--;
		}
		
		if(redak.startsWith("KR_AZ")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			dubina--;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}	
	}
	
	public static void E(){
		sb.append(radiRed("<E>", dubina)).append("\n");
		
		if(redak.startsWith("IDN") || redak.startsWith("BROJ") || redak.startsWith("OP_PLUS")
				|| redak.startsWith("OP_MINUS") || redak.startsWith("L_ZAGRADA")){
			dubina++;
			T();
			E_lista();
			dubina--;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void T(){
		sb.append(radiRed("<T>", dubina)).append("\n");
		
		if(redak.startsWith("IDN") || redak.startsWith("BROJ") || redak.startsWith("OP_PLUS")
				|| redak.startsWith("OP_MINUS") || redak.startsWith("L_ZAGRADA")){
			dubina++;
			P();
			T_lista();
			dubina--;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void E_lista(){
		sb.append(radiRed("<E_lista>", dubina)).append("\n");
		
		if(redak.startsWith("OP_PLUS")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			dubina--;
			return;
		}
		
		if(redak.startsWith("OP_MINUS")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			dubina--;
			return;
		}
		
		if(redak.startsWith("IDN") || redak.startsWith("KR_ZA") || redak.startsWith("KR_DO")
				|| redak.startsWith("KR_AZ")
				|| redak.startsWith("D_ZAGRADA") || redak.isEmpty()){
			dubina++;
			sb.append(radiRed("$", dubina)).append("\n");
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void T_lista(){
		sb.append(radiRed("<T_lista>", dubina)).append("\n");
		
		if(redak.startsWith("OP_PUTA")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			T();
			dubina--;
			return;
		}
		
		if(redak.startsWith("OP_DIJELI")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			T();
			dubina--;
			return;
		}
		
		if(redak.startsWith("IDN") || redak.startsWith("KR_ZA") || redak.startsWith("KR_DO")
				|| redak.startsWith("KR_AZ") || redak.startsWith("OP_PLUS")
				|| redak.startsWith("OP_MINUS")
				|| redak.startsWith("D_ZAGRADA") || redak.isEmpty()){
			dubina++;
			sb.append(radiRed("$", dubina)).append("\n");
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static void P(){
		sb.append(radiRed("<P>", dubina)).append("\n");
		
		if(redak.startsWith("OP_PLUS")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			P();
			dubina--;
			return;
		}
				
		if(redak.startsWith("OP_MINUS")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			P();
			dubina--;
			return;
		}
		
		if(redak.startsWith("L_ZAGRADA")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			E();
			dubina--;
		}
		
		if(redak.startsWith("D_ZAGRADA")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			dubina--;
			return;
		}
		
		if(redak.startsWith("IDN")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			dubina--;
			return;
		}
		
		if(redak.startsWith("BROJ")){
			dubina++;
			sb.append(radiRed(redak, dubina)).append("\n");
			redak = noviRed();
			dubina--;
			return;
		}
		else{
			ispisGreske(redak);
			System.exit(0);
		}
	}
	
	public static String radiRed(String naziv, int dubina){ // radi stablo, ispisuje
		String red = "";
		for(int i=0; i<dubina; i++){
			red += " ";
		}
		red += naziv;
		return red;
	}
	
	public static void ispisGreske(String redak){ // ako dode do sintaksne greske
		if(! redak.isEmpty()){
			System.out.println("err " + redak);
		}
		else{
			System.out.println("err kraj");
		}
	}
	
	public static String noviRed(){
		if(sc.hasNextLine()){
			return sc.nextLine().trim();
		}
		else{
			return "";
		}
	}
	
	public static void main(String[] args){
		start();
	}
}