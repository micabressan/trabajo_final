import java.util.*;

public class Ex35Page92 {

	static Scanner in = new Scanner(System.in);

	
	public static void input (int[] a){
		
		for(int i=0; i<a.length; i++){
			
			System.out.println("Please enter a size at " + i+1);
			a[i]=in.nextInt();
			
		}
	}
	
	
	
	
	
	
	public static int[] zugiMispar(int[] a) {

		int zugiArray[] = new int[a.length];
		int count = 0;

		for (int i = 0; i < a.length; i++) {

			if (a[i] % 2 == 0) {

				zugiArray[count] = a[i];
				count++;

			}
		}

		int[] newarr = new int[count];

		for (int i = 0; i < newarr.length; i++) {

			newarr[i] = zugiArray[i];
		}

		return newarr;

	}

	public static int[] negative(int[] a) {

		int[] negativeArray = new int[a.length];
		int count = 0;

		for (int i = 0; i < a.length; i++) {

			if (a[i] < 0) {
				negativeArray[count] = a[i];
				count++;
			}

		}
		
		int [] newarr = new int[count];
			
			for(int i=0; i<newarr.length; i++){
				
				newarr[i] = negativeArray[i];
				                      
			}
			
			return newarr;
		}
	
	public static void main(String [] args){
		
		int size;
		int a [];
		int zugimispar [];
		int negativenumber [];
		
		System.out.println("Please enter the size of the array");
		size=in.nextInt();
		
		a = new int [size];
		
	    input(a);

	    zugimispar=zugiMispar(a);
	    
	    System.out.println("The zugi numbers: ");
	    for(int i=0; i<zugimispar.length; i++){
	    	System.out.print(zugimispar[i]);
	    }
	    
	    System.out.println();
	    
	    
	    negativenumber = negative(a);
	    
	    System.out.println("The negative numbers : ");
	    for(int i=0; i<negativenumber.length; i++){
	    	System.out.print(negativenumber[i]);
	    
	  
	    }
	}

}