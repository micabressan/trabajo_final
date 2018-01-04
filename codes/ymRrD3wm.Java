package UI;
import java .util.ArrayList;
public class Model {
	
	private ArrayList<String> Kleur;
	private ArrayList<String> Type;
	
public Model() {
		
		setKleur();
		setType();
	}

public ArrayList<String> getKleur() {
	return Kleur;
}

public void setKleur() {
	Kleur.add("rood");
	Kleur.add("zwart");
	Kleur.add("wit");
	Kleur.add("zilver");
	Kleur.add("blauw");
}

public ArrayList<String> getType() {
	return Type;
}

public void setType() {
	Type.add("BMW");
	Type.add("Audi");
	Type.add("Mercedes");
	
}
	
}