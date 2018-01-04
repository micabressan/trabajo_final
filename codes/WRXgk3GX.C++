#include <iostream>
#include <map>
#include <memory>
// #include <bits/unique_ptr.h> unique_ptr mas uz v memory takze to tam je zbytecne mozna to i skodi;

class Account {
public:
    virtual bool withdraw(double) = 0;
    virtual bool deposit(double) = 0;
    virtual double balance() const = 0;
    virtual ~Account() = default;
    virtual std::unique_ptr<Account> copy() const = 0;
};


class MyAccount : public Account {
private:
    double money = 0;
public:

    MyAccount(){} // mam dojem ze ty tridy mnely bejt default constructable tak bacha kdyz vytvoris jinej constructor tak prides o defoult
    MyAccount(const MyAccount& other) : money(other.balance()) {}

    bool withdraw(double in) override {
        if (in < 0) {
            std::cerr << "use deposit\n";
            return false;
        }
        if (money - in >= 0) {
            money -= in;
            return true;
        }
        return false;
    }

    bool deposit(double in) override {
        if (in < 0) {                      //nejspíše si získláš nějaká malá plus když budeš ošetřovat takoveto blbosti
            std::cerr << "use withdraw\n"; // ale dělej to až budeš mít ready kod nebo už nebudeš vědět jak dal
            return false;
        }
        money += in;
        return true;
    }

    double balance() const override  {
        return money;
    }

    std::unique_ptr<Account> copy() const override {
        //std::unique_ptr<Account> a(new MyAccount(*this));                 syntaxe na vytvoření uniqePtr pomoci new moc to nepoužívej nemaj to radi
        std::unique_ptr<Account> a = std::make_unique<MyAccount>(*this);   // správná syntax make unique si zavolá potřebný konstruktor v tomto případě kopírovací
        return a;
    }

};

class Bank {
private:
    std::map<std::string, std::unique_ptr<Account>> accounts; // string a uniquePtr protože referenci nemůžeš mít v mapě
public:                                                      // mam dojem že to je kvůli tomu že reference na abstraktní třídu není defaoult constructable když používáš [], zatím co hodnota uniquePtr ne nullptr
    Account& createAccount(const std::string& name, const Account& acc) {
        accounts[name] = acc.copy();
        Account* NULLPTR = accounts["asdada"].get();
        if (NULLPTR == nullptr) std::cout << "je to nullptr viz komenty\n";
        return *accounts[name].get(); // metoda .get() uděla z uniquePtr normal pointer

    }

    Account& getAccount(const std::string& name) {
        return *accounts[name].get(); // pozor vraci nullptr kdyz dane jmeno neni v poly tak ho vytvori a nastavi acount na nullptr raci to projdi forem.
    }

};

int main()
{
    MyAccount acc = MyAccount();
    acc.deposit(500.0);
    Bank bank = Bank();
    Account& a = bank.createAccount("ja", acc);
    Account& b = bank.getAccount("ja");

    acc.deposit(100.0);
    a.withdraw(50.0);

    std::cout << "original: " << acc.balance() << " kopie v bance (a i b ukazuji na to stejne): " << b.balance();


    return 0;
}