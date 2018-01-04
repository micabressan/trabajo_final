public class test{

  class Cell<T>{
    T first;
    Cell<T> next;
    Cell(T h, Cell<T> t){
      first = h;
      next = t;
    }
  }

  static List[] array = new List[10];

  public static int hashFunction(String a){
    int sum = 1;
    for(int i = 0; i<a.length(); i++){
      char b = a.charAt(i);
      int value = (int) b;
      sum *= value;
    }
    return sum % array.length;
  }

  public static void arraySetter(String a){
      int position = hashFunction(a);
      if(array[position] == null){
        array[position] = a;
      }else{
        //var = array[position]
        // list = myList
        // mylist.insert(var)
        // array[position] = list
      }
    }

    public static void printArray(){
      for(int i = 0; i<array.length; i++){
        System.out.println(array[i]);
      }
    }


  public static void main(String[] args) {
      arraySetter("Yusuf");
      printArray();
  }

}