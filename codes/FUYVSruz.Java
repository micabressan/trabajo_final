public class Postzentrale {

	private Postbote first = null;
    private String firstMessage = null;
 
    public boolean addPostbote(String name) {
        Postbote newPostman = new Postbote(name);
        if (first != null) {								// first ist am Anfang auf null gesetzt, damit das Spiel wieder auf den Anfangswert zurückgesetzt wird
            Postbote last = first;							// damit die Schleife immer von Anfang an (mit dem 1. Postboten) beginnt
            while (last.getNextPostbote() != null) {		
                last = last.getNextPostbote();
            }
            last.setNextPostbote(newPostman);				// der Postbote kennt immer nur den nächsten 
            return true;
        } else {
 
            this.first = newPostman;						// Max bleibt immer first
            return true;
        }
    }
 
    public void startGame(String message) {
        this.firstMessage = message;
 
        int numPostboten = 1;											
        Postbote last = this.first;										// damit es beim ersten Postboten anfängt zu zählen 
        while (last.getNextPostbote() != null) {						// der letzte kennt keinen nächsten = null
            last = last.getNextPostbote();								// die Schleife soll wieder durchlaufen mit dem nächsten Postboten
            numPostboten++;
        }
        last = this.first;
        if (numPostboten >= 3) {
            System.out.println(this.firstMessage);						// die unveränderte Nachricht soll auhc ausgegeben werden
 
            while (last.getNextPostbote() != null) { 					// der letzte Postbote kennt keinen nächsten Postboten, also = null
                last.setMessage(this.firstMessage);
                last.whisper();
                last.getNextPostbote().setMessage(last.getMessage()); 	// der nächste Postbote merkt sich die Nachricht von dem davor
                last = last.getNextPostbote();
 
            }
            last.whisper();												// damit der letzte auch noch flüstert
        } else {
            System.out.println("Es gibt nicht genug Postboten.");
        }
 
    }
	}