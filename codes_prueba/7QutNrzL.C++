#include <iostream>
#include <cstring>
#include <fstream>
#include <ctime>
#include <ctype.h>
#include <cstdlib>
#include <conio.h>
#include <time.h>
#include <windows.h>
#include <locale.h>

using namespace std;

enum 
{
	CONST_NAME_CHECK,
	CONST_PASSWORD_CHECK,
	CONST_NUMBER_CHECK
};

ifstream file;
ofstream out_file;

struct Register
{
	char name[100], password[10], ID[1000];
	
	void writeIntoFile(bool isClient);
};

Register Band_Aid;

struct no 
{ 
	int info;
	Register data;
	no *esq, *dir; 
};

typedef no* noptr;

struct FlightInfo
{
	int ID, ticket_price, tickets, total_tickets;
	char company[100], plane[50], time[6], date[11], destiny[100];
	
	void bookFlight();
};

void inseredir(noptr &p, int x);
void inseredirStruct(noptr &p, Register x);
void criad(noptr &lista, int x, Register info);
void SetColor(int ForgC);
void writeInColor(const char* phrase, int color);
void clientMenu();
void companyMenu();
void Login(char name[], char password[], bool registered, bool client);
void signUp();
bool isStringValid(char str[], int check_type);
void adjustName(char name[]);
int getIndexesSize(char* line, char split_character);
void getIndexesBySplittingSentence(char* line, char split_character, int j[]);
int getNameOccurrences(char name[], bool isClient);
void fillSentence(char line[], int begin, int end, char target[]);
void toLower(char w[]);
int getYesOrNo();
bool checkCombination(char login[], char password[], bool isClient);
void clientLogin(char login[], char password[]);
void companyLogin(char login[], char password[]);
int getFileLineCount(const char* file_name);
void bookFlight(char name[]);
void checkFlights(char name[], bool isClient, bool all);
bool isFlightBooked(char name[], int ID);
void cancelFlight(char name[]);
void buyTickets(char name[], int count);
void updateClientIDInfo(char name[], int ID, int count);
bool isIDValid(int ID);
void resetClientsIDs(int ID);

int main()
{
	bool _time = true, program_running = true;
	setlocale(LC_ALL, "Portuguese");
	system("color F0");
	
	cout << "-----------------------------------------------------------------------" << endl;
	cout << "************** BEM VINDO AO SISTEMA DE CONTROLE DE AEROPORTOS **************" << endl;
	cout << "-----------------------------------------------------------------------" << endl << endl;
	
	while(program_running)
	{
		if(!_time) system("CLS");
		
		char action[10];
		cout << "-----------------------------------------------------------------------" << endl;
	   	cout << "          ************* VOCÊ DESEJA *************" << endl << endl;
		
		cout << "       -> ";
		writeInColor("entrar", 9);
		cout << endl << "       -> ";
		writeInColor("registrar", 9);
		cout << endl << "       -> ";
		writeInColor("sair", 4);
		cout << endl << endl << "-----------------------------------------------------------------------" << endl << endl;
		
		_time = false;
		
		cin.getline(action, 10);
		
		toLower(action);
		
		system("CLS");
		
		char login[100], password[100];
		
		if(strcmp(action, "entrar") == 0)
			Login(login, password, false, false);
		else if(strcmp(action, "registrar") == 0)
			signUp();
		else if(strcmp(action, "sair") == 0) program_running = false;
	}
}

void SetColor(int ForgC)
{
	WORD wColor;
	
	HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	
	if(GetConsoleScreenBufferInfo(hStdOut, &csbi))
	{
		wColor = (csbi.wAttributes & 0xF0) + (ForgC & 0x0F);
		SetConsoleTextAttribute(hStdOut, wColor);
	}
	
	return;
}

void writeInColor(const char* phrase, int color)
{
	SetColor(color);
	cout << phrase;
	SetColor(0);
}

bool isStringValid(char str[], int check_type)	
{
	if(check_type == CONST_NAME_CHECK)
	{
		bool check_name_logic = false;
		
		if(strlen(str) < 3)
		{
			cout << "-> Nome muito curto!" << endl;
			return false;
		}
		
		for(unsigned int i = 0; i < strlen(str); i++)
		{
			if(isalpha(str[i]))
				check_name_logic = true;
            else if(!isspace(str[i])) return false;
		}
		
		if(!check_name_logic) return false;
	}
	else if(check_type == CONST_NUMBER_CHECK)
	{
		for(unsigned int i = 0; i < strlen(str); i++)
			if(!isdigit(str[i]))
				return false;
	}	
    else
	{
		unsigned int max = 10;
	
		if(strlen(str) < 4 || strlen(str) > max) return false;
		
		for(unsigned int i = 0; i < strlen(str); i++)
			if(!isalpha(str[i]) && !isdigit(str[i]))
				return false;
	}
		
    return true;
}

