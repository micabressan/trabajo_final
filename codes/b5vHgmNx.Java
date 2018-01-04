 class Komputer {
     private String marka;
     private Procesor procesor;
     private int pamiec;
     public Komputer(String marka, String procesor, double czestotliwosc, int pamiec){
         this.marka = marka;
         this.procesor = new Procesor(procesor, czestotliwosc);
         this.pamiec = pamiec;
     }
     class Procesor {
         private String procesor;
         private double czestotliwosc;
         public Procesor(String procesor, double czestotliwosc){
             this.procesor = procesor;
             this.czestotliwosc = czestotliwosc;
         }

         public String toString(){
             return "Marka procesora: " + this.procesor + "\nCzestotliwosc procesora (GHz): " + this.czestotliwosc;
         }
     }
     public String toString(){
         return "Marka laptopa: " + this.marka + "\n" + this.procesor + "\n" + "Pamiec laptopa (MB): " + this.pamiec + "\n \n";

     }
    }
 public class Komputerek {
     public static void main(String[] args) {
         Komputer dell = new Komputer("Dell", "Pentium IV", 1.66, 1024);
         Komputer ibm = new Komputer("IBM", "AMD", 2.2, 2048);
         System.out.println(dell);
         System.out.println(ibm);
     }
 }