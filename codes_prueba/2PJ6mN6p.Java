import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class CircularListTest {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		int n = scanner.nextInt();
		int m = scanner.nextInt();
		CircularList<Integer> list = new CircularList<Integer>(n);
		try {
			list.rotateLeft(2);
		} catch (InvalidRotationException e) {
			System.out.println("InvalidRotationException");
		}
		for (int i = 0; i < n; ++i) {
			list.addElement(scanner.nextInt());
		}
		System.out.println(list);
		for (int i = 0; i < m; ++i) {
            int a = scanner.nextInt();
            System.out.println("ADD " + a);
			list.addElement(a);
			System.out.println(list);            
		}
		int r = scanner.nextInt();
		System.out.println("ROTATION LEFT " + r);
		try {
			list.rotateLeft(r);
		} catch (InvalidRotationException e) {
			System.out.println("InvalidRotationException");
		}
		System.out.println(list);
        r = scanner.nextInt();
		System.out.println("ROTATION RIGHT " + r);
		try {
			list.rotateRight(r);
		} catch (InvalidRotationException e) {
			System.out.println("InvalidRotationException");
		}
		System.out.println(list);
		int p = scanner.nextInt();
		System.out.println("ELEMENT ON POSITION " + p);
		try {
			System.out.println(list.getElement(p));
		} catch (InvalidIndexException e) {
			System.out.println("InvalidIndexException");
		}
        int x = scanner.nextInt();
        System.out.println("ADD " + x);
        list.addElement(x);
        System.out.println(list);
        System.out.println("ELEMENT ON POSITION " + (p + 1));
		try {
			System.out.println(list.getElement(p + 1));
		} catch (InvalidIndexException e) {
			System.out.println("InvalidIndexException");
		}
	}
}

class InvalidIndexException extends Exception{
	private static final long serialVersionUID = 1L;
	public InvalidIndexException(){}
}
class InvalidRotationException extends Exception{
	private static final long serialVersionUID = 1L;
	public InvalidRotationException(){}
}
class CircularList<T>{
	 List<T> broevi;
	private int broj;
	int i=0;
	public CircularList(int broj) {
		this.broj=broj;
		broevi=new ArrayList<T>(broj);
	}
	public void addElement(T element){
		
		if(broevi.size()<broj)	
		{
		broevi.add(element);
		}
		else{
			
			
			if(i==broj)
			{
				i=0;
			}
			broevi.remove(i);
			broevi.add(i, element);
			
			i++;
		}
	}
	public void rotateLeft(int k) throws InvalidRotationException{
		if(broevi.size()<broj){
			throw new InvalidRotationException();
		}
		Collections.rotate(broevi, -k);
		
	}
	public void rotateRight(int k) throws InvalidRotationException{
		if(broevi.size()<broj){
			throw new InvalidRotationException();
		}
		i--;
		Collections.rotate(broevi, k);
	}
	public T getElement(int n) throws InvalidIndexException{
		if(i>=broj){
			throw new InvalidIndexException();
		}
		if(n==1)
		return broevi.get(i+1);
		else
			return broevi.get(i);
	}
	@Override
	public String toString() {
		return broevi.toString();
	}
	
}