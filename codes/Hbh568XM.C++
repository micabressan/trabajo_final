enum spec
{
    War = 1, Wiz = 2, Arch = 3
};


class Game
{
public:
    v new_game();
    v load_game();
};

 
class Heroes
{
public:
    void lvl_up();

protected:
    string _name;
    int _HP;
    int _strength
    int _lvl;
    int _experience;
    spec _specialization;
};
 

class Warrior :private Heroes
{
public:
    Warrior();
    ~Warrior(){}
    friend class Game;
};


class Wizard :private Heroes
{
public:
    Wizard();
    ~Wizard(){}
 
    friend class Game;
};


class Archer :private Heroes
{
public:
    Archer(); 
    ~Archer(){}
    friend class Game;
};


class Player : public Heroes
{
public:
    Player(int HP, int strength, int lvL, int experience, string name, spec specialization); 
    ~Player(){}
};