#include <cstdio>
#include <vector>
using namespace std;

const int NB_NOEUD_MAX = 1000*100 + 1;
vector <int> voisin[NB_NOEUD_MAX];
int dist[NB_NOEUD_MAX], filsMin = NB_NOEUD_MAX, nbNoeud;
bool dejaVu[NB_NOEUD_MAX];

int marqueProf(int idNoeud)
{
    if(dejaVu[idNoeud] == true)
        return 0;
    int nbFils = 0;
    dejaVu[idNoeud] = true;
    for(unsigned int idFils = 0; idFils < voisin[idNoeud].size(); idFils++)
        nbFils += marqueProf(voisin[idNoeud][idFils]);
    dist[idNoeud] = nbFils;
    dejaVu[idNoeud] = false;
    return nbFils+1;
}

void chercheMin(int idNoeud)
{
    //printf("%d ", idNoeud);
    if(dejaVu[idNoeud] == true)
        return;
    dejaVu[idNoeud] = true;
    int voisinMax = -1, idVoisinMax, poidVoisin = 0;
    for(unsigned int idVoisin = 0; idVoisin < voisin[idNoeud].size(); idVoisin++)
    {
        //poidVoisin += dist[voisin[idNoeud][idVoisin]];
        //printf("id %d, poid %d\n", voisin[idNoeud][idVoisin], dist[voisin[idNoeud][idVoisin]]);
        if(dist[voisin[idNoeud][idVoisin]] > voisinMax)
        {
            voisinMax = dist[voisin[idNoeud][idVoisin]];
            idVoisinMax = voisin[idNoeud][idVoisin];
        }
    }
    dist[idNoeud] = nbNoeud - voisinMax;
    filsMin = min(filsMin, voisinMax);
   // printf("%d\n", filsMin);
    chercheMin(idVoisinMax);
}
int main()
{
    scanf("%d", &nbNoeud);
    int dep, arr;
    for(int i = 0; i < nbNoeud-1; i++)
    {
        scanf("%d%d", &dep, &arr);
        voisin[dep].push_back(arr);
        voisin[arr].push_back(dep);
    }
    marqueProf(1);
    chercheMin(1);
    printf("%d\n", filsMin);
    return 0;
}