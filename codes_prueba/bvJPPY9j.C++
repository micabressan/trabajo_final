#include "FenetrePrincipale.h"
#include "Formulaire.h"
#include "Tempsdereaction.h"
#include "apm.h"
#include <QPushButton>
#include <QWidget>
#include <QGridLayout>
#include <QLayout>
#include <QMessageBox>
#include <QtGlobal>
#include <cstdlib>
#include <time.h>
#include <QTimer>

Reaction::Reaction():QWidget()
{
    setFixedSize(900, 900);
    layoutgrille = new QGridLayout;
    demarreur = new QPushButton("Commencer");
    aide = new QPushButton("Aide");
    timerstart = new QTimer;
    int compteur(0);

    timerreaction = new QTimer;
    timerreaction->setTimerType(Qt::PreciseTimer);

    //cible
    cible1 = new QPushButton;
    cible2 = new QPushButton;
    cible3 = new QPushButton;
    cible4 = new QPushButton;
    cible5 = new QPushButton;
    cible6 = new QPushButton;
    cible7 = new QPushButton;
    cible8 = new QPushButton;
    cible9 = new QPushButton;
    cible10 = new QPushButton;
    cible11 = new QPushButton;
    cible12 = new QPushButton;
    cible13 = new QPushButton;
    cible14 = new QPushButton;
    cible15 = new QPushButton;
    cible16 = new QPushButton;
    cible17 = new QPushButton;
    cible18 = new QPushButton;
    cible19 = new QPushButton;
    cible20 = new QPushButton;
    cible21 = new QPushButton;
    cible22 = new QPushButton;
    cible23 = new QPushButton;
    cible24 = new QPushButton;
    cible25 = new QPushButton;




    //bouton dans le layout
    layoutgrille->addWidget(cible1,0,0);
    layoutgrille->addWidget(cible2,0,1);
    layoutgrille->addWidget(cible3,0,2);
    layoutgrille->addWidget(cible4,0,3);
    layoutgrille->addWidget(cible5,0,4);

    layoutgrille->addWidget(cible6,1,0);
    layoutgrille->addWidget(cible7,1,1);
    layoutgrille->addWidget(cible8,1,2);
    layoutgrille->addWidget(cible9,1,3);
    layoutgrille->addWidget(cible10,1,4);

    layoutgrille->addWidget(cible11,2,0);
    layoutgrille->addWidget(cible12,2,1);
    layoutgrille->addWidget(cible13,2,2);
    layoutgrille->addWidget(cible14,2,3);
    layoutgrille->addWidget(cible15,2,4);

    layoutgrille->addWidget(cible16,3,0);
    layoutgrille->addWidget(cible17,3,1);
    layoutgrille->addWidget(cible18,3,2);
    layoutgrille->addWidget(cible19,3,3);
    layoutgrille->addWidget(cible20,3,4);

    layoutgrille->addWidget(cible21,4,0);
    layoutgrille->addWidget(cible22,4,1);
    layoutgrille->addWidget(cible23,4,2);
    layoutgrille->addWidget(cible24,4,3);
    layoutgrille->addWidget(cible25,4,4);


    cible1->setFixedSize(200,150);
    cible2->setFixedSize(200,150);
    cible3->setFixedSize(200,150);
    cible4->setFixedSize(200,150);
    cible5->setFixedSize(200,150);
    cible6->setFixedSize(200,150);
    cible7->setFixedSize(200,150);
    cible8->setFixedSize(200,150);
    cible9->setFixedSize(200,150);
    cible10->setFixedSize(200,150);
    cible11->setFixedSize(200,150);
    cible12->setFixedSize(200,150);
    cible13->setFixedSize(200,150);
    cible14->setFixedSize(200,150);
    cible15->setFixedSize(200,150);
    cible16->setFixedSize(200,150);
    cible17->setFixedSize(200,150);
    cible17->setFixedSize(200,150);
    cible18->setFixedSize(200,150);
    cible19->setFixedSize(200,150);
    cible20->setFixedSize(200,150);
    cible21->setFixedSize(200,150);
    cible22->setFixedSize(200,150);
    cible23->setFixedSize(200,150);
    cible24->setFixedSize(200,150);
    cible25->setFixedSize(200,150);

    cible1->setEnabled(false);
    cible2->setEnabled(false);
    cible3->setEnabled(false);
    cible4->setEnabled(false);
    cible5->setEnabled(false);
    cible6->setEnabled(false);
    cible7->setEnabled(false);
    cible8->setEnabled(false);
    cible9->setEnabled(false);
    cible10->setEnabled(false);
    cible11->setEnabled(false);
    cible12->setEnabled(false);
    cible13->setEnabled(false);
    cible14->setEnabled(false);
    cible15->setEnabled(false);
    cible16->setEnabled(false);
    cible17->setEnabled(false);
    cible18->setEnabled(false);
    cible19->setEnabled(false);
    cible20->setEnabled(false);
    cible21->setEnabled(false);
    cible22->setEnabled(false);
    cible23->setEnabled(false);
    cible24->setEnabled(false);
    cible25->setEnabled(false);


    layoutgrille->addWidget(demarreur);
    layoutgrille->addWidget(aide);


    //hide les cibles au debut
    cible1->hide();
    cible2->hide();
    cible3->hide();
    cible4->hide();
    cible5->hide();
    cible6->hide();
    cible7->hide();
    cible8->hide();
    cible9->hide();
    cible10->hide();
    cible11->hide();
    cible12->hide();
    cible13->hide();
    cible14->hide();
    cible15->hide();
    cible16->hide();
    cible17->hide();
    cible18->hide();
    cible19->hide();
    cible20->hide();
    cible21->hide();
    cible22->hide();
    cible23->hide();
    cible24->hide();
    cible25->hide();

    setLayout(layoutgrille);

    //action des bouttons
    connect(demarreur, SIGNAL(clicked()), this, SLOT(start()));
    connect(demarreur, SIGNAL(clicked()), demarreur, SLOT(hide()));
    connect(demarreur, SIGNAL(clicked()), aide, SLOT(hide()));
    connect(aide, SIGNAL(clicked()), this, SLOT(aidecall()));

    connect(cible1, SIGNAL(released()), this, SLOT(start()));
    connect(cible2, SIGNAL(released()), this, SLOT(start()));
    connect(cible3, SIGNAL(released()), this, SLOT(start()));
    connect(cible4, SIGNAL(released()), this, SLOT(start()));
    connect(cible5, SIGNAL(released()), this, SLOT(start()));
    connect(cible6, SIGNAL(released()), this, SLOT(start()));
    connect(cible7, SIGNAL(released()), this, SLOT(start()));
    connect(cible8, SIGNAL(released()), this, SLOT(start()));
    connect(cible9, SIGNAL(released()), this, SLOT(start()));
    connect(cible10, SIGNAL(released()), this, SLOT(start()));
    connect(cible11, SIGNAL(released()), this, SLOT(start()));
    connect(cible12, SIGNAL(released()), this, SLOT(start()));
    connect(cible13, SIGNAL(released()), this, SLOT(start()));
    connect(cible14, SIGNAL(released()), this, SLOT(start()));
    connect(cible15, SIGNAL(released()), this, SLOT(start()));
    connect(cible16, SIGNAL(released()), this, SLOT(start()));
    connect(cible17, SIGNAL(released()), this, SLOT(start()));
    connect(cible18, SIGNAL(released()), this, SLOT(start()));
    connect(cible19, SIGNAL(released()), this, SLOT(start()));
    connect(cible20, SIGNAL(released()), this, SLOT(start()));
    connect(cible21, SIGNAL(released()), this, SLOT(start()));
    connect(cible22, SIGNAL(released()), this, SLOT(start()));
    connect(cible23, SIGNAL(released()), this, SLOT(start()));
    connect(cible24, SIGNAL(released()), this, SLOT(start()));
    connect(cible25, SIGNAL(released()), this, SLOT(start()));

    //reset des boutons
    connect(cible1, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible2, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible3, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible4, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible5, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible6, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible7, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible8, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible9, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible10, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible11, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible12, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible13, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible14, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible15, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible16, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible17, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible18, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible19, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible20, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible21, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible22, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible23, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible24, SIGNAL(released()), this, SLOT(resetbouton()));
    connect(cible25, SIGNAL(released()), this, SLOT(resetbouton()));

    //arret du chrono
    connect(cible1, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible2, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible3, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible4, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible5, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible6, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible7, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible8, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible9, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible10, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible11, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible12, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible13, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible14, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible15, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible16, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible17, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible18, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible19, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible20, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible21, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible22, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible23, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible24, SIGNAL(released()), this, SLOT(arretchrono()));
    connect(cible25, SIGNAL(released()), this, SLOT(arretchrono()));


    connect(timerstart, SIGNAL(timeout()), this, SLOT(jeureactionslot()));
}


