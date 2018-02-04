
package Compteur;

import java.util.Observable;
import java.util.Observer;
/**
 *
 * @author Djeezus
 */
public class Compteur extends Observable{
   
    public Compteur(Fenetre vue)
    {
        valeur = 0;
        this.addObserver(vue);
    }
    
    public void increment()
    {
        valeur++;
        this.notifyObservers(valeur);
    }
    
    public void decrement()
    {
        valeur--;
        this.notifyObservers(valeur);
    }
    
    public void toFenetre(Fenetre vue, Console vueConsole)
    {
        this.addObserver(vue);
        this.deleteObserver(vueConsole);
    }
    
    public void toConsole(Fenetre vue, Console vueConsole)
    {
        this.addObserver(vueConsole);
        this.deleteObserver(vue);
    }
    
    
    private int valeur;
}