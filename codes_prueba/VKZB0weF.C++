int main()
{

	Ugyintezo ugy("asd");
	Tanar tanci("bazsi");
	Rendszergazda gazda("Toth_Istvan");
	list<Tanar> tanarlista;
	list<Ugyintezo> ugyintezolista;
	list<Rendszergazda> rendszergazdalista;
	list<Terem*> teremlista;
	string innev;
	rendszergazdalista.push_back(gazda);
	cout << "Adja meg a tanarok neveit felvetelhez:\n";
	string in;
	cin >> in;
	while (in != "*") {
		gazda.tanarFelvitel(in, tanarlista);
		cin >> in;
	}
	cout << "Adja meg a ugyintezok neveit felvetelhez:\n";
	cin >> in;
	while (in != "*") {
		gazda.ugyintezoFelvitel(in, ugyintezolista);
		cin >> in;
	}
	int command = 0;
	while (command != 9)
	{
		cout << "Adjon meg felhasznalo tipust:\n"
			"1: Rendszergazda\n"
			"2: Tanar\n"
			"3: Ugyintezo\n"
			"9: Kilepes \n" << endl;

		cin >> command;
		switch (command)
		{
		case 1:
		{
			cout << "Adja meg a nevet:";
			string in_;
			cin >> in_;

			bool letezik = false;
			for (auto i : rendszergazdalista) {
				if (i.getName() == in_) {
					letezik = true;
					break;
				}
			}
			if (!letezik)
			{
				cout << "Illetektelen hozzaferes!\n";
				break;
			}
			int cmd = 0;
			while (cmd != 9)
			{
				cout << "1: Tagok modositasa \n"
					"2: Kereses\n"
					"3: Listazas\n"
					"9: Kilepes" << endl;
				cin >> cmd;
				switch (cmd)
				{
				case 1:
				{
					cout << "1: Tanar modositas\n"
						"2: Ugyintezo modositas\n";
					int in__;
					cin >> in__;
					if (in__ == 1) {
						for (auto it : tanarlista)
						{
							cout << it.getName() << endl;
						}
						cout << "Modositani kivant tanar neve:\n";
						string tann;
						cin >> tann;
						bool vane;
						for (auto &i : tanarlista) {
							if (i.getName() == tann) {
								vane = true;
								cout << "Mire modositsuk?" << endl;
								string mire;
								cin >> mire;
								i.setName(mire);
								break;
							}

						}
						if (vane != true)
							cout << "Nincs ilyen tanar" << endl;

					}

					if (in__ == 2) {
						for (auto it : ugyintezolista)
						{
							cout << it.getName() << endl;
						}
						cout << "Modositani kivant ugyintezo neve:\n";
						string tann;
						cin >> tann;
						bool vane;
						for (auto &i : ugyintezolista) {
							if (i.getName() == tann) {
								vane = true;
								cout << "Mire modositsuk?" << endl;
								string mire;
								cin >> mire;
								i.setName(mire);
								break;
							}
						}
						if (vane != true)
							cout << "Nincs ilyen ugyintezo" << endl;

					}


					break;
				}
				case 2:
				{
					break;
				}
				case 3:
				{
					// ugy.listaz(teremlista);
					break;
				}
				case 9:
				{
					break;
				}
				}
			}
			break;
		}

		case 2:
		{
			cout << "Adja meg a nevet:";
			string in_;
			cin >> in_;
			bool letezik = false;
			for (auto i : tanarlista) {
				if (i.getName() == in_) {
					letezik = true;
					break;
				}
			}
			if (!letezik)
			{
				cout << "Illetektelen hozzaferes!\n";
				break;
			}
			int cmd = 0;
			while (cmd != 9)
			{
				cout << "1: Terem foglalas \n"
					"2: Terem leadas\n"
					"3: Kereses\n"
					"4: Listazas\n"
					"9: Kilepes" << endl;
				cin >> cmd;
				switch (cmd)
				{

				case 1:
				{

					                                string teremnev;
					                                string nap;
					                                int kezd,veg;
					                                cout<<"Adja meg a lefoglalni kivant terem nevet: \n";
					                                cin>>teremnev;
					                                while(teremnev!="*")
					                                {
					                                    cout<<"Adja meg melyik nap: \n";
					                                    cin>>nap;
					                                    cout<<"Mikortol?\n";
					                                    cin>>kezd;
					                                    cout<<"Meddig?\n";
					                                    cin>>veg;
					                                    tanci.teremFoglalas(teremnev,nap,kezd,veg,teremlista);
					                                    cout<<"Adja meg a lefoglalni kivant terem nevet: \n";
					                                    cin>>teremnev;

					                                }
					break;

				}
				}
			}
			break;

		}
		case 3:
		{
			cout << "Adja meg a nevet:";
			string in_;
			cin >> in_;
			bool letezik = false;
			for (auto i : ugyintezolista) {
				if (i.getName() == in_) {
					letezik = true;
					break;
				}
			}
			if (!letezik)
			{
				cout << "Illetektelen hozzaferes!\n";
				break;
			}
			int cmd = 0;
			while (cmd != 9)
			{
				cout << "2: Idopont modositas\n"
					"3: Terem felvitel\n"
					"4: Terem modositas\n"
					"5: Kereses\n"
					"6: Listazas\n"
					"9: Kilepes" << endl;
				cin >> cmd;
				switch (cmd)
				{
				case 2:
				{
					int kezdo, vege;
					cout << "Adja meg a kezdo idopontot" << endl;
					cin >> kezdo;
					cout << "Adja meg a veg idopontot" << endl;
					cin >> vege;
					ugy.idopontModositas(kezdo, vege, teremlista);
					break;
				}

				case 3:
				{

					string ter;
					cout << "Adja meg a terem nevet" << endl;
					while (ter != "*")
					{

						ugy.teremFelvitel(ter, teremlista);
						cin >> ter;
					}

					break;
				}

				case 4:
				{

					for (auto it : teremlista)
					{
						cout << it->getTeremNev() << endl;
					}
					string t;
					cout << "Adja meg a termet, amit modositani akar!" << endl;
					cin >> t;
					ugy.teremModositas(t, teremlista);
					break;
				}
				}
			}

		}

		}
	}
	return 0;
}