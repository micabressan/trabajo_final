#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
struct date{
        short day;
        short month;
        short year;
};

struct indicator{
	int NextOccupied;
	int NextEmpty;
};

struct reference{
        long idReference;
        char name[50];
        char millesime[5];
        char appelation[40];
        char region[40];
        char pays[30];
        char couleur[30];
        char producteur[50];
        int format;
        int degreeAlcool;
};

struct refIndex{
	long idReference;
	char name[50];
	char millesime[5];
	long posinFile;
};

struct vendre{
        long idReference;
        long idFournisseur;
        struct date date;
        float prix;
        int quantite;
};

struct fournisseur{
        long idFournisseur;
        char nomFournisseur;
        char rue[50];
        int codePostal;
        char ville[20];
        char pays[30];
        char email[50];
        char website[50];
        char telephone[12];
};

void MenuRef(struct refIndex *MainIndex,int NumberOfElements);
void MenuFour();
void MenuVendre();
int DoesFileExist(char *);
int initRef(struct refIndex *index);
//struct indicator initFour();
void initFour();
struct refIndex *InsertInIndex(struct refIndex *index,struct reference *ref,int position);
void CopyStructIndex(struct refIndex *, struct refIndex *);
void SortIndex(struct refIndex *index,int NumberOfRef);
void CreateRef(struct reference *dummy,struct refIndex *index,int NumberOfElements,int IsModification,int ElementChanged);
void InsertRefInFile(struct reference *reftoinsert,long position);
struct reference ObtainRefFromFile(long position);
void DisplayReference(struct reference *temp);


int main()
{
        int stop=0,choice;
        int NumberOfRef;
        struct refIndex *aMainIndex=(struct refIndex*) malloc(5000 * sizeof(struct refIndex));
        //struct indicator defaultFour;
        NumberOfRef=initRef(&aMainIndex[0]);
        SortIndex(aMainIndex,NumberOfRef);
        initFour();
        while(!stop){
                //Main menu
                stop=0;
                //system("cls");
                printf("MAIN MENU:\n");
                printf("1.Menu references\n");
                printf("2.Menu fournisseurs \n");
                printf("3.Menu vendre\n");
                printf("4.Quitter le programme\n");
                fflush(stdin);
                scanf("%d",&choice);
                //Main program
                if(choice==4)
                        //end
                        stop=1;
                if(choice<1 || choice>4)
                        printf("Choisissez un numero valide.\n");
                else{
                        switch(choice){
                                //Menu references
                                case 1:
                                        MenuRef(aMainIndex,NumberOfRef);
                                        break;

                                //Menu fournisseurs
                                case 2:
                                        MenuFour();
                                        break;

                                //Menu vendre
                                case 3:
                                        MenuVendre();
                                        break;
                        }
                }
        }
        return 0;
}

