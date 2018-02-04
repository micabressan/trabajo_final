import java.util.Scanner;

public class AlphabetNumbers {

	public static void main(String args[]) {

		System.out.print("Enter the number: ");
		Scanner input = new Scanner(System.in);
		String phoneNumber = input.nextLine();

		String abc = "[abcABC]";
		String def = "[defDEF]";
		String ghi = "[ghiGHI]";
		String jkl = "[jklJKL]";
		String mno = "[mnoMNO]";
		String pqrs = "[pqrsPQRS]";
		String tuv = "[tuvTUV]";
		String wxyz = "[wxyzWXYZ]";

		phoneNumber = phoneNumber.replaceAll("\\s", "");
		phoneNumber = phoneNumber.replaceAll(abc, "2");
		phoneNumber = phoneNumber.replaceAll(def, "3");
		phoneNumber = phoneNumber.replaceAll(ghi, "4");
		phoneNumber = phoneNumber.replaceAll(jkl, "5");
		phoneNumber = phoneNumber.replaceAll(mno, "6");
		phoneNumber = phoneNumber.replaceAll(pqrs, "7");
		phoneNumber = phoneNumber.replaceAll(tuv, "8");
		phoneNumber = phoneNumber.replaceAll(wxyz, "9");

		int numberLength = phoneNumber.length();

		if (numberLength == 10) {
			// xxx.xxx.xxxx normal phone number
			System.out.print("The number to dial is ");
			System.out.print(phoneNumber.substring(0, 3) + " ");
			System.out.print(phoneNumber.substring(3, 6) + " ");
			System.out.print(phoneNumber.substring(6, 10));

		} else if (numberLength == 11) {
			// x.xxx.xxx.xxxx United States code
			System.out.print("The number to dial is ");
			System.out.print(phoneNumber.substring(0, 1) + " ");
			System.out.print(phoneNumber.substring(1, 4) + " ");
			System.out.print(phoneNumber.substring(4, 7) + " ");
			System.out.print(phoneNumber.substring(7, 11));
			
		} else {
			// all of the other phone numbers
			System.out.println("Pick a new phone number!!");
			
		}

	}
	
}