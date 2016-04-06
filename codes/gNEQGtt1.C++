#include <iostream>
#include <string>
#include <sstream>
#include <iomanip>
#include <cstdlib>
#include <fstream>
#include <cmath>
#define R2G 0.12149792

using namespace std;

//######FUNCTION TO PRINT SHOP TITLE######
void shopTitle() {
	cout << endl;
	cout << endl <<  "  ______      _____       _          _   _                  _ ________          ________ _      _      ______ _____   _____  ";
	cout << endl <<  " |  ____/\\   |  __ \\     | |   /\\   | \\ | |   /\\           | |  ____\\ \\        / /  ____| |    | |    |  ____|  __ \\ / ____| ";
	cout << endl <<  " | |__ /  \\  | |__) |    | |  /  \\  |  \\| |  /  \\          | | |__   \\ \\  /\\  / /| |__  | |    | |    | |__  | |__) | (___   ";
	cout << endl <<  " |  __/ /\\ \\ |  _  / _   | | / /\\ \\ | . ` | / /\\ \\     _   | |  __|   \\ \\/  \\/ / |  __| | |    | |    |  __| |  _  / \\___ \\  ";
	cout << endl <<  " | | / ____ \\| | \\ \\| |__| |/ ____ \\| |\\  |/ ____ \\   | |__| | |____   \\  /\\  /  | |____| |____| |____| |____| | \\ \\ ____) | ";
	cout << endl <<  " |_|/_/    \\_\\_|  \\_\\\\____//_/    \\_\\_| \\_/_/    \\_\\   \\____/|______|   \\/  \\/   |______|______|______|______|_|  \\_\\_____/  ";
	cout << endl << endl;
	for (int i = 0; i < 32; i++) cout << "-";
	cout << "XX XXXXXXX, XXXXXX XXXXXX (1st Floor), Tongi Bazar, Gazipur.";
	for (int i = 0; i < 32; i++) cout << "-";
	cout << endl;
	for (int i = 0; i < 36; i++) cout << "-";
	cout << "A Reliable Shop for Getting the Best Quality Jewelry";
	for (int i = 0; i < 36; i++) cout << "-";
	cout << endl << endl;
}



//*****PRICE/RATE CLASS******
//This Class's Objects Contains Gold Price According to Corresponding Karat
class Rate{
protected:
    string date;
    double k18, k20, k21, k22;
public:
    Rate(): date("N/A"), k18(0.0), k20(0.0), k21(0.0), k22(0.0) {} //0-arg Constructor
    Rate(double k180, double k200, double k210, double k220): k18(k180), k20(k200), k21(k210), k22(k220) {} //4-arg Constructor
    ~Rate() {} //Destructor

    void read(string dt) {
        cout << "Update the Current GOLD Price." << endl;
        date = dt;
        cin.sync();
		cout << "Input the Price in Grams/Tola: (g/t): ";
		char un;
		do{
			cin >> un;
			cin.sync();
		} while(un != 'g' && un != 't' && un != 'G' && un != 'T');

        cout << "Enter Price for All Corresponding Karat Values";
		(un == 'g' || 'G') ? cout << " (in GRAMS) : " << endl : cout << " (in TOLA) : " << endl;
        cout << "Today's Price for 18K Gold: ";
        cin >> k18;
        cout << "Today's Price for 20K Gold: ";
        cin >> k20;
        cout << "Today's Price for 21K Gold: ";
        cin >> k21;
        cout << "Today's Price for 22K Gold: ";
        cin >> k22;

		if(un == 't' || un == 'T') {
			k18 = k18 * 96 * R2G;
			k20 = k20 * 96 * R2G;
			k21 = k21 * 96 * R2G;
			k22 = k22 * 96 * R2G;
		}
        cout << "***Gold Price Successfully Updated***" << endl << endl;
    }