void MenuRef(struct refIndex *MainIndex,int NumberOfElements){
        int stop=0,choice;
        int i;
        struct reference temp;
        struct refIndex *startingpoint=MainIndex;
        FILE* references;
        while(!stop){
                printf("MENU REFERENCES:\n");
                printf("1.Ajout reference\n");
                printf("2.Modification reference \n");
                printf("3.Suppression reference\n");
                printf("4.Afficher references\n");
                printf("5.Menu principal\n");
                fflush(stdin);
                scanf("%d",&choice);
                if(choice==5)
                        //end
                        stop=1;
                if(choice<1 || choice>5)
                        printf("Choisissez un numero valide.\n");
                else{
                        switch(choice){
                        //Ajout reference
                        case 1:
                                CreateRef(&temp,MainIndex,NumberOfElements,0,0);
                                InsertRefInFile(&temp,NumberOfElements * sizeof(struct reference));
                                InsertInIndex(MainIndex,&temp,NumberOfElements);
                                SortIndex(MainIndex,NumberOfElements);
                                NumberOfElements++;
                                printf("La reference a ete inseree.\n");
                                break;

                        //Modification reference
                        case 2:
                                printf("Choisissez un champ a modifier.\n");
                                printf("1.Id.\n");
                                printf("2.Nom.\n");
                                printf("3.Millesime.\n");
                                printf("4.Appelation.\n");
                                printf("5.Region.\n");
                                printf("6.Pays.\n");
                                printf("7.Couleur.\n");
                                printf("8.Producteur.\n");
                                printf("9.Format.\n");
                                printf("10.Degree alcool.\n");
                                printf("0.Annuler.\n");
                                fflush(stdin);
                                scanf("%d",&choice);
                                if(choice!=0){
                                        CreateRef(&temp,MainIndex,NumberOfElements,1,choice);
                                        InsertRefInFile(&temp,NumberOfElements * sizeof(struct reference));
                                        InsertInIndex(MainIndex,&temp,NumberOfElements++);
                                        SortIndex(MainIndex,NumberOfElements);
                                        printf("La reference a ete modifiee et inseree.\n");
                                }
                                break;
                        //Suppression reference
                        case 3:

                                break;

                        //Affichage reference
                        case 4:
                                stop=0;
                                references=fopen("references.dat","rb");
                                for(i=0;i<NumberOfElements && !stop;i++){
                                        fseek(references,MainIndex->posinFile,SEEK_SET);
                                        fread(&temp,sizeof(struct reference),1,references);
                                        DisplayReference(&temp);
                                        printf("Continuer?\n1.Oui\n2.Non\n");
                                        fflush(stdin);
                                        scanf("%d",&choice);
                                        if(choice==2)
                                                stop=1;
                                        else
                                                MainIndex++;
                                }
                                printf("Affichage finit.\n");
                                break;
                        }
                        MainIndex=startingpoint;
                }
        }
}

void MenuFour(){
        int stop=0,choice;
        while(!stop){
                printf("MENU FOURNISSEURS:\n");
                printf("1.Ajout fournisseur\n");
                printf("2.Modification fournisseur\n");
                printf("3.Afficher fournisseurs\n");
                printf("4.Rechercher fournisseur par pays\n");
                printf("5.Menu principal\n");
                fflush(stdin);
                scanf("%d",&choice);
                if(choice==5)
                        //end
                        stop=1;
                if(choice<1 || choice>5)
                        printf("Choisissez un numero valide.\n");
                else{

                }
        }
}

void MenuVendre(){
        int stop=0,choice;
        while(!stop){
                printf("MENU VENDRE:\n");
                printf("1.Ajout fiche d'achat\n");
                printf("2.Afficher le fichier\n");
                printf("3.Afficher les vins\n");
                printf("4.Menu principal\n");
                fflush(stdin);
                scanf("%d",&choice);
                if(choice==4)
                        //end
                        stop=1;
                if(choice<1 || choice>4)
                        printf("Choisissez un numero valide.\n");
                else{

                }
        }
}

//Fonction qui vérifie l'existence d'un fichier
int DoesFileExist(char *filename)
{
	FILE* temp;
	temp=fopen(filename,"rb");
	if(temp==NULL){
		fclose(temp);
		return 0;
	}
	fclose(temp);
	return 1;
}

//Fonction qui crée un index au début du programme
int initRef(struct refIndex *index){
	struct reference ref;
	int i,numberofelements = 0;
	FILE *file;
	if(DoesFileExist("references.dat")){
		printf("Ouverture du fichier reference...\n");
		file = fopen("references.dat", "rb");
		for(i=0;i<5000;i++){
			fread(&ref, sizeof(struct reference), 1, file);
			if(ref.idReference != -1){
				index=InsertInIndex(index,&ref,i);
				numberofelements++;
			}
		}
                printf("Index cree.\n");
	}else{
		printf("Creation du fichier reference ...\n");
		file = fopen("references.dat", "wb");
		ref.idReference = -1;
		fwrite(&ref, sizeof(struct reference), 5000, file);
		for(i=0;i<5000;i++){
      index->idReference = -1;
      index->posinFile = sizeof(struct reference) * i;
      index++;
		}
	}
	fclose(file);
	return numberofelements;
}

