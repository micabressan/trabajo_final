public class ArbeidsUke {
  public static void main ( String [] args ){

        // setter verdiene
        double timerPerDag = 7.5;
        int arbeidsdagerIUken = 5;
        int antallUker = 4; 

        // regner ut det totale antall arbeidstimer i uken
        double timerIUken = timerPerDag * arbeidsdagerIUken;
         
        //regner ut totale timer per måned
        double antallTimerPerMaaned = timerIUken * antallUker;

        // skriver ut resultatet
        System.out.print(timerPerDag);
        System.out.print(" arbeidstimer ");
        System.out.print(arbeidsdagerIUken);
        System.out.print(" dager i uken blir ");
        System.out.print(timerIUken);
        System.out.println(" timer i uken.");
        
        System.out.print(timerPerDag);
        System.out.print(" arbeidstimer ");
        System.out.print(arbeidsdagerIUken);
        System.out.print(" dager i uken i ");
        System.out.print(antallUker);
        System.out.print(" uker blir omtrent ");
        System.out.print(antallTimerPerMaaned);
        System.out.println(" timer per maaned.");
        
        System.out.println(timerPerDag + " arbeidstimer " + arbeidsdagerIUken + " dager i uken blir " + timerIUken + " timer i uken");
        System.out.println(timerPerDag + " arbeidstimer " + arbeidsdagerIUken + " dager i uken i " + antallUker + " uker blir omtrent " + antallTimerPerMaaned + " timer per maaned");
    }
}