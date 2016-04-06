#include <vector>
#include <iostream>
#include <cstdio>

struct Turn {
    int heap;
    int count;

    std::string toString();
};

typedef std::vector<int> Heaps;

class IBot {
public:
    virtual ~IBot() {}
    virtual Turn go(const Heaps& heaps) = 0;
    virtual std::string name() const = 0;
};

class Den4ikpwnz: public IBot {
public:
    Turn go(const Heaps &heaps);
    std::string name() const;
};

class Game {
public:
    void run(IBot *firstPlayer, IBot *secondPlayer, Heaps heaps);

private:
    Heaps removeEmptyHeaps(Heaps heaps);
    bool checkTurn(const Turn& turn, const Heaps &heaps);
};

int main(int argc, char *argv[])
{
    Heaps heaps;
    heaps.push_back(2);
    heaps.push_back(3);
    heaps.push_back(4);
    heaps.push_back(5);

    Den4ikpwnz *den4ik = new Den4ikpwnz();
    Den4ikpwnz *kostik = new Den4ikpwnz();

    Game game;
    game.run(kostik, den4ik, heaps);

    delete den4ik;
    delete kostik;

    return 0;
}


void Game::run(IBot *firstPlayer, IBot *secondPlayer, Heaps heaps)
{
    int winner = -1;
    IBot* bots[2] = { firstPlayer, secondPlayer };
    int player = 0;
    while (true) {
        heaps = removeEmptyHeaps(heaps);
        if (heaps.empty()) {
            winner = player ^ 1;
            break;
        }
        Turn turn = bots[player]->go(heaps);
        if (!checkTurn(turn, heaps)) {
            std::cout << bots[player]->name() << " make invalid move: " << turn.toString() << std::endl;
            break;
        }
        heaps[turn.heap] -= turn.count;
    }
    std::cout << bots[winner]->name() << " win!" << std::endl;
}

Heaps Game::removeEmptyHeaps(Heaps heaps)
{
    for (int i = 0; i < heaps.size();) {
        if (heaps[i] == 0) {
            std::swap(heaps[i], heaps[heaps.size() - 1]);
            heaps.pop_back();
        } else {
            ++i;
        }
    }
    return heaps;
}

bool Game::checkTurn(const Turn &turn, const Heaps& heaps)
{
    return turn.heap >= 0 && turn.heap < heaps.size()
            && turn.count > 0 & turn.count <= heaps[turn.heap];
}

std::string Turn::toString()
{
    char buff[256];
    sprintf(buff, "(%d, %d)", heap, count);
    std::string str(buff);
    return str;
}


Turn Den4ikpwnz::go(const Heaps &heaps)
{
    Turn turn;
    turn.heap = 0;
    turn.count = 1;
    return turn;
}

std::string Den4ikpwnz::name() const
{
    return "Den4ik";
}