//Fonction qui se charge du fichier fournisseur et renvoie PTO/PTL du fichier
//struct indicator initFour(){
void initFour(){
	struct fournisseur dummy;
	struct indicator indic;
	FILE *file;
	int i;

	if(DoesFileExist("fournisseurs.dat")){
		printf("Ouverture du fichier fournisseurs ...\n");
		file = fopen("fournisseurs.dat","rb");
		fread(&indic.NextOccupied,sizeof(int),1,file);
		fread(&indic.NextEmpty,sizeof(int),1,file);
	}else{
		printf("Creation du fichier fournisseurs ...\n");
		indic.NextOccupied = -1;
		indic.NextEmpty = -1;
		dummy.idFournisseur = -1;
		file = fopen("fournisseurs.dat","wb");
		fwrite(&indic.NextOccupied,sizeof(int),2,file);
		for(i=0;i<100;i++){
			fwrite(&dummy,sizeof(struct fournisseur),1,file);
			fwrite(&indic.NextOccupied,sizeof(int),1,file);
		}
	}
	fclose(file);
	//return indic;
  return;
}

struct refIndex *InsertInIndex(struct refIndex *index,struct reference *ref,int position){
        struct refIndex index_ref;
        index_ref.idReference = ref->idReference;
        strcpy(index_ref.name,ref->name);
        strcpy(index_ref.millesime,ref->millesime);
        index_ref.posinFile = position*sizeof(struct reference);
        *(index+position) = index_ref;
        return index;
}

void SortIndex(struct refIndex *index,int NumberOfRef){
        int i,j;
        struct refIndex temp;
        for(i=NumberOfRef;i>0;i--){
                for(j=0;j<i-1;j++){
                        if (index->idReference!=-1 && strcmp(index->name,(index+1)->name)>0){
                                CopyStructIndex(&temp,index);
                                CopyStructIndex(index,index+1);
                                CopyStructIndex(index+1,&temp);
                                index++;
                        }
                }
        }
}

void CopyStructIndex(struct refIndex *dest, struct refIndex *src)
{
	dest->idReference=src->idReference;
	strcpy(dest->millesime,src->millesime);
	strcpy(dest->name,src->name);
	dest->posinFile=src->posinFile;
}

