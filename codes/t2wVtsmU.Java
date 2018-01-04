 class Komputer {
     private String marka;
     private Procesor procesor;
     private int pamiec;
     public Komputer(String marka, String procesor, double czestotliwosc, int pamiec){
         this.marka = marka;
         this.czestotliwosc = czestotliwosc;
         this.procesor = procesor;
         this.pamiec = pamiec;
     }
     class Procesor {
         private String marka;
         private double czestotliwosc;
         public Procesor(String marka, double czestotliwosc){
             this.marka = marka;
             this.czestotliwosc = czestotliwosc;
         }
         public void rezerwujPamiec(int)
         public void zwolnijPamiec(int);

         public String toString();
     }
     public String toString();
    }
 public class Komputerek {
     public static void main(String[] args) {
         Komputer dell = new Komputer("Dell", "Pentium IV", 1.66, 1024);
         Komputer ibm = new Komputer("IBM", "AMD", 2.2, 2048);
         System.out.println(dell);
     }
 }