void signUp()
{
	bool continue_loop = true;
	
	while(continue_loop)
	{
		bool isClient, wrongAnswer = false;
		
		if(wrongAnswer)
		{
			writeInColor("          OPERAÇÃO INVÁLIDA", 4);
			cout << endl << endl;
		}
		   
		char action[10];
		cout << "-----------------------------------------------------------------------" << endl;
	   	cout << "          ************* VOCÊ É *************" << endl << endl;
	   	
	   	cout << "       -> ";
		writeInColor("cliente", 9);
		cout << endl << "       -> ";
		writeInColor("companhia", 9);
		cout << endl << "       -> ";
		writeInColor("voltar", 4);
		cout << endl << endl << "-----------------------------------------------------------------------" << endl << endl;
		
		cin.getline(action, 10);
			
		toLower(action);
		
		system("CLS");
		
		if(strcmp(action, "cliente") == 0)
		{
			isClient = true;
			continue_loop = false;
		}
		else if(strcmp(action, "companhia") == 0)
		{
			isClient = false;
			continue_loop = false;
		}
		else if(strcmp(action, "voltar") == 0) return;
		else
			wrongAnswer = true;
		
		system("CLS");
		
		Register info;
		
		if(!wrongAnswer)
		{
			bool check_password = true, repeated_name = false;

			do
			{
				bool check_name = true;
				
				if(repeated_name)
					cout << " Nome repetido." << endl << endl;
				
				do
				{
					if(!check_name)
						cout << "Nome inválido." << endl << endl;
					
					if(isClient)
						writeInColor(" Nome", 9);
					else
						writeInColor(" Nome da companhia", 9);
					
				   	cout << ": ";
					
					cin.getline(info.name, 100);
					check_name = false;
					system("CLS");
				} while(!isStringValid(info.name, CONST_NAME_CHECK));
				
				adjustName(info.name);
				repeated_name = true;
			} while(getNameOccurrences(info.name, isClient) > 0);
				
	
			do
			{
				if(!check_password)
				{
					cout << "Senha inválida." << endl;
					cout << "MIN. 4 MÁX. 10 caracteres. APENAS LETRAS E NÚMEROS!" << endl << endl;
				}
				
				int count = 0;
				
				writeInColor(" Senha", 9);
				cout << ": ";
		
				while(count <= 10)
				{		
					if(count == 10) {info.password[10] = '\0'; break;}
					
					info.password[count] = _getch();
			
					if(info.password[count] == '\n' || info.password[count] == '\r')
					{
						info.password[count] = '\0';
						break;
					}
					
					cout << "*";
					count++;
				}
				
				check_password = false;
				system("CLS");
			} while(!isStringValid(info.password, CONST_PASSWORD_CHECK));
			
			cout << "  -> Nome: " << info.name << endl;
			cout << "  -> Senha: " << info.password << endl << endl;
			
			cout << "-> Pressione qualquer tecla para finalizar o registro." << endl;
			
			getch();
			
			char ID[] = ";0;";
			
			strcpy(info.ID, ID);
			
			info.writeIntoFile(isClient);
			
			Login(info.name, info.password, true, isClient);
		}
	}
}

int getYesOrNo()
{
	int ret;
	
	cout << "  (";
	writeInColor("0", 9);
	cout << ") - sim" << endl;
	cout << "  (";
	writeInColor("1", 9);
	cout << ") - nao" << endl;
	
	do
	{
		cin >> ret;
		system("CLS");
	} while(ret != 0 && ret != 1);
	
	return ret;
}

void Login(char name[], char password[], bool registered, bool client)
{
	bool isClient;
	
	if(registered)
		isClient = client;
	else
	{
		char action[10];
		cout << "-----------------------------------------------------------------------" << endl;
	   	cout << "          ************* VOCÊ É *************" << endl << endl;
	   	
	   	cout << "       -> ";
		writeInColor("cliente", 9);
		cout << endl << "       -> ";
		writeInColor("companhia", 9);
		cout << endl << endl << "-----------------------------------------------------------------------" << endl << endl;
		
		cin.getline(action, 10);
			
		toLower(action);
		
		system("CLS");
		
		if(strcmp(action, "cliente") == 0)
			isClient = true;
		else if(strcmp(action, "companhia") == 0)
			isClient = false;
		else return;	
	}
	
	if(!registered)
	{
		bool check_login = true;
		char login[100], _password[11];
		
		do
		{	
			if(!check_login)
			{
				cout << " Combinação inválida. (login inexistente ou senha incorreta)" << endl << endl;
				cout << "-> Pressione qualquer tecla para continuar." << endl;
				getch();
				
				return;
			}
			
			cout << "-----------------------------" << endl;
			cout << "********** LOGANDO **********" << endl;
			cout << "-----------------------------" << endl << endl;
			
			writeInColor(" Nome", 9);
			cout << ": ";
		
			cin.getline(login, 100);
			
			writeInColor(" Senha", 9);
			cout << ": ";
	
			int count = 0;
			while(count <= 10)
			{		
				if(count == 10) {_password[10] = '\0'; break;}
				
				_password[count] = _getch();
		
				if(_password[count] == '\n' || _password[count] == '\r')
				{
					_password[count] = '\0';
					break;
				}
				
				cout << "*";
				count++;
			}
			
			system("CLS");
			check_login = false;
		} while(!checkCombination(login, _password, isClient));
		
		strcpy(name, login);
		strcpy(password, _password);
		
	}
	
	if(isClient)
		clientLogin(name, password);
	else
		companyLogin(name, password);
}