void CreateRef(struct reference *dummy,struct refIndex *index,int NumberOfElements,int IsModification,int ElementChanged){
        int stop=0,i;
        char *couleur[6]={"rouge","blanc","rose","rouge moelleux","blanc moelleux","effervescent"};
        /*Ref*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==1))){
                stop=1;
                printf("Numero de la reference: ");
                fflush(stdin);
                scanf("%ld",&(dummy->idReference));
                if(dummy->idReference<0){
                        stop=0;
                        printf("Le numero de reference est invalide. Veuillez reessayer.\n");
                }else{
                        for(i=0;i < NumberOfElements;i++){
                                if((index+i)->idReference == dummy->idReference){
                                        printf("Le numero de reference est deja utilise. Veuillez reessayer.\n");
                                        stop=0;
                                        i=NumberOfElements;
                                }
                        }
                }
        }
        stop=0;

        /*nom*/

        while(!stop && (!IsModification || (IsModification && ElementChanged==2))){
                stop=1;
                printf("Nom de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->name);
                for(i=0;i<50 && dummy->name[i]!='\0';i++){
                        if(!isalpha((int)(dummy->name[i]))){
                                i=50;
                                printf("Nom invalide, veuillez reessayer.\n");
                                stop=0;
                        }
                }
        }
        stop=0;

        /*millesime*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==3))){
                stop=1;
                printf("Millesime de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->millesime);
                for(i=0;i<5 && dummy->millesime[i]!='\0';i++){
                        if(!isdigit((int)(dummy->millesime[i]))){
                                stop=0;
                                printf("Millesime invalide, veuillez reessayer.\n");
                                i=5;
                        }
                }
        }
        stop=0;

        /*Appelation*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==4))){
                stop=1;
                printf("Appelation de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->appelation);
                for(i=0;i<40 && dummy->appelation[i]!='\0';i++){
                        if(!isalpha((int)(dummy->appelation[i]))){
                                i=50;
                                printf("Appelation invalide, veuillez reessayer.\n");
                                stop=0;
                        }
                }
        }
        stop=0;

        /*Region*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==5))){
                stop=1;
                printf("Region de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->region);
                for(i=0;i<40 && dummy->region[i]!='\0';i++){
                        if(!isalpha((int)(dummy->region[i]))){
                                i=50;
                                printf("Region invalide, veuillez reessayer.\n");
                                stop=0;
                        }
                }
        }
        stop=0;

        /*Pays*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==6))){
                stop=1;
                printf("Pays de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->pays);
                for(i=0;i<30 && dummy->pays[i]!='\0';i++){
                        if(!isalpha((int)(dummy->pays[i]))){
                                i=50;
                                printf("Pays invalide, veuillez reessayer.\n");
                                stop=0;
                        }
                }
        }
        stop=0;

        /*couleur*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==7))){
                printf("Couleur de la reference (rouge, blanc, rose, rouge moelleux, blanc moelleux ou effervescent): ");
                fflush(stdin);
                scanf("%s",dummy->couleur);
                for(i=0;i<6;i++){
                        if(strcmp(dummy->couleur,couleur[i])==0){
                                stop=1;
                                i=6;
                        }
                }
                if(!stop)
                        printf("La couleur entree n'existe pas, veuillez reessayer.\n");
        }
        stop=0;

        /*producteur*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==8))){
                stop=1;
                printf("Producteur de la reference: ");
                fflush(stdin);
                scanf("%s",dummy->producteur);
                for(i=0;i<50 && dummy->producteur[i]!='\0';i++){
                        if(!isalpha((int)(dummy->producteur[i]))){
                                i=50;
                                printf("Producteur invalide, veuillez reessayer.\n");
                                stop=0;
                        }
                }
        }
        stop=0;

        /*format*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==9))){
                stop=1;
                printf("Format de la reference (en cl): ");
                fflush(stdin);
                scanf("%d",&dummy->format);
                if(dummy->format<0){
                        stop=0;
                        printf("Format invalide, veuillez reessayer.");
                }
        }
        stop=0;

        /*degree*/
        while(!stop && (!IsModification || (IsModification && ElementChanged==10))){
                stop=1;
                printf("Teneur en alcool: ");
                fflush(stdin);
                scanf("%d",&dummy->degreeAlcool);
                if(dummy->degreeAlcool<0 || dummy->degreeAlcool>100){
                        stop=0;
                        printf("Teneur en alcool invalide, veuillez reessayer.");
                }
        }

}

void InsertRefInFile(struct reference *reftoinsert,long position){
        FILE* temp;
        temp=fopen("references.dat","wb");
        fseek(temp,position,SEEK_SET);
        fwrite(reftoinsert,sizeof(struct reference),1,temp);
        fclose(temp);
}

struct reference ObtainRefFromFile(long position){
        struct reference temp;
        FILE* references;
        references=fopen("references.dat","rb");
        fseek(references,position,SEEK_SET);
        fread(&temp,sizeof(struct reference),1,references);
        fclose(references);
        return temp;
};

void DisplayReference(struct reference *temp){
        printf("Id: %ld\n",temp->idReference);
        printf("Nom: %s\n",temp->name);
        printf("Millesime: %s\n",temp->millesime);
        printf("Appelation: %s\n",temp->appelation);
        printf("Region: %s\n",temp->region);
        printf("Pays: %s\n",temp->pays);
        printf("Couleur: %s\n",temp->couleur);
        printf("Producteur: %s\n",temp->producteur);
        printf("Format: %d\n",temp->format);
        printf("Degree alcool: %d\n",temp->degreeAlcool);
}