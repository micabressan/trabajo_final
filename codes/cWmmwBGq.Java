public static void verschiebe(Object[] werte){ //void -> kein Rückgabewert

int x = werte.length; //Welche Länge hat das vorgegebene Array?
Object[] array2 = array2[x]; //Neues Ersatzarray erstellen.

array2[0] = werte[x-1]; //ersten Wert setzen = letzter Wert vom erhaltenen Array -> sonst Array an der Stelle -1. (abc -> _ab)

for (int i = 1; i < x; i++){ //for-Schleife: Startewert 1 -> 0 schon belegt (s.o.); i<x -> endet beim Ende der Länge von werte[]; i++ -> 
															       Hochzählen
	array2[i] = werte[i-1]; //Objekt an der Arraypostion werte[i-1] koppiert zur Arrayposition array2[i]				
}

for (int i = 0; i<x; i++){ //Arraykopieren wie oben nur ohne Verschiebung
	werte [i] = array [i];
}

}