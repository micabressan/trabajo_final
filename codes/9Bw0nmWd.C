#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct IMAGE_NB_E{
	char *	nom;
	int 	nbligne;
	int 	nbcolonne;
	int ** 	matrice;
}IMAGE_NB;


#define PARAM_BITS 8

//==================================================================================
//=									IMAGE N & B 								   =
//==================================================================================

int lectureFichier(char * s, FILE ** f, int * nbligne, int * nbcolonne, int * type){
	//printf("\n\nOuverture du fichier image");

	if((*f=fopen(s,"r")) == NULL)
	{
		printf("\n\nErreur Fatale a l'ouverture du fichier \n");
		return 0;
	}

	//Lecture colonne / ligne
	//Enlever les printf pour les débugs

	fscanf(*f,"%i ", nbligne);
	//printf("\n\nNombre de lignes: %i", nbligne);

	fscanf(*f,"%i ", nbcolonne);
	//printf("\n\nNombre de colonnes: %i", nbcolonne);

	fscanf(*f,"%i ", type);
	//printf("\n\nNiveau lu: %i", type);

	return 1;
}

IMAGE_NB * initImageNB(char * nom_e, int nbligne_e, int nbcolonne_e){

	//Malloc structure
	IMAGE_NB * retour = malloc(sizeof(retour));

	//Affectation des differentes valeurs de l'image
	retour->nbligne = nbligne_e;
	retour->nbcolonne = nbcolonne_e;
	retour->nom = nom_e;
	
	//Creation de la matrice image et affectation du pointeur dans la matrice
	int i;

	int ** matrice = malloc(sizeof(int*) * nbligne_e);
	for(i=0;i<retour->nbligne;i++){
		matrice[i] = malloc(sizeof(int) * nbcolonne_e);
	}
	retour->matrice = matrice;

	return retour;
}

void freeImage(IMAGE_NB * image){
	//free((*image).nom);
	int i;
	for(i=0;i<image->nbligne;i++){
		free(image->matrice[i]);
	}
	free(image->matrice);
	free(image);

}


void afficherImageNB(IMAGE_NB image){
	int i, j;
	printf("\n\nAffichage de la matrice :\n");
	printf("nbColonne:%d, nbLigne:%d\n", image.nbcolonne, image.nbligne);
	for(i=0;i<image.nbligne;i++)
	{
		for(j=0;j<image.nbcolonne;j++)
		{
			printf("%i ", image.matrice[i][j]);
		}
		printf("\n");
	}
	printf("\nFin Affichage matrice");	
}

int lectureImgageNB(IMAGE_NB image, FILE *f){
	int tempo, i, j, retour;
	for(i=0;i<image.nbligne;i++){
		for(j=0;j<image.nbcolonne;j++){
			retour = fscanf(f,"%i ",&tempo);
			if(retour == EOF)
			{
					printf("\nErreur fatale : Pas assez de valeurs dans l'image");
					return 0;
				
			}
			if((tempo > 255) || (tempo < 0))
			{
				printf("\nErreur fatale : Valeur incorrecte dans l'image");
				return 0;

			}
			image.matrice[i][j] = tempo;
		}
	}
	return 1;
}


int quantificationImageNB(IMAGE_NB image){
	int i, j;
	for(i=0;i<image.nbligne;i++){
		for(j=0;j<image.nbcolonne;j++){
			image.matrice[i][j] = image.matrice[i][j] >> (8-PARAM_BITS);
			image.matrice[i][j] = image.matrice[i][j] << (8-PARAM_BITS);
		}
	}
	return 1;
}