void clientLogin(char login[], char password[])
{
	//compra passagem
	//busca de horarios
	//avisos previos*
	//checagem de voos (q ele comprou)
	//desistencia
	
	system("CLS");
	
	bool _time = true, loop_running = true;
	cout << "-----------------------------------------------------------------------" << endl;
	cout << "************** CLIENTE **************" << endl;
	cout << "-----------------------------------------------------------------------" << endl << endl;
	
	while(loop_running)
	{
		if(!_time) system("CLS");
		
		char action[9];
		cout << "-----------------------------------------------------------------------" << endl;
	   	cout << "          ************* VOCÊ DESEJA *************" << endl << endl;
		
		cout << "       -> ";
		writeInColor("comprar ", 9);
		cout << "passagems" << endl;
		cout << "       -> ";
		
		writeInColor("buscar ", 9);
		cout << "horários de voos" << endl;
		
		cout << "       -> ";
		writeInColor("checar ", 9);
		cout << "seus voos" << endl;
		
		cout << "       -> ";
		writeInColor("desistir ", 9);
		cout << "de algum voo" << endl;
		
		cout << "       -> ";
		writeInColor("sair", 4);
		cout << endl << endl << "-----------------------------------------------------------------------" << endl << endl;
		
		_time = false;
		
		cin.getline(action, 9);
		
		toLower(action);
		
		system("CLS");
	
		if(strcmp(action, "comprar") == 0)
			buyTickets(login, 0);
		else if(strcmp(action, "buscar") == 0)
			checkFlights(login, true, true);
		else if(strcmp(action, "checar") == 0)
			checkFlights(login, true, false);
		else if(strcmp(action, "desistir") == 0)
			buyTickets(login, -1);
		else if(strcmp(action, "sair") == 0) loop_running = false;
	}
}

void buyTickets(char name[], int count)
{
	ifstream _old_file("flight.txt");
	ofstream _out_file("tmp.txt", ios_base::app | ios_base::out);
	
	FlightInfo flight;
	int ID, _count = count;
	
	cout << " ID do voo: ";
	
	cin >> ID;
	
	system("CLS");
	
	if(_count == 0)
	{
		bool wrong_answer = false;
		
		do
		{
			if(wrong_answer)
				cout << " -> Quantidade inválida." << endl << endl;
			
			cout << " Quantidade de passagens: ";
			
			cin >> _count;
			
			wrong_answer = true;
			system("CLS");
		} while(_count <= 0);
	}
	
	char line[2000], old_line[2000];
	bool out_copied = false;
	
	while(_old_file.getline(line, 2000))
	{
		bool copied = false;
		int i[getIndexesSize(line, '|')];
		getIndexesBySplittingSentence(line, '|', i);
		
		int ID_size = i[1] - i[0] - 1;
		char lineID[ID_size];
		
		fillSentence(line, i[0], i[1], lineID);
		
		if(ID == atoi(lineID))
		{		
			if(_count <= 0)
			{
				if(isFlightBooked(name, ID))
				{
					copied = true;
					out_copied = copied;
					
					strcpy(old_line, line);
				}
			}
			else
			{
				copied = true;
				out_copied = copied;
				
				strcpy(old_line, line);
			}
		}
		
		if(!copied)
			_out_file << line << endl;
			
	}
	
	_old_file.close();
	_out_file.close();
	remove("flight.txt");
    rename("tmp.txt", "flight.txt");
    
    if(!out_copied) 
	{
		if(_count > 0)
			cout << " Erro na compra." << endl << endl;
		else
			cout << " Voo não agendado." << endl << endl;
		
		cout << "-> Pressione qualquer tecla para continuar." << endl;
	   	getch();
	   	
	   	return;
	}

    int i[getIndexesSize(old_line, '|')];
	getIndexesBySplittingSentence(old_line, '|', i);
    
    int cmpy_size = i[3] - i[2] - 1, plane_size = i[5] - i[4] - 1, price_size = i[7] - i[6] - 1;
	int tickets_size = i[9] - i[8] - 1, hr_size = i[11] - i[10] - 1, date_size = i[13] - i[12] - 1, destiny_size = i[15] - i[14] - 1;
	
	char cmpy[cmpy_size], plane[plane_size], price[price_size], total[tickets_size], hr[hr_size], date[date_size], destiny[destiny_size];
	
	fillSentence(old_line, i[2], i[3], cmpy);
	fillSentence(old_line, i[4], i[5], plane);
	fillSentence(old_line, i[6], i[7], price);
	fillSentence(old_line, i[8], i[9], total);
	fillSentence(old_line, i[10], i[11], hr);
	fillSentence(old_line, i[12], i[13], date);
	fillSentence(old_line, i[14], i[15], destiny);
	
	flight.ID = ID;
	strcpy(flight.company, cmpy);
	strcpy(flight.plane, plane);
	
	flight.ticket_price = atoi(price);
	
	int g[getIndexesSize(total, '/')];
	getIndexesBySplittingSentence(total, '/', g);
	
	int count_tickets_size = g[0], total_tickets_size = strlen(total) - g[0] - 1;
	
	char count_tickets[count_tickets_size], total_tickets[total_tickets_size];
	
	fillSentence(total, -1, g[0], count_tickets);
	fillSentence(total, g[0], strlen(total), total_tickets);
	
	int total_count = atoi(total_tickets), new_count = atoi(count_tickets) + _count;
	
	if(new_count > total_count)
	{
		ofstream _out_file("flight.txt", ios_base::app | ios_base::out);
		
		_out_file << old_line << endl;
		_out_file.close();
		
		cout << " O número de passagens compradas ultrapassa o limite previsto do voo." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
	   	getch();
	   	
	   	return;
	}
	
	flight.tickets = new_count;
	
	flight.total_tickets = total_count;
	
	strcpy(flight.time, hr);
	strcpy(flight.date, date);
	strcpy(flight.destiny, destiny);
	
	updateClientIDInfo(name, ID, _count);	
	flight.bookFlight();

	getch();
}

