//NB: Do not add a package

//NB: Importing classes in other packages is NOT ALLOWED.
//NB: Using classes in other packages in NOT ALLOWED (with the exception of the classes in java.lang.* that are imported by default)
import java.util.Scanner;

// NB: For the judge to run the program, do not modify the declaration of the class Main or
// method main() below. The class has to be declared as "class Main { ... }"
// and the method as "public static void main(String[] args) { ... }"

class Main2
{	
	public static boolean isEmpty (int positionnachher, int C, int[] cacti) {
		for (int x=0; x<C; x++) {
			if (cacti[x]==positionnachher) {
				return false;
			}
		}
		return true;
	}
	
	/** L is the length of the desert (positions in the desert are indexed from 0 to L-1) 
	 *  D is the distance Dino can jump, i.e., if Dino is at position p and it jumps, it lands at position p+D.
	 *  C is the number of cacti in the desert
	 *  cacti is an array of C elements containing the cacti positions, in increasing order. **/
	public static int solve(final int L, final int D, final int C, final  int[] cacti)
	{
		int position=0;
		
		while (position<=L) {
			if (L==0) {
				return 0;
			}
			if (isEmpty(position+D, C, cacti)) {
				position=position+D;
			}
			if (isEmpty(position+1, C, cacti)) {
				position=position+1;
			}
			if (!isEmpty(position+D, C, cacti) && !isEmpty(position+1, C, cacti)) {
				return position;
			}
			if (position+1>L || position+D>L) {
				return position;
			}

		}
		return position;
	}
	
	public static void main(String[] args)
	{
		Scanner scanner = new Scanner(System.in);
		//Scanner scanner = new Scanner(new File("example.in.txt"));
		int ntestcases = scanner.nextInt();
		
		for(int testno=0; testno<ntestcases; testno++)
		{
			int L = scanner.nextInt();
			int D = scanner.nextInt();
			int C = scanner.nextInt();
			
			int[] cacti = new int[C];
			for(int j=0; j<C; j++)
				cacti[j] = scanner.nextInt();

			System.out.println(solve(L, D, C, cacti));
		}
		
		scanner.close();
	}
}