BST.h:

#ifndef BST_H_INCLUDED
#define BST_H_INCLUDED
#include "Item.h"
#include <stdlib.h>
#include <stdio.h>

typedef struct node *link;
typedef struct bst *BST;

int BSTcount(BST tree,int livello_1,int livello_2);
int BSTdistance(BST tree,char *chiave_1,char *chiave_2);
void BSTfree(BST tree);
void BSTmirror(BST tree);
BST BSTreadPreorder(FILE *file);
void BSTwritePreorder(FILE *file,BST tree);
void conteggio(link x,link nodo_fittizio,int *contatore,int livello_1,int livello_2);
BST crea_BST();
int distanza(link x,link nodo_fittizio,char *chiave_di_ricerca);
link lettura(FILE *file,link x,link nodo_fittizio,int *max);
void libera_memoria(link x,link nodo_fittizio);
link nuovo_nodo(ITEM item,link parent,link left,link right,int livello);
link ricerca_nodo_comune(link x,link nodo_fittizio,char *chiave_di_ricerca_1,char *chiave_di_ricerca_2);
void specchia_albero(link x,link nodo_fittizio);
void stampa(FILE *file,link x,link nodo_fittizio);

#endif // BST_H_INCLUDED

BST.c:

#include "BST.h"
#include <limits.h>
#include <string.h>

struct node {
    int livello;
    ITEM item;
    link parent,left,right;
};
struct bst {
    int N;
    link head,nodo_fittizio;
};
static char buffer[MAXS];

