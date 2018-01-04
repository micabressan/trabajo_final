#include<iostream>
#include"aliohjelmat.h"

using namespace std;

int main() {

	int tuotteet[6] = {20,20,20,20,20,20};			//Tuotteet taulukon oletusarvoiksi kaikkiin 20 kpl
	int tila = 4, apu;								
	
	while (tila != 0) {
		
		if (tila == 4) {
			cout << "\nTervetuloa kaupan hallintapaneeliin!\n";
			tulostus(tuotteet);
			cout << "\nMit\x84 haluat tehd\x84? (1. Lis\x84\x84 tuotetta, 2. V\x84henn\x84 tuotetta, 3. Lopeta) : ";
			while (!(cin >> tila) || tila < 1 || tila > 3) {
				cout << "V\x84\x84ra sy\x94te, yrit\x84 uudelleen: ";
				cin.clear();
				cin.ignore();
			}
		}
		
		if (tila == 1) {
			cout << "\nMit\x84 tuotetta haluat lis\x84t\x84?\n(1. Maito, 2. Juusto, 3. Kana, 4. Tomaatti, 5. Banaani, 6. Kalja) ";
			while (!(cin >> apu) || apu < 1 || apu > 6) {
				cout << "V\x84\x84ra sy\x94te, yrit\x84 uudelleen: ";
				cin.clear();
				cin.ignore();
			}
	
			if (apu == 1) {
				add(apu, tuotteet);
				tila = 4;
			}
			if (apu == 2) {
				add(apu, tuotteet);
				tila = 4;
			}
			if (apu == 3) {
				add(apu, tuotteet);
				tila = 4;
			}
			if (apu == 4) {
				add(apu, tuotteet);
				tila = 4;
			}
			if (apu == 5) {
				add(apu, tuotteet);
				tila = 4;
			}
			if (apu == 6) {
				add(apu, tuotteet);
				tila = 4;
			}
			/*if (apu < 1 || apu > 6) {
				cout << "Sy\x94tt\x84m\x84si arvo on virheellinen! Palataan alkuvalikkoon...\n";
				tila = 4;
			}*/
		}

		if (tila == 2) {
			cout << "\nMit\x84 tuotetta haluat v\x84hent\x84\x84?\n(1. Maito, 2. Juusto, 3. Kana, 4. Tomaatti, 5. Banaani, 6. Kalja) ";
			while (!(cin >> apu) || apu < 1 || apu > 6) {
				cout << "V\x84\x84ra sy\x94te, yrit\x84 uudelleen: ";
				cin.clear();
				cin.ignore();
			}

			if (apu == 1) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			if (apu == 2) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			if (apu == 3) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			if (apu == 4) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			if (apu == 5) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			if (apu == 6) {
				vahenna(apu, tuotteet);
				tila = 4;
			}
			/*if (apu < 1 || apu > 6) {
				cout << "Sy\x94tt\x84m\x84si arvo on virheellinen!\n";
				tila = 4;
			}*/
		}

		if (tila == 3) {
			int varmistus;
			cout << "Haluatko varmasti sulkea ohjelman? (1. Kyll\x84, 2. Ei)";
			while (!(cin >> varmistus) || varmistus < 1 || varmistus > 2) {
				cout << "V\x84\x84ra sy\x94te, yrit\x84 uudelleen: ";
				cin.clear();
				cin.ignore();
			}
			if (varmistus == 1) {
				cout << "Kiitos ja n\x84kemiin!\n";
				tila = 0;
			}
		}
		/*if (tila < 0 || tila > 4) {
			cout << "Sy\x94tt\x84m\x84si arvo on virheellinen!\n";
			tila = 4;
		}*/
	}
	system("pause");
	return 0;
}