void updateClientIDInfo(char name[], int ID, int count)
{
	Register info;
	noptr lista = NULL;
	char password[11], IDs[1000], new_ID[1000];
	
	ifstream old_file("client.txt");
	ofstream out_file("tmp.txt", ios_base::app | ios_base::out);
	char line[2000];
	
	while(old_file.getline(line, 2000))
	{
		int i[getIndexesSize(line, '/')];
		getIndexesBySplittingSentence(line, '/', i);
	
		int login_size = i[1] - i[0] - 1;
		char login_now[login_size];
		
		fillSentence(line, i[0], i[1], login_now);
	
		if(strcmp(login_now, name) == 0)
		{
			int pass_size = i[3] - i[2] - 1, ID_size = i[5] - i[4] - 1;
			
			char pass[pass_size], ID_old[ID_size];
			
			fillSentence(line, i[2], i[3], pass);
			fillSentence(line, i[4], i[5], ID_old);
			
			strcpy(password, pass);
			strcpy(IDs, ID_old);
		}
		else
			out_file << line << endl;
	}
	
	old_file.close();
	out_file.close();
	remove("client.txt");
    rename("tmp.txt", "client.txt");
    
    strcpy(info.name, name);
    strcpy(info.password, password);
    
    if(count > 0)
	{
		int countVec = 0;
		
		int size = getIndexesSize(IDs, ';');
		int g[size];
		getIndexesBySplittingSentence(IDs, ';', g);
		
		for(int k = 0; k < size - 1; k++)
		{
			int ID_size = g[k + 1] - g[k] - 1;
			char ID_now[ID_size];
			
			fillSentence(IDs, g[k], g[k + 1], ID_now);
			
			if(k == 0)
				criad(lista, atoi(ID_now), Band_Aid);
			else
				inseredir(lista, atoi(ID_now));
		}
		
		for(int i = 1; i <= count; i++)
			inseredir(lista, ID);
		
		noptr p = lista->dir;
		noptr cpy = p;
		new_ID[countVec++] = ';';
		
		do
		{
			new_ID[countVec] = p->info + 48;
			new_ID[++countVec] = ';';
			
			countVec++;
			p = p->dir;
		} while(p != cpy);
		
		new_ID[countVec] = '\0';
		
		strcpy(info.ID, new_ID);
	}
	else
	{
		int countVec = 0;
		bool removed = false;
		
		int size = getIndexesSize(IDs, ';');
		int g[size];
		getIndexesBySplittingSentence(IDs, ';', g);
		
		for(int k = 0; k < size - 1; k++)
		{
			int ID_size = g[k + 1] - g[k] - 1;
			char ID_now[ID_size];
			
			fillSentence(IDs, g[k], g[k + 1], ID_now);
			
			if(atoi(ID_now) == ID && !removed)
				removed = true;
			else
			{
				if(lista == NULL)
					criad(lista, atoi(ID_now), Band_Aid);
				else
					inseredir(lista, atoi(ID_now));
			}
				
		}
		
		if(lista == NULL) criad(lista, 0, Band_Aid);
		
		noptr p = lista->dir;
		noptr cpy = p;
		new_ID[countVec++] = ';';
		
		do
		{
			new_ID[countVec] = p->info + 48;
			new_ID[++countVec] = ';';
			
			countVec++;
			p = p->dir;
		} while(p != cpy);
		
		new_ID[countVec] = '\0';
		
		strcpy(info.ID, new_ID);
	}

	if(count < 0)
		cout << " Você cancelou com sucesso seu voo." << endl << endl;
	else
		cout << " Você comprou com sucesso " << count << "x passagem(ns)." << endl << endl;
	
	info.writeIntoFile(true);
		
	cout << "-> Pressione qualquer tecla para finalizar o processo." << endl;
			
	getch();
}

void companyLogin(char login[], char password[])
{
	//criação de voos
	//voos da agencia
	//cancelamento de voos
	
	system("CLS");
	
	bool _time = true, loop_running = true;
	cout << "-----------------------------------------------------------------------" << endl;
	cout << "************** COMPANHIA **************" << endl;
	cout << "-----------------------------------------------------------------------" << endl << endl;
	
	while(loop_running)
	{
		if(!_time) system("CLS");
		
		char action[15];
		cout << "-----------------------------------------------------------------------" << endl;
	   	cout << "          ************* VOCÊ DESEJA *************" << endl << endl;
		
		cout << "       -> ";
		writeInColor("agendar ", 9);
		cout << "um voo" << endl;
		cout << "       -> ";
		
		writeInColor("voos ", 9);
		cout << "agendados da companhia" << endl;
		
		cout << "       -> ";
		writeInColor("cancelamento ", 9);
		cout << "de voos" << endl;
		
		cout << "       -> ";
		writeInColor("sair", 4);
		cout << endl << endl << "-----------------------------------------------------------------------" << endl << endl;
		
		_time = false;
		
		cin.getline(action, 15);
		
		toLower(action);
		
		system("CLS");
	
		if(strcmp(action, "agendar") == 0)
			bookFlight(login);
		else if(strcmp(action, "voos") == 0)
			checkFlights(login, false, false);
		else if(strcmp(action, "cancelamento") == 0)
			cancelFlight(login);
		else if(strcmp(action, "sair") == 0) loop_running = false;
	}	
}

