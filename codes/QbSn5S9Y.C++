//ZADANIE 4
void sprawdz(char *znaki, char *slowo) {
	int dlSlowo = strlen(slowo);
	int licznik = 0;
	for (int i = 0; i < dlSlowo; i++) {
		for (int j = 0; j < strlen(znaki); j++) {
			if (slowo[i] == znaki[j]) {
				licznik++;
				break;
			}
		}
	}

	if (licznik == dlSlowo)
		cout << "TAK!" << endl;
	else
		cout << "NIE!" << endl;
}

void zad4() {
	system("cls");
	char znaki[10], slowo[10];

	cout << "Podaj znaki i slowo: ";
	cin >> znaki >> slowo;

	cout << "Czy mozna stworzyc: ";
	sprawdz(znaki, slowo);
	cout << endl;

	system("pause");
}