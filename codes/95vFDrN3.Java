public class Stos {

  private int size;
  private String tab[];

  public Stos(int size) {
    this.size = size;
    this.tab = new String[size + 1];
  }

  public void push(String s) throws Exception{

    int i = 0;

    while (tab[i] != null && i < size) {
      i++;
    }

    if (i == size) {
      throw new Exception("Stos jest pelny");
    }

    tab[i] = s;

  }

  public String pop() throws Exception {

    int i = 0;

    while (tab[i] != null && i < size) {
      i++;
    }

    if (i > 0) {

      String string = tab[i - 1];

      tab[i - 1] = null;

      return string;
    } else {
      throw new Exception("Stos jest pusty");
    }

  }

  public static void main(String[] args) {
    Stos stos = new Stos(3);
    try {
      stos.push("b");
      stos.push("c");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");
      stos.push("a");

    } catch (Exception e) {
      e.printStackTrace();
    }

    try {
      stos.pop();
      stos.pop();
      stos.pop();
      stos.pop();
      stos.pop();
      stos.pop();

    } catch (Exception e) {
      e.printStackTrace();
    }

  }

}