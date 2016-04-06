public void ajouterPoste(Poste poste)
	{
		int cpt = 0;
		while(tabPoste[cpt] != null)
		{
			cpt++;
		}
		tabPoste[cpt] = poste;
	}