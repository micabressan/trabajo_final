#include<stdio.h>
#include<stdlib.h>
#include "liste.h"

node_t* list_create(void){
    node_t* node=NULL;
    //if(node==NULL) return NULL;
    /*node->valeur = (void*)malloc(sizeof(void));
    if(node->valeur==NULL){
        free(node);
        return NULL;
    }*/
    return node;
}

void* list_get_data(const node_t* node){
    if(node==NULL) return NULL;
    return node->valeur;
}

void* list_set_data(node_t* node, void* data){
    if(node==NULL) return NULL;
    node->valeur = data;
	return node->valeur;
}

node_t* list_insert(node_t* head, void* data){ // ajout au début de la liste
    node_t* nouvelHead = (node_t*)malloc(sizeof(node_t));
    if(nouvelHead==NULL) return NULL; // on a échoué d'allouer
    	//list_set_data(nouvelHead, data);	
	nouvelHead->valeur = data;
    nouvelHead->eltSuivant = head;
    return nouvelHead;
}

node_t* list_append(node_t* head, void* data){ // ajout à la fin de la liste
    node_t* finNode = (node_t*)malloc(sizeof(node_t));
    if(finNode==NULL) return NULL; // on a échoué d'allouer
    finNode->valeur = data;
	//list_set_data(finNode, data);
    finNode->eltSuivant = NULL;
    if(head==NULL) return finNode; // si la liste est vide
    node_t* tmp = head;
    while(tmp->eltSuivant!=NULL)
        tmp = tmp->eltSuivant;
    //while((tmp=head->eltSuivant)!=NULL) // on parcour jusqu'à le dernier elt
    tmp->eltSuivant = finNode;
    return head;
}

node_t* list_remove(node_t* head, void* data){
    if(head==NULL) return NULL; // la liste est vide, on a rien à supprimer
    node_t* tmp = head;
    node_t* supp;
    if(head->valeur==data){
        head = tmp->eltSuivant;
        free(tmp);
        return head;
    }
    while(tmp->eltSuivant!=NULL){
        if((tmp->eltSuivant)->valeur == data){
            supp = tmp->eltSuivant;
            tmp->eltSuivant = (tmp->eltSuivant)->eltSuivant;
            free(supp);
            return head;
        }
        tmp = tmp->eltSuivant;
    }
    return NULL; // ici j'ai po trouvé l'element passé par param data
}

node_t* list_headRemove(node_t* head){
    if(head==NULL) return NULL;
    node_t* tmp = head->eltSuivant;
    free(head);
    return tmp;
}

node_t* list_destroy(node_t* head){
    if(head==NULL) return NULL;
    list_destroy(head->eltSuivant);
    free(head);
	head = NULL;
	return head;
}