int BSTcount(BST tree,int livello_1,int livello_2)
{
    int contatore;
    contatore=0;
    if((livello_1>tree->N)||(livello_2>tree->N)||(livello_1<0)||(livello_2<0)||(livello_1>livello_2)) {
        printf("DATA NOT VALID.\n");
        exit(-7);
    }
    conteggio(tree->head,tree->nodo_fittizio,&contatore,livello_1,livello_2);
    return contatore;
}
int BSTdistance(BST tree,char *chiave_1,char *chiave_2)
{
    int dist;
    link x;
    x=ricerca_nodo_comune(tree->head,tree->nodo_fittizio,chiave_1,chiave_2);
    if(x==tree->nodo_fittizio) {
        printf("DATA NOT VALID.\n");
        exit(-10);
    }
    dist=distanza(x,tree->nodo_fittizio,chiave_1)+distanza(x,tree->nodo_fittizio,chiave_2);
    return dist;
}
void BSTfree(BST tree)
{
    libera_memoria(tree->head,tree->nodo_fittizio);
    free(tree->nodo_fittizio);
    free(tree);
}
void BSTmirror(BST tree)
{
    specchia_albero(tree->head,tree->nodo_fittizio);
}
BST BSTreadPreorder(FILE *file)
{
    BST tree;
    int max;
    max=INT_MIN;
    tree=crea_BST();
    tree->head=lettura(file,tree->head,tree->nodo_fittizio,&max);
    tree->N=max;
    return tree;
}
void BSTwritePreorder(FILE *file,BST tree)
{
    stampa(file,tree->head,tree->nodo_fittizio);
}
void conteggio(link x,link nodo_fittizio,int *contatore,int livello_1,int livello_2)
{
    if(x!=nodo_fittizio) {
        if((x->right!=nodo_fittizio)&&(x->left!=nodo_fittizio)&&(x->livello>=livello_1)&&(x->livello<=livello_2)) {
            (*contatore)++;
        }
        conteggio(x->left,nodo_fittizio,contatore,livello_1,livello_2);
        conteggio(x->right,nodo_fittizio,contatore,livello_1,livello_2);
    }
}
BST crea_BST()
{
    BST tree;
    tree=(BST)malloc(sizeof(struct bst));
    if(tree==NULL) {
        printf("ALLOCATION ERROR.\n");
        exit(-5);
    }
    tree->N=0;
    tree->head=nuovo_nodo(crea_ITEM(),NULL,NULL,NULL,0);
    tree->nodo_fittizio=nuovo_nodo(crea_ITEM(),NULL,NULL,NULL,0);
    return tree;
}
int distanza(link x,link nodo_fittizio,char *chiave_di_ricerca)
{
    int j,dist;
    link tmp;
    if(x!=nodo_fittizio) {
        j=strcmp(chiave_di_ricerca,chiave(x->item));
        if(j==0) {
            return 0;
        }
        if(j<0) {
            tmp=x->left;
        } else {
            tmp=x->right;
        }
        dist=distanza(tmp,nodo_fittizio,chiave_di_ricerca)+1;
        return dist;
    }
    return 0;
}
link lettura(FILE *file,link x,link nodo_fittizio,int *max)
{
    int figlio_destro,figlio_sinistro;
    fscanf(file," %s %d %d %d",buffer,inserisci_numero(x->item),&figlio_destro,&figlio_sinistro);
    inserisci_chiave(x->item,buffer);
    if((x->livello)+1>*max) {
        *max=(x->livello)+1;
    }
    if(figlio_sinistro) {
        x->left=nuovo_nodo(crea_ITEM(),x,nodo_fittizio,nodo_fittizio,(x->livello)+1);
        x->left=lettura(file,x->left,nodo_fittizio,max);
    }
    if(figlio_destro) {
        x->right=nuovo_nodo(crea_ITEM(),x,nodo_fittizio,nodo_fittizio,(x->livello)+1);
        x->right=lettura(file,x->right,nodo_fittizio,max);
    }
    return x;
}
void libera_memoria(link x,link nodo_fittizio)
{
    if(x->left!=nodo_fittizio) {
        libera_memoria(x->left,nodo_fittizio);
    }
    if(x->right!=nodo_fittizio) {
        libera_memoria(x->right,nodo_fittizio);
    }
    free(chiave(x->item));
    free(x->item);
    free(x);
}
link nuovo_nodo(ITEM item,link parent,link left,link right,int livello)
{
    link x;
    x=(link)malloc(sizeof(struct node));
    if(x==NULL) {
        printf("ALLOCATION ERROR.\n");
        exit(-6);
    }
    x->item=item;
    x->parent=parent;
    x->left=left;
    x->right=right;
    x->livello=livello;
    return x;
}
link ricerca_nodo_comune(link x,link nodo_fittizio,char *chiave_di_ricerca_1,char *chiave_di_ricerca_2)
{
    int controllo_1,controllo_2;
    link tmp_1,tmp_2;
    if(x!=nodo_fittizio) {
        controllo_1=strcmp(chiave_di_ricerca_1,chiave(x->item));
        controllo_2=strcmp(chiave_di_ricerca_2,chiave(x->item));
        if((controllo_1==0)||(controllo_2==0)) {
            return x;
        }
        if(controllo_1<0) {
            tmp_1=x->left;
        } else {
            tmp_1=x->right;
        }
        if(controllo_2<0) {
            tmp_2=x->left;
        } else {
            tmp_2=x->right;
        }
        if(tmp_1==tmp_2) {
            return ricerca_nodo_comune(tmp_1,nodo_fittizio,chiave_di_ricerca_1,chiave_di_ricerca_2);
        }
    }
    return x;
}
void specchia_albero(link x,link nodo_fittizio)
{
    link tmp;
    if(x!=nodo_fittizio) {
        tmp=x->left;
        x->left=x->right;
        x->right=tmp;
        specchia_albero(x->left,nodo_fittizio);
        specchia_albero(x->right,nodo_fittizio);
    }
}
void stampa(FILE *file,link x,link nodo_fittizio)
{
    int i;
    for(i=0; i<x->livello; i++) {
        fprintf(file,"\t");
    }
    fprintf(file,"%s %d\n",chiave(x->item),numero(x->item));
    if(x->left!=nodo_fittizio) {
        stampa(file,x->left,nodo_fittizio);
    }
    if(x->right!=nodo_fittizio) {
        stampa(file,x->right,nodo_fittizio);
    }
}