    void display() {
        cout << date << "'s Gold Price List" << endl;
        cout << left << setw(15) << "KARATS" << right << setw(15) << "PRICE(Gram)" << right << setw(15) << "PRICE(Tola)" << endl;
        cout << left << setw(15) << "18-K" << right << setw(15) << setprecision(2) << k18 << right << setw(15) << setprecision(2) << k18 / R2G * 96 << endl;
        cout << left << setw(15) << "20-K" << right << setw(15) << setprecision(2) << k20 << right << setw(15) << setprecision(2) << k20 / R2G * 96 << endl;
        cout << left << setw(15) << "21-K" << right << setw(15) << setprecision(2) << k21 << right << setw(15) << setprecision(2) << k21 / R2G * 96 << endl;
        cout << left << setw(15) << "22-K" << right << setw(15) << setprecision(2) << k22 << right << setw(15) << setprecision(2) << k22 / R2G * 96 << endl;
        for(int i = 0; i < 45; i++)
            cout << "-";
        cin.sync();
        getchar();
        cin.sync();
        cout << endl << endl << endl;

    }

	//Function to return Price
	double getPrice(int k) {
		if(k == 18) return k18;
		else if(k == 20) return k20;
		else if(k == 21) return k21;
		else if(k == 22) return k22;
		else {
			cout << "***Invalid Karat Value, Try Again***" << endl;
			return -1;
		}
	}

    string getDate() {return date;}
};
Rate R;

//******UNIT CLASS******
//This is South Asian Standard Gold Weight Measurement Scale
class Tola{
protected:
	int bhari;
	int anni;
	double ratti;

public:
	Tola(): bhari(0), anni(0), ratti(0.0) {} //0-arg Constructor
	Tola(int bh, int an, double rt): bhari(bh), anni(an), ratti(rt) {} //3-arg Constructor (This Takes Assigns Inputs in Tola type)
	Tola(double grams){ //1-arg Constructor (Converts GRAMS to TOLA type)
		ratti = grams / R2G;
		int int_ratti = ratti;
		bhari = ratti / 96;
		anni = (int_ratti % 96) / 6;
		ratti = (int_ratti % 96 % 6) + ratti - int_ratti;
	}

	~Tola() {}

	int getBhari() { return bhari;}
	int getAnni() { return anni;}
	double getRatti() {return ratti;}

	void readTola() {
	    cin.sync();
		cout << "Enter Ornament weight in TOLA (Bhari Anni Ratti): ";
		cin >> bhari >> anni >> ratti;
	}

	void showTola() {
        cout.setf(ios::fixed);
        cout << bhari << "-Bhari " << anni << "-Anni " << setprecision(1) << ratti << "-Ratti" << setprecision(2);
    }

	operator double() { return ((bhari * 96) + (anni * 6) + ratti) * R2G;}
};



//******ORNAMENT CLASS******
//This Class is for General Ornaments Attributes
class Ornament: public Tola{
protected:
	string id;
	string type;
	string description;
	int karat;
    double weight;
	Ornament *next;

public:
	Ornament(): id("N/A"), type("N/A"), description("N/A"), karat(0), weight(0.0), next(NULL){ Tola();}
	~Ornament() {}

    double calculatePrice() {
        return (R.getPrice(karat) * weight);
    }

    void setNext(Ornament *P) { next = P;}
    Ornament * getNext() { return next;}

    void display() {
        cout << left << setw(15) << "TYPE" <<  left << setw(7) << "ID" << right << setw(7) << "KARAT" << right << setw(11) << "GRAM" << right << setw(11) << "TOLA" << right  << "  " << left << "DSCRIPTION" << endl;
        cout << left << setw(15) << type <<  left << setw(7) << id << right << setw(7) << karat << right << setw(11) << setprecision(2) << weight << right << setw(4) << bhari << "." << setw(2) << anni <<  "." << setw(3) << setprecision(1) << ratti << right  << "  " << left << description << endl;
    }

    string getID() { return id;}
    string getType() { return type;}
    int getKarat() { return karat;}
    double getWeight() { return weight;}
    void swap(Ornament *);
    void sort();
    Ornament * searchID(string);
    Ornament * deleteOrnID(string);
    void read();
    friend void listStock(Ornament *);
};


