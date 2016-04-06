#define N 20

struct data {
	int anno;
	int mese;
	int giorno;
};

struct persona {
	char nome[N];
	char cognome[N];
	data nascita; //Questa e' la parte difficile, capire che c'e' qiesta struct dentro l'altra
	int n_figli;
};