void cancelFlight(char name[])
{
	int ID;
	bool canceled = false;
	
	file.open("flight.txt");
	out_file.open("tmp.txt", ios_base::app | ios_base::out);
	
	cout << " ID do voo: ";
	
	cin >> ID;
	
	system("CLS");
	
	char line[2000];
	
	while(file.getline(line, 2000))
	{
		int i[getIndexesSize(line, '|')];
		getIndexesBySplittingSentence(line, '|', i);
	
		int ID_size = i[1] - i[0] - 1, company_size = i[3] - i[2] - 1;
		char lineID[ID_size], company[company_size];
		
		fillSentence(line, i[0], i[1], lineID);
		fillSentence(line, i[2], i[3], company);
		if(strcmp(name, company) == 0 && atoi(lineID) == ID)
		{
			canceled = true;
			continue;
		}
	
		out_file << line << endl;
	}
	
	if(!canceled)
		cout << "-> Voo inexistente." << endl << endl;
	else
		cout << "-> Voo cancelado com sucesso." << endl << endl;
	
	file.close();
	out_file.close();
	
	remove("flight.txt");
    rename("tmp.txt", "flight.txt");
    
    if(canceled)
    	resetClientsIDs(ID);
	
	cout << endl << "-> Pressione qualquer tecla para continuar." << endl;
	getch();
}

void resetClientsIDs(int ID)
{
	ifstream old_file("client.txt");
	ofstream _out_file("tmp.txt", ios_base::app | ios_base::out);
	noptr infoList = NULL;
	
	char line[2000];
	
	while(old_file.getline(line, 2000))
	{
		Register info;
	   	noptr lista = NULL;
	   	
	   	bool altered = false;
	   	char new_ID[1000];
	
		int i[getIndexesSize(line, '/')];
		getIndexesBySplittingSentence(line, '/', i);
	
		int login_size = i[1] - i[0] - 1, pass_size = i[3] - i[2] - 1, ID_size = i[5] - i[4] - 1;
		char login[login_size], password[pass_size], IDs[ID_size];
		
		fillSentence(line, i[0], i[1], login);
		fillSentence(line, i[2], i[3], password);
	   	fillSentence(line, i[4], i[5], IDs);
	   	
	   	strcpy(info.name, login);
		strcpy(info.password, password);
	   	
	   	int size = getIndexesSize(IDs, ';');
		int g[size];
		getIndexesBySplittingSentence(IDs, ';', g);
		
		int countVec = 0;
		
		cout << "Nome: " << info.name << endl;
		cout << "Ids: " << IDs << endl;
		
		for(int k = 0; k < size - 1; k++)
		{
			int ID_size = g[k + 1] - g[k] - 1;
			char ID_now[ID_size];
			
			fillSentence(IDs, g[k], g[k + 1], ID_now);
			
		 	cout << "Id verificado: " << ID_now << endl;
			
			if(atoi(ID_now) == ID)
				altered = true;
			else
			{
				if(lista == NULL)
					criad(lista, atoi(ID_now), Band_Aid);
				else
					inseredir(lista, atoi(ID_now));
			}
				
		}
		
		if(!altered)
		{
			_out_file << line << endl;
			
			cout << "N mudou nd nesse cara.." << endl;
			cout << "Linha escrita: " << line << endl;
		}
		else
		{
			cout << "Mudou.." << endl;
			
			if(lista == NULL) criad(lista, 0, Band_Aid);
		
			noptr p = lista->dir;
			noptr cpy = p;
			new_ID[countVec++] = ';';
			
			do
			{
				new_ID[countVec] = p->info + 48;
				new_ID[++countVec] = ';';
				
				cout << "ID agr: " << p->info << endl;
				
				countVec++;
				p = p->dir;
			} while(p != cpy);
			
			new_ID[countVec] = '\0';
			
			strcpy(info.ID, new_ID);
			
			if(infoList == NULL) criad(infoList, 0, info);
			else inseredirStruct(infoList, info);
		}
		
	}
	
	old_file.close();
	_out_file.close();
	remove("client.txt");
    rename("tmp.txt", "client.txt");
    
    if(infoList != NULL)
	{
		cout << "Entrou aqui pelo menos.." << endl;
		noptr p = infoList->dir;
		noptr cpy = p;
		
		do
		{
			cout << "E aqui!" << endl;
			p->data.writeIntoFile(true);
			
			p = p->dir;
		} while(p != cpy);
	}
}