class Sale{
private:
    string name;
    string address;
    string date;
    Ornament *Start;
    double total_amount;
    Sale *next;
public:
    Sale():date("N/A"), next(NULL), total_amount(0.0) {}
    ~Sale() {}
    void setNext(Sale *P) { next = P;}
    Sale * getNext() { return next;}

    Ornament * read(Ornament *OrnHead, string dt){
        cout.setf(ios::fixed);
        ifstream in;
        ofstream out;
        Ornament *Current;
        Ornament *Orn[10];
        string id;
        string str;
        char ch;
        date = dt;

        cout << "Date: " << date << endl << "Enter Customer's Name: ";
        cin.sync();
        getline(cin, name);
        cout << "Enter Address: ";
        getline(cin, address);
        cin.sync();

        int i = 0;
        while(i < 10) {
            cout << "Enter Ornament "<< i + 1 << " ID: ";
            cin.sync();
            cin >> id;
            cin.sync();
            Orn[i] = OrnHead -> searchID(id);
            if(Orn[i] == 0){
                cout << "ID match NOT Found. Try Again." << endl;
                cout << "Continue (y/n) ?  ";
                cin.sync();
                cin >> ch;
                cin.sync();
                if(ch == 'y') continue;
                else {
                    i--;
                    break;
                }
            }
            else {
                cout << "ID match Found." << endl << "Product: " << endl;
                Orn[i] -> display();
                cout << "Price: " << Orn[i] -> calculatePrice() << endl;
                cout << "Press \'y\' to Confirm: ";
                cin >> ch;
                if(ch != 'y') continue;
            }

            cout << "Continue (y/n) ? ";
            cin >> ch;

            if(ch == 'n') {
                cout << endl << endl;
                break;
            }

            if(i == 9) cout << "You Have Taken the Maximum Amount of Items." << endl << "For more, get a new Receipt." << endl << endl;
            i++;
        }

        if(Orn[0] == NULL){
            cout << "NO ITEM PURCHASED" << endl;
            return OrnHead;
        }

        int item = i + 1;
        out.open("Receipt.txt", ios::app);

        out << endl;
        out << endl <<  "  ______      _____       _          _   _                  _ ________          ________ _      _      ______ _____   _____  ";
        out << endl <<  " |  ____/\\   |  __ \\     | |   /\\   | \\ | |   /\\           | |  ____\\ \\        / /  ____| |    | |    |  ____|  __ \\ / ____| ";
        out << endl <<  " | |__ /  \\  | |__) |    | |  /  \\  |  \\| |  /  \\          | | |__   \\ \\  /\\  / /| |__  | |    | |    | |__  | |__) | (___   ";
        out << endl <<  " |  __/ /\\ \\ |  _  / _   | | / /\\ \\ | . ` | / /\\ \\     _   | |  __|   \\ \\/  \\/ / |  __| | |    | |    |  __| |  _  / \\___ \\  ";
        out << endl <<  " | | / ____ \\| | \\ \\| |__| |/ ____ \\| |\\  |/ ____ \\   | |__| | |____   \\  /\\  /  | |____| |____| |____| |____| | \\ \\ ____) | ";
        out << endl <<  " |_|/_/    \\_\\_|  \\_\\\\____//_/    \\_\\_| \\_/_/    \\_\\   \\____/|______|   \\/  \\/   |______|______|______|______|_|  \\_\\_____/  ";
        out << endl << endl;
        for (int i = 0; i < 32; i++) out << "-";
        out << "XX XXXXXXX, XXXXXX XXXXXX (1st Floor), Tongi Bazar, Gazipur.";
        for (int i = 0; i < 32; i++) out << "-";
        out << endl;
        for (int i = 0; i < 36; i++) out << "-";
        out << "A Reliable Shop for Getting the Best Quality Jewelry";
        for (int i = 0; i < 36; i++) out << "-";
        out << endl;
        for (int i = 0; i < 55; i++) out << "-";
        out << "MONEY RECEIPT";
        for (int i = 0; i < 56; i++) out << "-";
        out << endl;


        out << left << setw(9) << "NAME: " << name << endl;
        out << left << setw(9) << "ADDRESS: " << address << endl;
        out << left << setw(9) << "DATE: " << date << endl << endl << endl;

        out << left << setw(10) << "No." << left << setw(20) << "ITEM ID" << left << setw(33) << "ITEM TYPE" << right << setw(18) << setprecision(2) << "WEIGHT" << right << setw(15) << setprecision(2) << "PRICE" << endl;

        for(i = 0; i < item; i++) {
            out << left << setw(10) << i + 1 << left << setw(20) << Orn[i] -> getID() << left << setw(33) << Orn[i] -> getType() << right << setw(18) << setprecision(2) << Orn[i] -> getWeight() << right << setw(15) << setprecision(2) << Orn[i] -> calculatePrice() << endl;
            total_amount += Orn[i] -> calculatePrice();
        }
        for(int l = 0; l < 124; l++) out << "-";

        out << right << setw(103) << "TOTAL AMOUNT" << "  " << left << setw(14) << setprecision(2) << total_amount << endl << endl << endl;
        for(int l = 0; l < 124; l++) out << "-";
        out << endl << endl;
        out << left << setw(62) << "Consumer's Signature" << right << setw(62) << "Proprietor's Signature" << endl;
        out << "THANK YOU. COME AGAIN!!!";
        out.close();


        cout << "Receipt Generated." << endl << "Do you want to check the receipt (y/n) ? ";
        cin >> ch;
        if(ch == 'y') {
            in.open("Receipt.txt");
            while(getline(in, str))
                cout << str << endl;
            in.close();
        }

        cout << endl << endl;
        cout << "Deleting Sold Items from Stock" << endl;
        for(i = 0; i < item; i++) //DELETING the SOLD ORNAMENTS from STOCK
            OrnHead = OrnHead -> deleteOrnID(Orn[i] -> getID());

        return OrnHead;
    }

};


