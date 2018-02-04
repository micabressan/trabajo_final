import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class Main {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		Drzewo d = new Drzewo();
		String line;
		while((line = br.readLine()) != null) {
			char[] c = line.toCharArray();
			if (c.length > 1) {
				char[] path = line.substring(2, line.length() - 1).toCharArray();
				char name = c[0];
				d.addWezel(name, path);
			} else {
				char name = c[0];
				d.addWezel(name);
			}

		}
		d.najstarszyWyraz();
		System.out.println(d.old);
		System.out.println(d.key);
		br.close();
	}

}

class Drzewo {
	List<Wezel> l;
	int key;
	Wezel root;
	Wezel focus = root;
	char[] path;
	Wezel newNode;
	String old;
	
	public Drzewo() {
		l = new ArrayList<>();
		key = 0;
	}

	void rek() {
		if (path != null) {
			for (int i = 0; i < path.length; i++) {
				if (path[i] == 'L') {
					focus.left = newNode;
					newNode.parent = focus;
					rek();
				} else if(path[i] == 'R') {
					focus.right = newNode;
					newNode.parent = focus;
					rek();
				}
			}
		}
	}
	
	void addWezel(char name, char[] path) {
		key++;
		newNode = new Wezel(name, key);
		l.add(newNode);
		focus = root;
		rek();
	}
	
	public void addWezel(char name) {
		key++;
		newNode = new Wezel(name, key);
		l.add(newNode);
		root = newNode;
		
	}
	
	void najstarszyWyraz() {
		if((int)focus.left.name < (int)focus.right.name) {
			focus = focus.left;
			old += focus;
			najstarszyWyraz();
		} else if((int)focus.left.name > (int)focus.right.name) {
			focus = focus.right;
			old += focus;
			najstarszyWyraz();
		}
	}
}

class Wezel {
	int key;
	char name;
	Wezel left;
	Wezel right;
	Wezel parent;

	
	public Wezel(char name, int key) {
		this.name = name;
		this.key = key;
	}

}