void checkFlights(char name[], bool isClient, bool all)
{
	file.open("flight.txt");

	char line[2000];

	while(file.getline(line, 2000))
	{
		int i[getIndexesSize(line, '|')];
		getIndexesBySplittingSentence(line, '|', i);
		
		int ID_size = i[1] - i[0] - 1, company_size = i[3] - i[2] - 1;
		char ID[ID_size], company[company_size];

		fillSentence(line, i[0], i[1], ID);
		fillSentence(line, i[2], i[3], company);
		
		if(!all)
			if((isClient && !isFlightBooked(name, atoi(ID))) || (!isClient && strcmp(name, company) != 0))
				continue;
        
		int plane_size = i[5] - i[4] - 1, price_size = i[7] - i[6] - 1, total_size = i[9] - i[8] - 1, hr_size = i[11] - i[10] - 1;
		int date_size = i[13] - i[12] - 1, destiny_size = i[15] - i[14] - 1;
		
		char plane[plane_size], price[price_size], total[total_size], hr[hr_size], date[date_size], destiny[destiny_size];
		
		fillSentence(line, i[4], i[5], plane);
		fillSentence(line, i[6], i[7], price);
		fillSentence(line, i[8], i[9], total);
		fillSentence(line, i[10], i[11], hr);
		fillSentence(line, i[12], i[13], date);
		fillSentence(line, i[14], i[15], destiny);
		
		cout << "[" << ID << "] Ag.: " << company << " / Av.: " << plane << " / Pr. " << price << " / Pass. " << total << " / Hh.: " << hr << " / Dt. " << date << " / Dest. " << destiny;
		
		if(isClient && all && isFlightBooked(name, atoi(ID)))
			cout << " -> agendado";
		
		cout << endl;
	}
	
	cout << endl << "-> Pressione qualquer tecla para continuar." << endl;
	getch();

	file.close();
}

bool isFlightBooked(char name[], int ID)
{
	ifstream file_tmp("client.txt");

	bool ret = false;
	char line[2000];

	while(file_tmp.getline(line, 2000))
	{
		int i[getIndexesSize(line, '/')];
		getIndexesBySplittingSentence(line, '/', i);
		
		int name_size = i[1] - i[0] - 1;
		char nameFile[name_size];

		fillSentence(line, i[0], i[1], nameFile);

		if(strcmp(name, nameFile) != 0)
			continue;
		
		int IDs_size = i[5] - i[4] - 1;
		char IDs[IDs_size];
		
		fillSentence(line, i[4], i[5], IDs);
		
		int size = getIndexesSize(IDs, ';');
		int g[size];
		getIndexesBySplittingSentence(IDs, ';', g);
		
		for(int k = 0; k < size - 1; k += 2)
		{
			int ID_cmp, ID_size = g[k + 1] - g[k] - 1;
			char ID_now[ID_size];
			
			fillSentence(IDs, g[k], g[k + 1], ID_now);
			
			ID_cmp = atoi(ID_now);
			
			if(ID == ID_cmp)
			{
				ret = true;
				break;
			}
		}
		
		cout << endl;
	}
		
	file_tmp.close();
	
	return ret;
}

void inseredir(noptr& p, int x)
{
    noptr q;
    noptr d;
    
    q = new no;
    q->info = x;
    d = p->dir;
    d->esq = q;
    q->dir = d;
    q->esq = p;
    p->dir = q;
}

void inseredirStruct(noptr &p, Register x)
{
    noptr q;
    noptr d;
    
    q = new no;
    q->data = x;
    d = p->dir;
    d->esq = q;
    q->dir = d;
    q->esq = p;
    p->dir = q;
}

void criad(noptr &lista, int x, Register info)
{
    noptr p;
 
    p = new no;
    p->info = x;
    p->data = info;
    p->esq = p;
    p->dir = p;
    lista = p;
}

