public class Vigenere {
	
	static String abc = "abcdefghijklmnopqrstuvwxyz";
	
	static char[][] table = new char[abc.length()][abc.length()];
	
	public static void main(String[] args) {
		
		System.out.println("Enter key for encryption:");
		Scanner scanner = new Scanner(System.in);
		String key = scanner.nextLine();
		
		System.out.println("Enter text to encrypt:");
		String original = scanner.nextLine();
		
		scanner.close();
		
		int index = 0;
		int offset = 0;
		for(int i = 0; i < abc.length(); i++) {
			for(int j = 0; j < abc.length(); j++) {
				if(index >= abc.length()) index -= abc.length();
				table[i][j] = abc.charAt(index);
				index++;
			}
			offset++;
			index = offset;
		}
		
		int orig_length = original.length();
		int key_length = key.length();
		int multip = (orig_length / key_length) + 1;
		for(int i = 0; i < multip; i++) {
			key += key;
		}
		key = key.substring(0, original.length());
		
		String encrypted = "";
		for(int i = 0; i < original.length(); i++) {
			
			if(original.charAt(i) == ' ') {
				encrypted += " ";
				continue;
			}
			
			char oc = original.charAt(i);
			char kc = key.charAt(i);
			
			int oi = abc.indexOf(oc);
			int ki = abc.indexOf(kc);
			
			encrypted += table[oi][ki];
			
		}
		
		System.out.println("\nEncrypted text: ");
		System.out.println(encrypted);
		
	}

}