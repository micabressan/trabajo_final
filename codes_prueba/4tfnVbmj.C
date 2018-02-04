void comprobarEntorno(char ** tablero, int f, int c, int n, int m) {
	int i,j;
	for (i=f-1;i<=f+1;i++) {
		for (j=c-1;j<=c+1;j++) {
			if (tablero[i][j] == /* comprueba si hay un número */) {
				// Destapa el número
			} else if (tablero[i][j] == /* casilla vacía */) {
				// Destapa la casilla
				comprobarEntorno(tablero,i,j,n,m);
			}
		}
	}
}