int Reaction::rand_a_b(int a, int b)
{
    return rand()%(b-a) +a;
}

void Reaction::arretchrono()
{
   timerreaction->stop();

}


void Reaction::resetbouton()
{
cible1->setEnabled(false);
cible2->setEnabled(false);
cible3->setEnabled(false);
cible4->setEnabled(false);
cible5->setEnabled(false);
cible6->setEnabled(false);
cible7->setEnabled(false);
cible8->setEnabled(false);
cible9->setEnabled(false);
cible10->setEnabled(false);
cible11->setEnabled(false);
cible12->setEnabled(false);
cible13->setEnabled(false);
cible14->setEnabled(false);
cible15->setEnabled(false);
cible16->setEnabled(false);
cible17->setEnabled(false);
cible18->setEnabled(false);
cible19->setEnabled(false);
cible20->setEnabled(false);
cible21->setEnabled(false);
cible22->setEnabled(false);
cible23->setEnabled(false);
cible24->setEnabled(false);
cible25->setEnabled(false);

}
void Reaction::jeureaction()
{

    int nbAleatoire;

      srand(time(NULL));

      nbAleatoire = rand_a_b(0, 25);\
      if(compteur <=50)
      {
       if(nbAleatoire == 0)
       {
           timerreaction->start(2000);
           cible1->setEnabled(true);
           timerstart->start(2000);
           timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 1)
       {
           timerreaction->start(2000);
         cible2->setEnabled(true);
         timerstart->start(2000);
         timerstart->stop();
       ++compteur;
       }
       else if(nbAleatoire == 2)
       {
           timerreaction->start(2000);
         cible3->setEnabled(true);
        timerstart->start(2000);
         timerstart->stop();
         ++compteur;
       }
        else if(nbAleatoire == 3)
       {
           timerreaction->start(2000);
          cible4->setEnabled(true);
          timerstart->start(2000);
          timerstart->stop();
         ++compteur;
       }
       else if(nbAleatoire == 4)
       {
           timerreaction->start(2000);
            cible5->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
        else if(nbAleatoire == 5)
       {
           timerreaction->start(2000);
        cible6->setEnabled(true);
        timerstart->start(2000);
        timerstart->stop();
        ++compteur;
       }
       else if(nbAleatoire == 6)
       {
           timerreaction->start(2000);
           cible7->setEnabled(true);
           timerstart->start(2000);
           timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 7)
       {
           timerreaction->start(2000);
            cible8->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 8)
       {
           timerreaction->start(2000);
            cible9->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 9)
       {
           timerreaction->start(2000);
            cible10->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 10)
       {
           timerreaction->start(2000);
            cible11->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 11)
       {
           timerreaction->start(2000);
            cible12->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 12)
       {
           timerreaction->start(2000);
            cible13->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 13)
       {
           timerreaction->start(2000);
            cible14->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 14)
       {
           timerreaction->start(2000);
           cible15->setEnabled(true);
           timerstart->start(2000);
           timerstart->stop();
          ++compteur;
       }
       else if(nbAleatoire == 15)
       {
           timerreaction->start(2000);
            cible16->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 16)
       {
           timerreaction->start(2000);
            cible17->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 17)
       {
           timerreaction->start(2000);
            cible18->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
           ++compteur;
       }
       else if(nbAleatoire == 18)
       {
           timerreaction->start(2000);
            cible19->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 19)
       {    timerreaction->start(2000);
            cible20->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 20)

       {    timerreaction->start(2000);
            cible21->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 21)
       {
            timerreaction->start(2000);
           cible22->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 22)
       {
           timerreaction->start(2000);
            cible23->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 23)
       {
           timerreaction->start(2000);
            cible24->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
            ++compteur;
       }
       else if(nbAleatoire == 24)
       {
           timerreaction->start(2000);
            cible25->setEnabled(true);
            timerstart->start(2000);
            timerstart->stop();
           ++compteur;
       }
       else
       {
           QMessageBox::information(this, "Aide", "Ceci est le test de temps de réaction. Vous devez appuyer le plus vite possible sur le bouton qui apparait. Ce test dure 3 minutes");
       };
      }
      else
       {
          QMessageBox::information(this, "Résultats", "Votre moyenne est de:");
          hide();
      };


    }



void Reaction::reactioncall()
{
  show();
}

void Reaction::jeureactionslot()
{
    jeureaction();
}

void Reaction::start()
{

    timerstart->start(2000);
    cible1->show();
    cible2->show();
    cible3->show();
    cible4->show();
    cible5->show();
    cible6->show();
    cible7->show();
    cible8->show();
    cible9->show();
    cible10->show();
    cible11->show();
    cible12->show();
    cible13->show();
    cible14->show();
    cible15->show();
    cible16->show();
    cible17->show();
    cible18->show();
    cible19->show();
    cible20->show();
    cible21->show();
    cible22->show();
    cible23->show();
    cible24->show();
    cible25->show();

}

void Reaction::aidecall()
{
    QMessageBox::information(this, "Aide", "Ceci est le test de temps de réaction. Vous devez appuyer le plus vite possible sur le bouton qui apparait. Ce test dure 3 minutes");

}