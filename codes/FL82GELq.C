// ESERCIZIO 7

typedef struct 
{
	char cognome [20];
	int giorno;
	
}prenotazione;



void prenot_in_data(prenotazione mese[], int giorno, int trovato)
{
	if (trovato)
	{
		printf("giorno %d %d \n",giorno, 1 );
	}
	else
		printf("giorno %d %d \n", giorno, 0 );

}

void giorni_no_prenot(prenotazione mese[])
{
	int i, k, trovato, dim = 0 ;
	int vett_giorni[30];
	for ( i = 1; i <= 30; ++i)
	{
		trovato = 0;
		for ( k = 0; k < 21; ++k)
		{
			if (i == mese[k].giorno)
			
				trovato++;
		}

		if (!trovato)
		{
			vett_giorni[dim] = i;
			dim++;
		}
			

		prenot_in_data(mese, i, trovato);

	}

	for ( i = 0; i < dim; ++i)
	{
		printf("%d\n",vett_giorni[i] );
	}

}



int main()
{


	prenotazione luglio[30] = {
	{"Alberti",1},
	{"Baldoni",17},
	{"Bonfe",6},
	{"Bottazzi",25},
	{"Busi",18},
	{"Chesani",15},
	{"Franciosi",11},
	{"Giordano",27},
	{"Lamma",25},
	{"Leonardi",23},
	{"Martelli",6},
	{"Mascardi",26},
	{"Mello",22},
	{"Maio",16},
	{"Naponiello",10},
	{"Neri",1},
	{"Rossi",3},
	{"Toni",11},
	{"Torroni",5},
	{"Vecchi",5},
	{"Verdi",30}
	};


	giorni_no_prenot(luglio);


}