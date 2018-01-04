#include<iostream>
#include<string>
#include<fstream>
#include<iomanip>

using namespace std;

class regiune
{
	public:
		virtual void initializeaza_regiunea(int,int *) = 0;
		virtual float get_voturi_pentru() = 0;
		virtual float get_voturi_impotriva() = 0;
};

class factiune_religioasa:public regiune
{
		int numar_obligatie[5];
		int populatie;
		float voturi_pentru;
		float voturi_impotriva;
	public:
		factiune_religioasa();
		void initializeaza_regiunea(int,int[5]);
		void calculeaza_voturi_impotriva(int[5]);
		void calculeaza_voturi_pentru(int[5]);
		float get_voturi_impotriva();
		float get_voturi_pentru();
		int get_populatie();
		~factiune_religioasa(){};

};
factiune_religioasa::factiune_religioasa()
{
	populatie = 0;
	voturi_impotriva = 0;
	voturi_pentru = 0;
	for(int i=0;i<5;i++)
		numar_obligatie[i] = 0;
}
void factiune_religioasa::initializeaza_regiunea(int nr,int nr_obl[5])
{
	populatie = nr;
	for(int i=0;i<5;i++)
		numar_obligatie[i] = nr_obl[i];
}
void factiune_religioasa::calculeaza_voturi_pentru(int o[5])
{
	voturi_pentru = o[0]*1 + o[1]*0.8 + o[2]*0.6 + o[3]*0.4 + o[4]*0.2;
}
void factiune_religioasa::calculeaza_voturi_impotriva(int o[5])
{
	voturi_impotriva = o[0]*1 + o[1]*0.8 + o[2]*0.6 + o[3]*0.4 + o[4]*0.2;
}
float factiune_religioasa::get_voturi_pentru()
{
	return voturi_pentru;
}
float factiune_religioasa::get_voturi_impotriva()
{
	return voturi_impotriva;
}
int factiune_religioasa::get_populatie()
{
	return populatie;
}


class factiune_militara:public regiune
{
		int numar_persoane_functie[10];
		int populatie;
		float voturi_impotriva;
		float voturi_pentru;
	public: 
		factiune_militara();
		void initializeaza_regiunea(int,int[10]);
		void calculeaza_voturi_impotriva(int[5]);
		void calculeaza_voturi_pentru(int[5]);
		float get_voturi_impotriva();
		float get_voturi_pentru();
		int get_populatie_eligibila();
		~factiune_militara(){};
};
factiune_militara::factiune_militara()
{
	populatie = 0 ;
	voturi_pentru = 0;
	voturi_impotriva = 0;
	for(int i=0;i<10;i++)
		numar_persoane_functie[i] = 0; 
}
void factiune_militara::initializeaza_regiunea(int nr,int nr_functie[10])
{
	populatie = nr;
	for(int i=0;i<10;i++)
	{
		numar_persoane_functie[i] = nr_functie[i];
	}
}
void factiune_militara::calculeaza_voturi_pentru(int nr_voturi[5])
{
	voturi_pentru = 10*nr_voturi[0] + 9*nr_voturi[1] + 8*nr_voturi[2] + 7*nr_voturi[3] + 6*nr_voturi[4];
}
void factiune_militara::calculeaza_voturi_impotriva(int nr_voturi[5])
{
	voturi_impotriva = 10*nr_voturi[0] + 9*nr_voturi[1] + 8*nr_voturi[2] + 7*nr_voturi[3] + 6*nr_voturi[4];
}
float factiune_militara::get_voturi_pentru()
{
	return voturi_pentru;
}
float factiune_militara::get_voturi_impotriva()
{
	return voturi_impotriva;
}
int factiune_militara::get_populatie_eligibila()
{
	int populatie_eligibila = 0;
	for (int i=0;i<5;i++)
		populatie_eligibila += numar_persoane_functie[i];
	return populatie_eligibila;
}

class factiune_varsta:public regiune
{
	int populatie;
	int varsta_minima;
	float voturi_pentru;
	float voturi_impotriva;
	int numar_categorie_varsta[4];
	public:
		factiune_varsta();
		void initializeaza_regiunea(int,int[4]);
		void calculeaza_voturi_impotriva(int);
		void calculeaza_voturi_pentru(int);
		void set_varsta_minima(int);
		float get_voturi_impotriva();
		float get_voturi_pentru();
		int get_populatie_eligibila();
		~factiune_varsta(){};
};
factiune_varsta::factiune_varsta()
{
	populatie = 0;
	varsta_minima = 0;
	voturi_pentru = 0;
	voturi_impotriva = 0;
	for(int i=0;i<4;i++)
		numar_categorie_varsta[i] = 0;
}
void factiune_varsta::initializeaza_regiunea(int nr,int nr_categorie[4])
{
	populatie = nr;
	for(int i=0;i<4;i++)
		numar_categorie_varsta[i] = nr_categorie[i];
}
void factiune_varsta::calculeaza_voturi_pentru(int nr)
{
	voturi_pentru = nr;
}
void factiune_varsta::calculeaza_voturi_impotriva(int nr)
{
	voturi_impotriva = nr;
}
void factiune_varsta::set_varsta_minima(int a)
{
	varsta_minima = a;
}
float factiune_varsta::get_voturi_pentru()
{
	return voturi_pentru;
}
float factiune_varsta::get_voturi_impotriva()
{
	return voturi_impotriva;
}
int factiune_varsta::get_populatie_eligibila()
{
	int populatie_eligibila = 0;
	int aux;
	if (varsta_minima == 14)
		aux = 3;
	else if (varsta_minima == 20)
		 aux = 2;
	else 
		aux = 1;
	for (int i=0;i<aux;i++)
		populatie_eligibila += numar_categorie_varsta[3-i];
	return populatie_eligibila;
}