//Read Ornament Detail While Registering Stock
void Ornament :: read() {
    int int_ratti;
    unsigned short int Karat;
    char yn;
    cout << endl << endl << "Enter Ornament ID: ";
    cin.sync();
    cin >> id;
    cout << "Enter Ornament Type: ";
    cin.sync();
    getline(cin, type);
    while(true) {
        cin.sync();
        cout << "Do you want to include Description (y/n)? ";
        cin >> yn;
        cin.sync();
        if(yn == 'Y' || yn == 'y') {
            cout << "Description: ";
            cin.sync();
            getline(cin, description);
            cin.sync();
            break;
        }
        else if(yn == 'N' || yn == 'n') {
            cout << "***Description skipped***" << endl;
            break;
        }
        else
            cout << "Invalid Input, Try Again." << endl;
    }
    cin.sync();
    while(true){ //KARAT INPUT
        cout << "Enter Ornament Karat: ";
        cin >> Karat;
        if(Karat == 18 || Karat == 20 || Karat == 21 || Karat == 22) {
            karat = Karat;
            break;
        }
        else cout << "Invalid Karat Value, Try Again." << endl;
    }
    while(true) {
        cout << "Input Weight in Gram/Tola (g/t): ";
        cin.sync();
        cin >> yn;
        cin.sync();
        if(yn == 'G' || yn == 'g'){
            cout << "Enter Ornament Weight in GRAM: ";
            cin.sync();
            cin >> weight;
            cin.sync();
            weight = fabs(weight);
            ratti = weight / R2G;
            int_ratti = ratti;
            bhari = ratti / 96;
            anni = (int_ratti % 96) / 6;
            ratti = (int_ratti % 96 % 6) + ratti - int_ratti;
            break;
        }
        else if(yn == 'T' || yn == 't') {
            readTola();
            weight = Tola(bhari, anni, ratti);
            break;
        }
        else cout << "Invalid input, Try Again." << endl;
    }
}