int creationDescripteur(IMAGE_NB image){

	FILE * descripteur =  fopen("test_descripteur","a+");

	//Cretion id
	fputs("<id>", descripteur);
	fputs(image.nom, descripteur);
	fputs("</id>\n", descripteur);

	/*
	  Creation de l'histogramme de valeurs: 

	  1. On alloue un espace mémoire d'une matrice 2dim x (nbcol * nbligne)
		=> On considére qu'il peut y avoir maximum de (nbcol * nbligne) valeurs différentes
		dans la matrice image 
		(en vérité, on pourrait diminuer l'espace mémoire en vérifiant le nb de bits de quantification,
		et en disant que si (nbcol * nbligne) > 2^nbit de quantification, on a alloue 2^nbit de quantification, 
		mais c'est "inutile" car on traite ici toujours le pire cas).
	  2. On parcours la matrice.
		=> La premiere colonne de "histogramme" corresponds aux valeurs
		=> La seconde colonne corresponds au nb d'occurences
			=> Si on trouve une occurence, on incrémente la seconde variable
	  3. Dès qu'on a traiter tous le tableau, on arrête.

	*/
	int max = image.nbligne * image.nbcolonne;
	int ** histogramme = malloc(sizeof(char*)*2);
	histogramme[0] = malloc(sizeof(int)* max);
	histogramme[1] = malloc(sizeof(int)* max);

	int i, j, k;
	int nbvaleur = 0;


	unsigned char valeur;
	//Init
	for(i=0;i<2;i++)
	{
		for(j=0;j<max;j++)
		{
			histogramme[i][j] = -1;
		}
	}


	//Parcourir matrice
	
	for(i=0;i<image.nbligne;i++)
	{
		for(j=0;j<image.nbcolonne;j++)
		{
			valeur = image.matrice[i][j];
			//printf("\nvaleur :%d",valeur);
			for(k=0;k<max;k++){
			//On regarde d'abord si on voit valeur, puis ensuite si on voit 0
				if(histogramme[0][k] == valeur)
				{
					histogramme[1][k] += 1;
					//printf("\nhistogramme:%d:%d, valeur: %d",histogramme[0][k],histogramme[0][k],valeur);
					break;
				}
				if(histogramme[0][k] == -1)
				{
					histogramme[0][k] = valeur;
					histogramme[1][k] = 1;
					nbvaleur += 1;
					//printf("\nhistogralmme init :%d",histogramme[1][k]);
					break;
				}
			}
		}

	}

	//Mise en forme des valeurs
	fputs("<valeurs>\n", descripteur);


	int valmin = 0x7FFFFFFF;
	int indicemin = 0;
	int valprec = -1;

	for(i=0;i<nbvaleur;i++)
	{
		valmin = 0x7FFFFFFF;
		for(j=0;j<nbvaleur;j++)
		{
			// On check si 
			//  1. Val min (censé être la val min de la plage) est bien minimum
			//  2. On est bien supérieur à la val précédente
			if((valmin>histogramme[0][j]) && (valprec < histogramme[0][j]))
				{
					valmin = histogramme[0][j];
					indicemin = j;
				}
		}
		valprec = valmin;
		if(histogramme[0][indicemin]<16)
			fprintf(descripteur, "0x0%1x: %i;\n", histogramme[0][indicemin], histogramme[1][indicemin]);
		else
			fprintf(descripteur, "0x%2x: %i;\n", histogramme[0][indicemin], histogramme[1][indicemin]);	
	}

	fputs("</valeurs>\n\n", descripteur);
	free(histogramme[0]);
	free(histogramme[1]);
	free(histogramme);
	fclose(descripteur);
	return 1;
} 



void indexImageNB(){
	remove("test_descripteur");
	FILE * p;
	FILE * f = NULL;
	char * res = malloc(sizeof(char));
	//p = popen("ls TEST_NB/ | grep .txt |  sed -i -e 's#^#/TEST_NB#'", "r");
	p = popen("ls TEST_NB/ | grep .txt ", "r");

	IMAGE_NB * image1; 
	int nbligne, nbcolonne, type;


	while (fscanf(p,"%s",res) == 1) {
	 	printf("%s\n",res );
	 	lectureFichier(res,&f,&nbligne,&nbcolonne,&type);
	 	printf("a\n");
		fflush(stdout);
	  	image1 = initImageNB(res,nbligne,nbcolonne);
	  	printf("b\n");
		fflush(stdout);
		lectureImgageNB(*image1,f);
		printf("c\n");
		fflush(stdout);
		quantificationImageNB(*image1);
		printf("d\n");
		fflush(stdout);
		creationDescripteur(*image1);
		printf("e\n");
		fflush(stdout);
		fclose(f);
		free(image1);
		printf("Fichier traite\n");
		fflush(stdout);
	}

}









//==================================================================================
//=										Main 									   =
//==================================================================================

int main(){


// ====================================
// =              Test 1              =
// ====================================

/*
remove("test_descripteur");


printf("\n\nDebut du programme");

FILE *f=NULL;

int nbcolonne, nbligne,type;
lectureFichier("TEST_NB/51.txt",&f,&nbligne,&nbcolonne,&type);
IMAGE_NB * image1 = initImageNB("51.txt",nbligne,nbcolonne);
lectureImgageNB(*image1,f);
//afficherImageNB(*image1);
quantificationImageNB(*image1);
//afficherImageNB(*image1);
creationDescripteur(*image1);
freeImage(image1);

*/



// ====================================
// =              Test 2              =
// ====================================

/*
printf("\n\nDebut du programme");

FILE *f=NULL;
int nbcolonne, nbligne,type;

int i;
char * fichier[13];
fichier[0] = "TEST_NB/51.txt";
fichier[1] = "TEST_NB/52.txt"; 
fichier[2] = "TEST_NB/53.txt";
fichier[3] = "TEST_NB/54.txt"; 
fichier[4] = "TEST_NB/55.txt"; 
fichier[5] = "TEST_NB/56.txt";
fichier[6] = "TEST_NB/57.txt"; 
fichier[7] = "TEST_NB/58.txt"; 
fichier[8] = "TEST_NB/59.txt";
fichier[9] = "TEST_NB/60.txt";
fichier[10] = "TEST_NB/61.txt";
fichier[11] = "TEST_NB/62.txt";
fichier[12] = "TEST_NB/63.txt";

IMAGE_NB * image1; 

for(i=0;i<13;i++)
{
	lectureFichier(fichier[i],&f,&nbligne,&nbcolonne,&type);
	image1 = initImageNB(fichier[i],nbligne,nbcolonne);
	lectureImgageNB(*image1,f);
	quantificationImageNB(*image1);
	creationDescripteur(*image1);
	fclose(f);
	free(image1);
	printf("\nFichier %d traite",i);
	fflush(stdout);
}
printf("\n\n");
*/

// ====================================
// =              Test 3              =
// ====================================

 indexImageNB();
 

return EXIT_SUCCESS;
}