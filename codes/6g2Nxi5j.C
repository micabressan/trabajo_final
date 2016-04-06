int main()
{
	int codigo;
	int numFunc;
	int empPorte;

	//Maior código 1.
	int umCod = 0, umNum;
	int doCod = 0, doNum;
	int trCod = 0, trNum;
	int quCod = 0, quNum;

	do
	{
		scanf("%d", &codigo);

		if(codigo == 0){
			break;
		}

		scanf("%d %d", &numFunc, &empPorte);

		if(codigo == 1 && (umCod == 0 || umNum < numFunc))
		{
			umCod = codigo;
			umNum = numFunc;
		}
		else if(codigo == 2 && (doCod == 0 || doNum < numFunc))
		{
			doCod = codigo;
			doNum = numFunc;
		}
		else if(codigo == 3 && (trCod == 0 || trNum < numFunc))
		{
			trCod = codigo;
			trNum = numFunc;
		}
		else if(codigo == 4 && (quCod == 0 || quNum < numFunc))
		{
			quCod = codigo;
			quNum = numFunc;
		}
	}
	while(codigo != 0);

	if(umCod != 0){
		printf("Empresa grande com o código %d.\n", umCod);
	}

	if(doCod != 0){
		printf("Empresa média com o código %d.\n", doCod);
	}

	if(trCod != 0){
		printf("Empresa pequena com o código %d.\n", trCod);
	}

	if(quCod != 0){
		printf("Empresa micro com o código %d.\n", quCod);
	}

	return 0;
}