void rezolva_cerinta(ifstream &f,ofstream &f4,factiune_religioasa &f1,factiune_militara &f2,factiune_varsta &f3)
{
	int a,a1,a2,a3,b[4],c[5],d[10];
	char x[2];
	//char buffer[50];
	string buffer;
	f>>a;
	f>>a;
	for(int i=0;i<5;i++)
		f>>c[i];
	f1.initializeaza_regiunea(a,c);
	f>>a;
	f>>a;
	for(int i=0;i<10;i++)
		f>>d[i];
	f2.initializeaza_regiunea(a,d);
	f>>a;
	f>>a;
	for(int i=0;i<4;i++)
		f>>b[i];
	f3.initializeaza_regiunea(a,b);
	for(int i=0;i<3;i++)
	{
		f>>a;
		f>>a1;
		if(a1 == 3)
			f>>a2;
		if(a1 == 1)
		{
			f4<<"Zona 1"<<endl;
			for(int i=0;i<a;i++)
			{
				int suma = 0;
				getline(f,buffer);
				getline(f,buffer);
				f>>x[0];
				f>>x[1];
				for(int i=0;i<5;i++)
				{
					f>>c[i];
					suma = suma + c[i];
				}
				f1.calculeaza_voturi_pentru(c);
				f>>x[0];
				f>>x[1];
				for(int i=0;i<5;i++)
				{
					f>>c[i];
					suma = suma + c[i];
				}
				f1.calculeaza_voturi_impotriva(c);
				f4<<buffer<<endl;
				if(f1.get_voturi_pentru() > f1.get_voturi_impotriva())
				{
					f4<<"Aprobat "<<f1.get_voturi_pentru()<<" - "<<f1.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f1.get_populatie() * 100<<"\%"<<endl;
				}
				else if(f1.get_voturi_pentru() < f1.get_voturi_impotriva())
				{
					f4<<"Respins "<<f1.get_voturi_pentru()<<" - "<<f1.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f1.get_populatie() * 100<<"\%"<<endl;
				}
				else
				{
					f4<<"Egalitate "<<f1.get_voturi_pentru()<<" - "<<f1.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f1.get_populatie() * 100<<"\%"<<endl;
				}
			}
		}
		else if(a1 == 2)
		{
			f4<<"Zona 2"<<endl;
			for(int i=0;i<a;i++)
			{
				int suma = 0;
				getline(f,buffer);
				getline(f,buffer);
				f>>x[0];
				f>>x[1];
				for(int i=0;i<5;i++)
				{
					f>>c[i];
					suma = suma + c[i];
				}
				f2.calculeaza_voturi_pentru(c);
				f>>x[0];
				f>>x[1];
				for(int i=0;i<5;i++)
				{
					f>>c[i];
					suma = suma + c[i];
				}
				f2.calculeaza_voturi_impotriva(c);
				f4<<buffer<<endl;
				if(f2.get_voturi_pentru() > f2.get_voturi_impotriva())
				{
					f4<<"Aprobat "<<f2.get_voturi_pentru()<<" - "<<f2.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f2.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
				else if(f2.get_voturi_pentru() < f2.get_voturi_impotriva())
				{
					f4<<"Respins "<<f2.get_voturi_pentru()<<" - "<<f2.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f2.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
				else
				{
					f4<<"Egalitate "<<f2.get_voturi_pentru()<<" - "<<f2.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f2.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
			}
		}
		else
		{
			f4<<"Zona 3"<<endl;
			for(int i=0;i<a;i++)
			{
				int suma = 0;
				getline(f,buffer);
				getline(f,buffer);
				f>>x[0];
				f>>x[1];
				f>>a3;
				suma += a3;
				f3.calculeaza_voturi_pentru(a3);
				f>>x[0];
				f>>x[1];
				f>>a3;
				suma += a3;
				f3.calculeaza_voturi_impotriva(a3);
				f4<<buffer<<endl;
				f3.set_varsta_minima(a2);
				if(f3.get_voturi_pentru() > f3.get_voturi_impotriva())
				{
					f4<<"Aprobat "<<f3.get_voturi_pentru()<<" - "<<f3.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f3.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
				else if(f3.get_voturi_pentru() < f3.get_voturi_impotriva())
				{
					f4<<"Respins "<<f3.get_voturi_pentru()<<" - "<<f3.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f3.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
				else
				{
					f4<<"Egalitate "<<f3.get_voturi_pentru()<<" - "<<f3.get_voturi_impotriva()<<" "
					<<setprecision(0)<<fixed<<(float)suma/f3.get_populatie_eligibila() * 100<<"\%"<<endl;
				}
			}

		}

	}
}

int main(int argc,char ** argv)
{
	factiune_religioasa f1;
	factiune_militara f2;
	factiune_varsta f3;
	ifstream f;
	ofstream f4;
	f.open(argv[1]);
	f4.open(argv[2]);
	if(f.is_open() && f4.is_open())
		rezolva_cerinta(f,f4,f1,f2,f3);
	f.close();
	f4.close();
	return 0;
}