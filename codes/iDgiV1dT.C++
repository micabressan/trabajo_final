#include <iostream>
#include <string>
#include <ctime>
#include <cstdlib>
#include "calculScores.h"

using namespace std;

string melangerLettres(string mot)
{
    string melange;
    int position(0);

    // Tant que nous n'avons pas extrait toutes les lettres du mot
    while (mot.size() != 0)
    {
        // On choisit un numéro de lettre au hasard dans le mot
        position = rand() % mot.size();
        // On ajoute la lettre dans le mot mélangé
        melange += mot[position];
        // On retire cette lettre du mot mystère pour ne pas la prendre une 2e fois
        mot.erase(position, 1);
    }

    // On renvoie le mot mélangé
    return melange;
}

int main()
{
    string motMystere, motMelange, motUtilisateur, nouvellePartie("oui");
    int score (0);
    int parties (0);
    int calculScores[5];
    calculScores[0] = 100;
        calculScores[1] = 200
        ;
            calculScores[2] = 300;
                calculScores[3] = 400;
                    calculScores[4] = 500;




do {
    // Initialisation des nombres aléatoires
    srand(time(0));



    // 1 : On demande à saisir un mot
    cout << "Saisissez un mot" << endl;
    cin >> motMystere  ;
    cout << " " << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl  << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl;

    // 2 : On récupère le mot avec les lettre mélangées dans motMelange
    motMelange = melangerLettres(motMystere);
    int essais(5);

    // 3 : On demande à l'utilisateur quel est le mot mystère
    do
    {
        ++parties;
        cout << endl << "Quel est ce mot ? " << motMelange << endl;
        cout << "Il vous reste " << essais << " essais" << endl;
        cin >> motUtilisateur;

        if (motUtilisateur == motMystere)
        {
            cout << "Bravo !" << endl;
            score += calculScores[essais--];
            
            cout << "Une nouvelle partie ? (oui/non)" << endl;
            cin >> nouvellePartie;
        }
        else
        {

             cout << "Ce n'est pas le mot !" << endl;
            essais--;

            if (essais < 1) {
            cout << "Vous avez perdu !" << endl;
            cout << "Une nouvelle partie ? (oui/non)" << endl;
            cin >> nouvellePartie ;
            }

        }
    }while (motUtilisateur != motMystere && essais > 0); // On recommence tant qu'il n'a pas trouvé
    }while (nouvellePartie == "oui");
    cout << "Ton score est de" << score << "sur" << parties << "parties";

    return 0;
}