//Display All the Ornaments
void listStock(Ornament *Head) {
    Ornament *OrnCurrent;
    cout << left << setw(15) << "TYPE" <<  left << setw(7) << "ID" << right << setw(7) << "KARAT" << right << setw(11) << "GRAM" << right << setw(11) << "TOLA" << right  << "  " << left << "DSCRIPTION" << endl;
    for(OrnCurrent = Head; OrnCurrent != NULL; OrnCurrent = OrnCurrent -> getNext())
        cout << left << setw(15) << OrnCurrent -> type <<  left << setw(7) << OrnCurrent -> id << right << setw(7) << OrnCurrent -> karat << right << setw(11) << setprecision(2) << OrnCurrent -> weight << right << setw(4) << OrnCurrent -> bhari << "." << setw(2) << OrnCurrent -> anni <<  "." << setw(3) << setprecision(1) << OrnCurrent -> ratti << right  << "  " << left << OrnCurrent -> description << endl;

    cout << endl << "***End of List***" << endl << "Enter 0 to Go Back: ";
    while(getchar() != '0');
    cout << endl << endl;
}


//Searches an Ornament by ID
Ornament * Ornament :: searchID(string idF) {
    Ornament *Current = this;
    if(this -> karat != 18 && this -> karat != 20 && this -> karat != 21 && this -> karat != 22)
        return 0;
    while(Current != NULL){
        if(Current -> id == idF) return Current;
        else Current = Current -> getNext();
    }
    return 0;
}


Ornament * Ornament :: deleteOrnID(string idF) {
    Ornament *Current = this;
    Ornament *Last;
    while(Current != NULL){
        if(Current -> id == idF) {
            if(Current == this) {
                Last = this -> getNext();
                delete this;
                cout << "Deletion Confirmed" << endl;
                return Last;
            }
            else if(Current -> getNext() == NULL) {
                Last -> setNext(NULL);
                delete Current;
                cout << "Deletion Confirmed" << endl;
                return this;
            }
            else {
                Last -> setNext(Current -> getNext());
                delete Current;
                cout << "Deletion Confirmed" << endl;
                return this;
            }
        }
        else {
            Last = Current;
            Current = Current -> getNext();
        }

    }
    cout << "Deletion ERROR!!!" << endl;
    cout << "NO MATCH FOUND!!!" << endl;
    return this;
}





