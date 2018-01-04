#include <iostream>
using namespace std;


int menu()
{

    Catalogue *MonCatalogue = new Catalogue();


    cout << "Bonjour et bienvenu dans votre agence de voyage !" << endl;
    cout << "Que voulez vous faire ?" << endl << endl;
    cout << "\t1 - Ajouter un voyage au catalogue" << endl;
    cout << "\t2 - Afficher le catalogue" << endl;
    cout << "\t3 - Chercher un voyage direct" << endl;
    cout << "\t4 - Chercher un voyage avec correspondance éventuelle" << endl;
    cout << "\t0 - Quitter" << endl;
    cout << endl;

    unsigned int choix;
    char * depart;
    char * arrivée;
    char * moyen;


    cin >> choix;
    while (choix != 0)
    {
        if (choix == 1)
        {
            cout << "Veulliez indiquer le départ, l'arrivée et le moyen de transport de votre trajet :" << endl;
            cin >> depart;
            cin >> arrivee;
            cin >> moyen;
            MonCatalogue->AjouterTrajet(depart, arrivee, moyen);
            cout << "Trajet ajouté !" << endl;
        }
        if (choix == 2)
        {
            MonCatalogue->Afficher();
        }
        if (choix == 3)
        {
            cout << "Veulliez indiquer le départ et l'arrivée de votre voyage :" << endl;
            cin >> depart;
            cin >> arrivee;
            MonCatalogue->RechercherSimple(depart, arrivee);
            cout << "A vous de choisir !" << endl;
        }
        if (choix == 4)
        {
            cout << "Veulliez indiquer le départ et l'arrivée de votre voyage :" << endl;
            cin >> depart;
            cin >> arrivee;
            MonCatalogue->RechercherAvancee(depart, arrivee);
            cout << "A vous de choisir !" << endl;
        }

        cout << endl << "Maintenant, que voulez vous faire ?" << endl << endl;
        cout << "\t1 - Ajouter un voyage au catalogue" << endl;
        cout << "\t2 - Afficher le catalogue" << endl;
        cout << "\t3 - Chercher un voyage direct" << endl;
        cout << "\t4 - Chercher un voyage avec correspondance éventuelle" << endl;
        cout << "\t0 - Quitter" << endl;

        cin >> choix;
    }   // Fin du while

    cout << "Good bye and have a nice trip ! ;)" << endl;

    delete MonCatalogue;

    return 0;
}