void bookFlight(char name[])
{
	FlightInfo flight;
	int ticket_price, count = 0;
	char plane[50], date[11], hour[6], destiny[100];
	bool wrong_answer = false;
	
	time_t t = time(NULL);
	tm* timePtr = localtime(&t);
	
	cout << "* Aviões disponíveis *" << endl;
	cout << " -> ";
	writeInColor("Airbus A318 ", 9);
	cout << "(5.7mil km) (120 passageiros)" << endl;
	
	cout << " -> ";
	writeInColor("Airbus A319 ", 9);
	cout << "(7.2mil km) (132 passageiros)" << endl;
	
	cout << " -> ";
	writeInColor("Airbus A320 ", 9);
	cout << "(5.7mil km) (162 passageiros)" << endl;
	
	cout << " -> ";
	writeInColor("ATR 42-500 ", 9);
	cout << "(1.5mil km) (48 passageiros)" << endl << endl;
	
	cout << " Seu avião de escolha: ";
	
	cin.getline(plane, 50);
	
	adjustName(plane);
	
	system("CLS");
	
	flight.tickets = 0;
	
	if(strcmp(plane, "Airbus A318") == 0)
		flight.total_tickets = 120;
	else if(strcmp(plane, "Airbus A319") == 0)
		flight.total_tickets = 132;
	else if(strcmp(plane, "Airbus A320") == 0)
		flight.total_tickets = 162;
	else if(strcmp(plane, "ATR 42-500") == 0)
		flight.total_tickets = 48;
	else
	{
		cout << " Modelo de avião inválido." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	strcpy(flight.company, name);
	
	strcpy(flight.plane, plane);
	flight.ID = getFileLineCount("flight.txt") + 1;
	
	while(!isIDValid(flight.ID))
		flight.ID++;
	
	do
	{
		if(wrong_answer)
			cout << " -> Valor inválido." << endl;
		
		cout << " Preço da passagem: ";
		
		cin >> ticket_price;
		wrong_answer = true;
		
		system("CLS");
	} while(ticket_price < 0);
	
	flight.ticket_price = ticket_price;
	
	cout << " Data do voo: ";
	
	while(count < 10)
	{
		date[count] = _getch();
		
		cout << date[count];
		
		if(date[count] == '\n' || date[count] == '\r')
		{
			date[count] = '\0';
			break;
		}
		
		if(count == 1 || count == 4)
		{
			date[++count] = '/';
			cout << "/";
		}
		
		count++;
		
		if(count == 10) date[10] = '\0';
	}

	system("CLS");

	if(strlen(date) != 10)
	{
		cout << " Data inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}

	int g[getIndexesSize(date, '/')], day, month, year;
	int day_now = timePtr->tm_mday, month_now = timePtr->tm_mon + 1, year_now = timePtr->tm_year + 1900;
	getIndexesBySplittingSentence(date, '/', g);
			
	char day_str[3], mon_str[3], year_str[5];
	
	fillSentence(date, -1, g[0], day_str);
	fillSentence(date, g[0], g[1], mon_str);
	fillSentence(date, g[1], strlen(date), year_str);
	
	if(!isStringValid(day_str, CONST_NUMBER_CHECK) || !isStringValid(mon_str, CONST_NUMBER_CHECK) || !isStringValid(year_str, CONST_NUMBER_CHECK))
	{
		cout << " Data inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	day = atoi(day_str);
	month = atoi(mon_str);
	year = atoi(year_str);
	
	if(year < year_now || year <= 0)
	{
		cout << " Data inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	else if(year == year_now)
	{
		if(month < month_now || month <= 0 || month > 12)
		{
			cout << " Data inválida." << endl << endl;
			cout << "-> Pressione qualquer tecla para continuar." << endl;
			getch();
			
			return;
		}
		else if(month == month_now)
			if(day < day_now || day <= 0 || day > 31 || (month == 2 && day > 27))
			{
				cout << " Data inválida." << endl << endl;
				cout << "-> Pressione qualquer tecla para continuar." << endl;
				getch();
				
				return;
			}
	}
	else if(month <= 0 || month > 12)
	{
		cout << " Data inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	else if(day <= 0 || day > 31 || (month == 2 && day > 27))
	{
		cout << " Data inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	strcpy(flight.date, date);
	
	count = 0;
	
	cout << " Horário do voo: ";
	
	while(count < 5)
	{
		hour[count] = _getch();
		
		cout << hour[count];
		
		if(hour[count] == '\n' || hour[count] == '\r')
		{
			hour[count] = '\0';
			break;
		}
		
		if(count == 1)
		{
			hour[++count] = ':';
			cout << ":";
		}
		
		count++;
		
		if(count == 5) hour[5] = '\0';
	}

	system("CLS");
	
	int i[getIndexesSize(hour, ':')], hr, min;
	
	getIndexesBySplittingSentence(hour, ':', i);
			
	char hr_str[3], min_str[3];
	
	fillSentence(hour, -1, i[0], hr_str);
	fillSentence(hour, i[0], strlen(hour), min_str);
	
	if(!isStringValid(hr_str, CONST_NUMBER_CHECK) || !isStringValid(min_str, CONST_NUMBER_CHECK))
	{
		cout << "aqui" << endl;
		cout << " Hora inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	hr = atoi(hr_str);
	min = atoi(min_str);
	
	if(hr > 23 || hr < 0)
	{
		cout << " Hora inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	else if(min > 59 || min < 0)
	{
		cout << " Hora inválida." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	strcpy(flight.time, hour);
	
	cin.ignore();
	
	cout << " Destino: ";
	
	cin.getline(destiny, 100);
	
	if(!isStringValid(destiny, CONST_NAME_CHECK))
	{
		cout << " Destino inválido." << endl << endl;
		cout << "-> Pressione qualquer tecla para continuar." << endl;
		getch();
		
		return;
	}
	
	strcpy(flight.destiny, destiny);
	
	system("CLS");
	
	flight.bookFlight();
	cout << "  -> Voo agendado!" << endl << endl;
	cout << "Pressione qualquer tecla para continuar." << endl;
	getch();
	
}

void FlightInfo::bookFlight()
{	
	out_file.open("flight.txt", ios_base::app | ios_base::out);
	
	out_file << "ID:|" << this->ID << "|";
	out_file << "Empresa:|" << this->company << "|";
	out_file << "Avião:|" << this->plane << "|";
	out_file << "Preço:|" << this->ticket_price << "|";
	out_file << "Total:|" << this->tickets << "/" << this->total_tickets << "|";
	out_file << "Hora:|" << this->time << "|";
	out_file << "Data:|" << this->date << "|";
	out_file << "Destino:|" << this->destiny << "|" << endl;
	
	out_file.close();
}


int getFileLineCount(const char* file_name)
{
	file.open(file_name);
	int count = 0;
	char line[2000];
	
	while(file.getline(line, 2000)) count++;
	file.close();
	
	return count;
}

bool checkCombination(char login[], char password[], bool isClient)
{
	bool ret = false;
	
	ifstream file_now;
	
	if(isClient)
		file_now.open("client.txt");
	else
		file_now.open("company.txt");
	
	char line[2000];
	
	while(file_now.getline(line, 2000))
	{	
		int i[getIndexesSize(line, '/')];
		getIndexesBySplittingSentence(line, '/', i);
		
		int login_size = i[1] - i[0] - 1, password_size = i[3] - i[2] - 1;
		char log[login_size], pass[password_size];
		
		fillSentence(line, i[0], i[1], log);
		fillSentence(line, i[2], i[3], pass);
		
		if(strcmp(login, log) == 0 && strcmp(password, pass) == 0)
		{
			ret = true;
			break;
		}
	}
	
	file_now.close();
	
	return ret;
}

void adjustName(char name[])
{
	int size = getIndexesSize(name, ' ');
	cout << "";
	
	if(size == 0)
		name[0] = toupper(name[0]);
	else
	{
		int index[size];
	   	getIndexesBySplittingSentence(name, ' ', index);
	   	
		for(int i = 0; i < size - 1; i++)
		{
			int size = i[index + 1] - i[index] - 1, count = 0;
			char part[size];
			
			for(int j = index[i]; j < index[i + 1]; j++)
				part[count++] = name[j];
			
			part[sizeof(part)] = '\0';
			
			if(strcmp(part, "de") != 0 && strcmp(part, "do") != 0 && strcmp(part, "a") != 0 && strcmp(part, "da") != 0 && strcmp(part, "di") != 0 && strcmp(part, "du") != 0)
				name[index[i]] = toupper(name[index[i]]);
			
		}
	}
}

bool isIDValid(int ID)
{
	char line[2000];
	bool ret = true;
	
	ifstream file_now("flight.txt");
		
	while(file_now.getline(line, 2000))
	{
		int i[getIndexesSize(line, '|')];
		getIndexesBySplittingSentence(line, '|', i);
		
		int ID_size = i[1] - i[0] - 1;
		char lineID[ID_size];
		
		fillSentence(line, i[0], i[1], lineID);
		
		if(ID == atoi(lineID))
		{
			ret = false;
			break;
		}
	}

	file_now.close();
	
	return ret;
}

int getIndexesSize(char* line, char split_character)
{
	int size = strlen(line) + 1, count = 0;
	bool continue_func = false;
	
	for(unsigned int i = 0; i < strlen(line); i++)
	{
		if(line[i] == split_character)
		{
			continue_func = true;
			break;
		}
	}
		
    if(!continue_func) return count;
	
	if(line[0] != split_character && line[strlen(line)] != split_character)
		size += 2;
	
	char working_on[size];
	
	if((unsigned int) size == strlen(line) + 1)
		strcpy(working_on, line);
	else
	{
		working_on[0] = ' ';
		working_on[size - 2] = ' ';
		
		for(int k = 1; k < size - 2; k++)
			working_on[k] = line[k - 1];
		
		working_on[size - 1] = '\0';
		
	}
    
    for(unsigned int i = 0; i <= strlen(working_on); i++)
		if(working_on[i] == split_character)
			count++;
		
    return count;
}

void getIndexesBySplittingSentence(char* line, char split_character, int j[])
{	
	int size = strlen(line) + 1, count = 0;
	
	if(line[0] != split_character && line[strlen(line)] != split_character && split_character == ' ')
		size += 2;
	
	char working_on[size];
	
	if((unsigned int) size == strlen(line) + 1)
		strcpy(working_on, line);
	else
	{
		working_on[0] = ' ';
		working_on[size - 1] = ' ';
		
		for(int k = 1; k < size - 2; k++)
			working_on[k] = line[k - 1];
		
		working_on[size] = '\0';
	}
    
    for(unsigned int i = 0; i <= strlen(working_on); i++)
		if(working_on[i] == split_character)
			j[count++] = i;	

}

int getNameOccurrences(char name[], bool isClient)
{
	if(isClient)
		file.open("client.txt");
	else
		file.open("company.txt");
	
	char line[2000];
	int count_name = 0;

	while(file.getline(line, 2000))
	{
		int i[getIndexesSize(line, '/')];
		getIndexesBySplittingSentence(line, '/', i);
		
		int name_size = i[1] - i[0] - 1;
		char name_now[name_size];

		fillSentence(line, i[0], i[1], name_now);
		
		if(strcmp(name_now, name) == 0) count_name++;
		
	}
		
	file.close();
	return count_name;
}

void fillSentence(char line[], int begin, int end, char target[])
{
	int count = 0;
	
	for(int i = begin + 1; i < end; i++)
		target[count++] = line[i];
	
	target[end - begin - 1] = '\0';
}

void Register::writeIntoFile(bool isClient)
{
	ofstream out_file;
	
	if(isClient)
		out_file.open("client.txt", ios_base::app | ios_base::out);
	else
		out_file.open("company.txt", ios_base::app | ios_base::out);
	
	out_file << "Nome:/" << this->name << "/";
	out_file << "Senha:/" << this->password << "/";
	
	if(isClient)
		out_file << "IDs:/" << this->ID << "/";
	
	out_file << endl;
	
	out_file.close();
}

void toLower(char w[])
{
	for(unsigned int i = 0; i < strlen(w); i++)
		w[i] = tolower(w[i]);
}