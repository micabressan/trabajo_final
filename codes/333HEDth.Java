import java.util.*;

public class Ex35 {

	static Scanner in = new Scanner(System.in);

	public static void input1(int a[]) {

		System.out.println("Array 1");
		
		for (int i = 0; i < a.length; i++) {

			System.out.println("Please enter a size at " + (i + 1));
			a[i] = in.nextInt();

		}

	}

	public static void input2(int b[]) {

		System.out.println("Array 2");

		for (int i = 0; i < b.length; i++) {

			System.out.println("Please enter a size at " + (i + 1));
			b[i] = in.nextInt();
		}

	}

	public static int[] shared(int a[], int[] b) {

		int count = 0;
		int c[] = new int[b.length];

		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < b.length; j++) {

				if (a[i] == b[j]) {
					c[count] = a[i];
					count++;
				}

			}
		}

		int newArray[] = new int[count];

		for (int i = 0; i < newArray.length; i++) {

			newArray[i] = c[i];
		}

		return c;

	}

	public static void main(String[] args) {

		int size1;
		int size2;

		int[] a;
		int[] b;
		int[] shared;

		System.out.println("please enter the size of array 'a'");
		size1 = in.nextInt();

		System.out.println("Please enter the size of array 'b'");
		size2 = in.nextInt();

		a = new int[size1];
		b = new int[size2];

		input1(a);
		input2(b);

		shared = shared(a, b);

		for (int i = 0; i < shared.length; i++) {
			System.out.print(shared[i]);
			System.out.print(",");
		}
	}
}