int main() {
    cout.setf(ios::fixed);
    unsigned short int updatechoice;
    unsigned short int choice;
    char cont;
    bool saleStat = false;
    string id;
    string date;
    string str;

    Ornament *OrnHead; //Contains the First Ornament Object
    Ornament *OrnCurrent;
    Ornament *OrnTail; //Contains the Last Ornament Object
    Sale *SaleHead = NULL;
    Sale *SaleCurrent;
    Sale *SaleTail;

    ifstream in;



    //DISPLAY STARTS from HERE!!!
    shopTitle();

    while(true) {
        cout << "Welcome!!!" << endl;
        cout << "Enter Todays Date: ";
        cin.sync();
        getline(cin, date);
        cin.sync();
        cout << endl << endl;

        while(true) {
            cout << "-----MAIN MENU-----" << endl;
            cout << "Enter 1 to Check Stock." << endl;
            cout << "Enter 2 to Update Stock." << endl;
            cout << "Enter 3 to Update Gold Price Rate." << endl;
            cout << "Enter 4 to Check Gold Price Rate." << endl;
            cout << "Enter 5 to Sell Ornaments." << endl;
            cout << "Enter 6 to Check all Sales." << endl;
            cout << "Enter 0 To End the Day. " << endl;

            cout << endl << "Enter Your Choice: ";
            cin.sync();
            cin >> choice;
            cout << endl << endl;

            if(choice == 1) { //Check Stock
                if(OrnHead -> getKarat() != 18 && OrnHead -> getKarat() != 20 && OrnHead -> getKarat() != 21 && OrnHead -> getKarat() != 22 ) {
                    cout << "Sorry! Stock is Empty!!! \nUpdate Stock before Checking.  ";
                    cin.sync();
                    getchar();
                    cin.sync();
                    cout  << endl << endl;
                }
                else listStock(OrnHead);
            }

            else if(choice == 2) {//Update Stock
                while(true) {
                    cout << "-----UPDATE STOCK-----" << endl;
                    cout << "1 - Add Ornaments" << endl;
                    cout << "2 - Delete Ornaments" << endl;
                    cout << "0 - Go Back" << endl;
                    cout << "Enter Choice: ";
                    cin >> updatechoice;
                    if(updatechoice == 1) { //ADD Ornaments
                        while(true) {
                            if(OrnHead -> getKarat() != 18 && OrnHead -> getKarat() != 20 && OrnHead -> getKarat() != 21 && OrnHead -> getKarat() != 22)
                                    OrnCurrent = OrnHead = new Ornament();
                            else {
                                OrnCurrent = new Ornament();
                                OrnTail -> setNext(OrnCurrent);
                            }
                            OrnCurrent -> read();
                            OrnTail = OrnCurrent;
                            cout << "Do You Want to Continue (y/n) ? ";
                            cin.sync();
                            cin >> cont;
                            if(cont != 'y') break;
                        }
                        cout << endl << endl;
                    }
                    else if(updatechoice == 2) { //DELETE Ornaments
                        while(true) {
                            cout << "Enter Ornament ID to Delete from Stock: ";
                            cin >> id;
                            OrnHead = OrnHead -> deleteOrnID(id);
                            cout << "Do You Want to Continue (y/n) ? ";
                            cin >> cont;
                            if(cont != 'y') break;
                            cout << endl << endl;
                        }
                        cout << endl << endl;
                    }
                    else if(updatechoice == 0){
                        cout << endl << endl;
                        break;
                    }
                    else cout << "Invalid Input. Try Again" << endl << endl;
                }

            }

            else if(choice == 3) //Update Price
                R.read(date);

            else if(choice == 4) {//Check Price
                cout << "-----PRICE LIST-----" << endl;
                if(R.getDate() == "N/A") {
                    cout << "Price Not Entered Yet." << endl << "Enter Price and Try Again...  ";
                    cin.sync();
                    getchar();
                    cin.sync();
                    cout << endl << endl << endl;
                }
                else R.display();
            }

            else if(choice == 5) {
                if(OrnHead -> getKarat() != 18 && OrnHead -> getKarat() != 20 && OrnHead -> getKarat() != 21 && OrnHead -> getKarat() != 22 ) cout << "Sorry! Stock is Empty!!! \nUpdate Stock. " << endl << endl;
                else if(R.getDate() == "N/A") cout << "Price Not Entered Yet." << endl << "Enter Price and Try Again...  " << endl << endl;
                else{
                    cout << "-----SELLING ORNAMENTS-----" << endl;
                    while(true) {
                        if(!saleStat) {
                            SaleCurrent = SaleHead = new Sale();
                            saleStat = true;
                        }
                        else {
                            SaleCurrent = new Sale();
                            SaleTail -> setNext(SaleCurrent);
                        }
                        OrnHead = SaleCurrent -> read(OrnHead, date);
                        SaleTail = SaleCurrent;
                        cout << "Do You Want to Continue (y/n) ? ";
                        cin.sync();
                        cin >> cont;
                        cout << endl << endl;
                        if(cont == 'n') break;
                    }
                }
             }

            else if(choice == 6) {
                cout << " ALL RECEIPTS of TODAY" << endl;
                in.open("Receipt.txt");
                while(getline(in, str))
                    cout << str << endl;
                cout << endl << endl << "######  END ######" << endl << endl;
                in.close();
            }

            else if(choice == 0) {
                cout << "Thank You." << endl << "Closing Shop for Today..." << endl;
//DELETING ALL SALE OBJECTS
            if(SaleHead != NULL) {
                for(SaleCurrent = SaleHead; SaleCurrent != NULL; SaleCurrent = SaleTail) {
                    SaleTail = SaleCurrent -> getNext();
                    delete SaleCurrent;
                }
                saleStat = false;
            }
                break;
            }

            else
                cout << "Invalid Choice!!!" << "Try Again." << endl << endl;
        }

        cout << "Do You Want to Continue? (y/n) ";
        cin >> cont;
        if(cont == 'n' || cont == 'N') {
            cout << "Exiting...." << endl;
            exit(1);
        }
        cout << endl << endl << endl;
    }

	return 0;
}